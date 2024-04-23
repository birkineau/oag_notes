import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

import '../future_calls/future_calls.dart';
import '../scopes/user_scope.dart';

/// TODO: Microsoft and Google email providers.
class AccountEndpoint extends Endpoint {
  Future<void> createAccountFromFirebaseIdToken(
    Session session,
    String idToken,
  ) async {
    final token = await firebaseAuth.verifyIdToken(idToken, true);
    final claims = token.claims;
    final userIdentifier = claims.subject;
    final email = claims.email?.toLowerCase();

    if (email == null) {
      throw EmailValidationException(
        email: claims.subject,
        message: "Unable to link Firebase user. Email not found in claims.",
      );
    }

    if (await Users.findUserByEmail(session, email) case final UserInfo _) {
      throw EmailValidationException(
        email: email,
        message: "User account linked to Firebase already exists.",
      );
    }

    var userInfo = UserInfo(
      userIdentifier: userIdentifier,
      userName: "",
      email: email,
      created: DateTime.now().toUtc(),
      imageUrl: claims.picture?.toString(),
      scopeNames: [UserScope.unverified.name!],
      blocked: false,
    );

    userInfo = await UserInfo.db.insertRow(session, userInfo);

    print("Succesfully linked Firebase user '$email' @ '${DateTime.now()}'");
  }

  Future<void> processAccountValidation(
    Session session,
    String email,
    String code,
  ) async {
    final userInfo = await _getExistingUserInfoByEmail(session, email);
    final validationCode = await ValidationCode.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userInfo.id),
    );

    if (validationCode == null) {
      throw EmailValidationException(
        email: email,
        message: "Validation code not found. Request a new code.",
      );
    }

    final passwordUpdate = await PasswordUpdate.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userInfo.id),
    );

    if (passwordUpdate != null &&
        passwordUpdate.validationCodeId == validationCode.id) {
      throw EmailValidationException(
        email: email,
        message: "This code belongs to a different request. "
            "Request a new code.",
      );
    }

    final isValidationCodeExpired =
        DateTime.now().toUtc().difference(validationCode.created) >=
            ValidationCodeDeletion.validationCodeDuration;

    if (isValidationCodeExpired) {
      await _unscheduleAndDeleteValidationCode(session, validationCode);

      throw EmailValidationException(
        email: email,
        message: "Validation code expired. Request a new code.",
      );
    }

    if (validationCode.value != code) {
      throw EmailValidationException(
        email: email,
        message: "Validation code mismatch. Verify the code and try again.",
      );
    }

    try {
      await Future.wait(
        [
          firebaseAuth.updateUser(userInfo.userIdentifier, emailVerified: true),
          _unscheduleAndDeleteValidationCode(session, validationCode),
          Users.updateUserScopes(session, userInfo.id!, {UserScope.verified}),
        ],
      );

      print(
        "Validated user '$email' with code '${validationCode.value}' "
        "@ '${DateTime.now()}'",
      );
    } catch (e) {
      throw EmailValidationException(
        email: email,
        message: "Failed to validate email: $e",
      );
    }
  }

  Future<void> processPasswordUpdate(
    Session session,
    String email,
    String newPassword,
    String code,
  ) async {
    final userInfo = await _getExistingUserInfoByEmail(session, email);

    final passwordUpdate = await PasswordUpdate.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userInfo.id),
    );

    /// Ensure there's an existing password update request for this user.
    if (passwordUpdate == null) {
      throw EmailValidationException(
        email: email,
        message: "Password update entry not found. Try again.",
      );
    }

    /// Get the associated validation code for the password update request.
    final validationCode = await ValidationCode.db.findById(
      session,
      passwordUpdate.validationCodeId,
    );

    if (validationCode == null) {
      throw StateError(
        "Password update does not have an associated validation code.",
      );
    }

    final isPasswordUpdateValidationCodeExpired =
        DateTime.now().toUtc().difference(validationCode.created) >=
            PasswordUpdateDeletion.validationCodeDuration;

    /// If the validation code is expired, but has not yet been deleted by the
    /// deletion future call, delete it and cancel the deletion future call.
    if (isPasswordUpdateValidationCodeExpired) {
      await _unscheduleAndDeletePasswordUpdate(
        session,
        passwordUpdate,
        validationCode,
      );

      throw EmailValidationException(
        email: email,
        message: "Password update code expired. Request a new code.",
      );
    }

    if (validationCode.value != code) {
      throw EmailValidationException(
        email: email,
        message: "Password update code mismatch. "
            "Verify the code and try again.",
      );
    }

    try {
      await Future.wait(
        [
          _unscheduleAndDeletePasswordUpdate(
            session,
            passwordUpdate,
            validationCode,
          ),
          firebaseAuth.updateUser(
            userInfo.userIdentifier,
            password: newPassword,
            emailVerified: true,
          ),
        ],
      );

      print("Updated account password for '$email'");

      if (userInfo.scopes.contains(UserScope.verified)) {
        return;
      }

      await Users.updateUserScopes(session, userInfo.id!, {UserScope.verified});

      print("Verified user account '$email'");
    } catch (e) {
      throw EmailValidationException(
        email: email,
        message: "Failed to update password: $e",
      );
    }
  }

  Future<void> requestAccountValidation(
    Session session,
    String email,
  ) async {
    final userInfo = await _getExistingUserInfoByEmail(session, email);

    var validationCode = await ValidationCode.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userInfo.id),
    );

    /// If there's no validation code for the user, create a new one.
    if (validationCode == null) {
      validationCode = await ValidationCode.db.insertRow(
        session,
        ValidationCode(
          userId: userInfo.id!,
          value: _generateValidationCodeValue(),
          created: DateTime.now().toUtc(),
        ),
      );
    } else {
      /// Prevent the creation of a new validation code if the previous one
      /// was created recently.
      if (_isValidationCodeRecentlySent(validationCode)) {
        throw EmailValidationException(
          email: email,
          message: "Validation code was sent recently. Please wait a few "
              "seconds before requesting a new one.",
        );
      }

      await ValidationCodeDeletion.unschedule(session, validationCode);

      validationCode = await ValidationCode.db.updateRow(
        session,
        validationCode.copyWith(
          value: _generateValidationCodeValue(),
          created: DateTime.now().toUtc(),
        ),
      );
    }

    final sendEmail = _sendEmail(
      toEmail: email,
      subject: "Account validation code for Notes App",
      html: "Your account must be validated in order to sign in.<br><br>"
          "Your validation code is:"
          "<h2>${validationCode.value}</h2>",
    );

    /// If there is an error sending the email, delete the validation code,
    /// and cancel the future call to delete it on expiration.
    if (await sendEmail case String error) {
      await ValidationCode.db.deleteRow(session, validationCode);
      throw EmailValidationException(email: email, message: error);
    }

    await ValidationCodeDeletion.schedule(session, validationCode);

    print(
      "Created user validation code '${validationCode.value}' for '$email' "
      "@ '${DateTime.now()}'",
    );
  }

  Future<void> requestPasswordUpdate(
    Session session,
    String email,
  ) async {
    final userInfo = await _getExistingUserInfoByEmail(session, email);

    /// Check if there's an existing password update request for the user.
    var passwordUpdate = await PasswordUpdate.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userInfo.id),
    );

    late ValidationCode validationCode;

    /// If there's no password update request for the user, create a new one.
    if (passwordUpdate == null) {
      await session.dbNext.transaction(
        (transaction) async {
          final existingValidationCode = await ValidationCode.db.findFirstRow(
            session,
            where: (t) => t.userId.equals(userInfo.id),
          );

          /// A validation code might have been created by an account validation
          /// request. If so, use that code for the password update.
          if (existingValidationCode != null) {
            /// Since this code is not being used for account validation, it
            /// should not be deleted when it expires.
            await ValidationCodeDeletion.unschedule(
              session,
              existingValidationCode,
            );

            validationCode = await ValidationCode.db.updateRow(
              session,
              existingValidationCode.copyWith(
                value: _generateValidationCodeValue(),
                created: DateTime.now().toUtc(),
              ),
            );
          } else {
            /// Otherwise, create a new validation code.
            validationCode = await ValidationCode.db.insertRow(
              session,
              ValidationCode(
                userId: userInfo.id!,
                value: _generateValidationCodeValue(),
                created: DateTime.now().toUtc(),
              ),
            );
          }

          passwordUpdate = await PasswordUpdate.db.insertRow(
            session,
            PasswordUpdate(
              userId: userInfo.id!,
              validationCodeId: validationCode.id!,
            ),
          );
        },
      );

      print(
        "Created password update request for '$email' with code "
        "'${validationCode.value}' @ '${DateTime.now()}'",
      );
    } else {
      final existingValidationCode = await ValidationCode.db.findById(
        session,
        passwordUpdate.validationCodeId,
      );

      if (existingValidationCode == null) {
        throw StateError("Password update request has no associated code.");
      }

      validationCode = existingValidationCode;

      if (_isValidationCodeRecentlySent(validationCode)) {
        throw EmailValidationException(
          email: email,
          message: "Password update code was sent recently. "
              "Please wait a few seconds before requesting a new one.",
        );
      }

      /// If there's an existing password update, there is a scheduled future
      /// call to delete it and the associated validation code.
      ///
      /// Cancel that scheduled deletion so that the updated validation code can
      /// be rescheduled for deletion using a new expiration time.
      await PasswordUpdateDeletion.unschedule(session, passwordUpdate);

      validationCode = await ValidationCode.db.updateRow(
        session,
        validationCode.copyWith(
          value: _generateValidationCodeValue(),
          created: DateTime.now().toUtc(),
        ),
      );

      print(
        "Updated password update validation code to ${validationCode.value} "
        "for '$email' @ '${DateTime.now()}'",
      );
    }

    final sendEmail = _sendEmail(
      toEmail: email,
      subject: "Password update code for Notes App",
      html: "Your password update request must be validated.<br><br>"
          "Your password update code is:"
          "<h2>${validationCode.value}</h2>",
    );

    /// If there's an error sending the email, delete the password update
    /// request and the associated validation code.
    ///
    /// There are no scheduled deletion future calls at this point because:
    ///
    /// * We are creating a new password update; which has no prior scheduled
    /// future deletion calls.
    /// * The previous scheduled deletion was unscheduled before updating the
    /// associated validation code.
    if (await sendEmail case String error) {
      await session.dbNext.transaction(
        (transaction) async {
          await PasswordUpdate.db.deleteRow(session, passwordUpdate!);
          await ValidationCode.db.deleteRow(session, validationCode);
        },
      );

      throw EmailValidationException(email: email, message: error);
    }

    /// At this point, there are no scheduled future calls to delete the current
    /// password update request and validation code. Create a new future call
    /// to delete them when the validation code expires.
    await PasswordUpdateDeletion.schedule(
      session,
      passwordUpdate!,
      validationCode,
    );

    print(
      "Sent password update code '${validationCode.value}' to '$email'",
    );
  }

  Future<FirebaseSignIn> signInFirebaseUser(
    Session session,
    String email,
  ) async {
    final authKeySalt = session.passwords["authKeySalt"];

    if (authKeySalt == null) {
      throw EmailValidationException(
        email: email,
        message: "Unable to sign in. Missing authentication key salt.",
      );
    }

    final userInfo = await _getExistingUserInfoByEmail(session, email);
    final key = _generateRandomString();
    final authKey = AuthKey(
      userId: userInfo.id!,
      hash: _hashString(authKeySalt, key),
      key: key,
      scopeNames: userInfo.scopeNames,
      method: "firebase",
    );

    final result = await AuthKey.db.insertRow(session, authKey);

    print("Signed in Firebase user '$email' @ '${DateTime.now()}'");

    return FirebaseSignIn(userInfo: userInfo, keyId: result.id!, key: key);
  }

  Future<UserInfo> _getExistingUserInfoByEmail(
    Session session,
    String email,
  ) async {
    final findUserByEmail = Users.findUserByEmail(session, email);

    if (await findUserByEmail case final UserInfo userInfo) {
      return userInfo;
    }

    throw EmailValidationException(
      email: email,
      message: "User account does not exist.",
    );
  }

  Future<void> _unscheduleAndDeleteValidationCode(
    Session session,
    ValidationCode validationCode,
  ) {
    return session.dbNext.transaction(
      (transaction) async {
        final unschedule = ValidationCodeDeletion.unschedule(
          session,
          validationCode,
        );

        await ValidationCode.db.deleteRow(session, validationCode);
        await unschedule;
      },
    );
  }

  Future<void> _unscheduleAndDeletePasswordUpdate(
    Session session,
    PasswordUpdate passwordUpdate,
    ValidationCode validationCode,
  ) {
    return session.dbNext.transaction(
      (transaction) async {
        final unschedule = PasswordUpdateDeletion.unschedule(
          session,
          passwordUpdate,
        );

        await PasswordUpdate.db.deleteRow(session, passwordUpdate);
        await ValidationCode.db.deleteRow(session, validationCode);
        await unschedule;
      },
    );
  }

  bool _isValidationCodeRecentlySent(ValidationCode validationCode) {
    return DateTime.now().toUtc().difference(validationCode.created) <
        _validationCodeCooldown;
  }

  Future<String?> _sendEmail({
    required String toEmail,
    required String subject,
    required String html,
  }) async {
    try {
      final message = Message()
        ..from = smtpServer.username!
        ..recipients.add(toEmail)
        ..subject = subject
        ..html = html;

      await send(message, smtpServer);

      return null;
    } on MailerException catch (e) {
      return "Failed to send validation email. Problems:\n"
          "${e.problems.map((p) => "\t- ${p.code}: ${p.msg}").join("\n")}";
    } catch (e) {
      return e.toString();
    }
  }

  String _generateRandomString([int length = 32]) {
    var values = List<int>.generate(length, (int i) => _random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  String _hashString(String secret, String string) {
    return sha256.convert(utf8.encode(secret + string)).toString();
  }

  String _generateValidationCodeValue() {
    return [
      for (var i = 0; i < _codeLength; ++i)
        _random.nextInt(_maxCodeDigitExclusive),
    ].join();
  }

  static const Duration _validationCodeCooldown = Duration(seconds: 15);

  static final Random _random = Random.secure();
  static const int _maxCodeDigitExclusive = 10;
  static const int _codeLength = 6;

  /// TODO: handle the case where the app cannot be created
  static App? _firebaseApp;
  static App get firebaseApp {
    if (_firebaseApp != null) {
      return _firebaseApp!;
    }

    final cert = FirebaseAdmin.instance.certFromPath(
      "config/firebase_service_account_key.json",
    );

    _firebaseApp = FirebaseAdmin.instance.initializeApp(
      AppOptions(credential: cert),
    );

    return _firebaseApp!;
  }

  static Auth get firebaseAuth => firebaseApp.auth();

  static SmtpServer? _smtpServer;
  static SmtpServer get smtpServer {
    if (_smtpServer != null) {
      return _smtpServer!;
    }

    final gmailEmail = Serverpod.instance.getPassword("gmailEmail")!;
    final gmailPassword = Serverpod.instance.getPassword("gmailPassword")!;

    _smtpServer = gmail(gmailEmail, gmailPassword);

    return _smtpServer!;
  }
}
