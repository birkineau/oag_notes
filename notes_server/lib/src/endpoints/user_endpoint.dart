import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:notes_server/src/endpoints/account_manager_endpoint.dart';
import 'package:notes_server/src/future_calls/future_calls.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// TODO: Microsoft and Google email providers.
class UserEndpoint extends Endpoint {
  static const channel = "user_endpoint";

  @override
  bool get logSessions => false;

  Future<void> createUserFromFirebaseIdToken(
    Session session,
    String idToken,
  ) async {
    final token = await FirebaseApp.auth.verifyIdToken(idToken, true);
    final claims = token.claims;
    final userIdentifier = claims.subject;
    final email = claims.email;

    if (email == null) {
      throw UserException(
        message: "Unable to link Firebase user. Email not found in claims.",
      );
    }

    final existingUser = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingUser != null) {
      throw UserException(message: "User already exists.");
    }

    final user = await User.db.insertRow(
      session,
      User(
        uid: userIdentifier,
        email: email,
        created: DateTime.now().toUtc(),
        blocked: false,
      ),
    );

    UserExt.log(user, "Created user from Firebase ID token");
  }

  Future<void> requestPasswordUpdate(Session session, String email) async {
    final user = await UserExt.getByEmail(session, email);

    /// Check if there's an existing password update request for the user.
    var passwordUpdate = await PasswordUpdate.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    late Passcode passcode;

    /// If there's no password update request for the user, create a new one.
    if (passwordUpdate == null) {
      await session.dbNext.transaction(
        (transaction) async {
          final existingPasscode = await Passcode.db.findFirstRow(
            session,
            where: (t) => t.userId.equals(user.id),
            transaction: transaction,
          );

          /// A passcode might have been created by an user validation request.
          /// If so, use that code for the password update.
          if (existingPasscode != null) {
            /// Since this code is now being used for the password update,
            /// unschedule the passcode expiration deletion that was scheduled
            /// for the user validation request.
            await PasscodeDeletion.unschedule(session, existingPasscode);

            passcode = await Passcode.db.updateRow(
              session,
              existingPasscode.copyWith(
                value: _generateValidationCodeValue(),
                created: DateTime.now().toUtc(),
              ),
              transaction: transaction,
            );
          } else {
            /// Otherwise, create a new validation code.
            passcode = await Passcode.db.insertRow(
              session,
              Passcode(
                userId: user.id!,
                value: _generateValidationCodeValue(),
                created: DateTime.now().toUtc(),
              ),
              transaction: transaction,
            );
          }

          passwordUpdate = await PasswordUpdate.db.insertRow(
            session,
            PasswordUpdate(userId: user.id!, passcodeId: passcode.id!),
            transaction: transaction,
          );
        },
      );

      UserExt.log(user, "Created password update request");
    } else {
      final existingPasscode = await Passcode.db.findById(
        session,
        passwordUpdate.passcodeId,
      );

      if (existingPasscode == null) {
        throw UserException(message: "Password update missing passcode.");
      }

      passcode = existingPasscode;

      if (_isValidationCodeRecentlySent(passcode)) {
        throw UserException(
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

      passcode = await Passcode.db.updateRow(
        session,
        passcode.copyWith(
          value: _generateValidationCodeValue(),
          created: DateTime.now().toUtc(),
        ),
      );

      UserExt.log(user, "Password update passcode updated");
    }

    final sendEmail = _sendEmail(
      toEmail: email,
      subject: "Password update code for Notes App",
      html: "Your password update request must be validated.<br><br>"
          "Your password update code is:"
          "<h2>${passcode.value}</h2>",
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
    if (await sendEmail case final String error) {
      await session.dbNext.transaction(
        (transaction) async {
          await PasswordUpdate.db.deleteRow(
            session,
            passwordUpdate!,
            transaction: transaction,
          );

          await Passcode.db.deleteRow(
            session,
            passcode,
            transaction: transaction,
          );
        },
      );

      throw UserException(message: error);
    }

    /// At this point, there are no scheduled future calls to delete the current
    /// password update request and validation code. Create a new future call
    /// to delete them when the validation code expires.
    await PasswordUpdateDeletion.schedule(
      session,
      passwordUpdate!,
      passcode,
    );

    UserExt.log(user, "Send password update passcode '$passcode'");
  }

  /// TODO: check this
  /// This one overwrites any existing passcode, even if it is a passcode that
  /// was created due to a password update request.
  Future<void> sendUserValidationCode(Session session, String email) async {
    final user = await UserExt.getByEmail(session, email);

    var passcode = await Passcode.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    /// If there's no validation code for the user, create a new one.
    if (passcode == null) {
      passcode = await Passcode.db.insertRow(
        session,
        Passcode(
          userId: user.id!,
          value: _generateValidationCodeValue(),
          created: DateTime.now().toUtc(),
        ),
      );
    } else {
      /// Prevent the creation of a new validation code if the previous one
      /// was created recently.
      if (_isValidationCodeRecentlySent(passcode)) {
        throw UserException(
          message: "Validation code was sent recently. Please wait a few "
              "seconds before requesting a new one.",
        );
      }

      await PasscodeDeletion.unschedule(session, passcode);

      passcode = await Passcode.db.updateRow(
        session,
        passcode.copyWith(
          value: _generateValidationCodeValue(),
          created: DateTime.now().toUtc(),
        ),
      );
    }

    final sendEmail = _sendEmail(
      toEmail: email,
      subject: "User validation code for Notes App",
      html: "Your User must be validated in order to sign in.<br><br>"
          "Your validation code is:"
          "<h2>${passcode.value}</h2>",
    );

    /// If there is an error sending the email, delete the validation code,
    /// and cancel the future call to delete it on expiration.
    if (await sendEmail case final String error) {
      await Passcode.db.deleteRow(session, passcode);
      throw UserException(message: error);
    }

    /// At this point, either we created a new passcode, or updated an existing
    /// passcode (after unscheduling the future call to delete it). Therefore,
    /// we schedule a passcode expiration deletion for the new passcode.
    await PasscodeDeletion.schedule(session, passcode);

    UserExt.log(user, "Sent user validation passcode '$passcode'");
  }

  Future<void> validatePasswordUpdateWithCode(
    Session session,
    String email,
    String newPassword,
    String code,
  ) async {
    final user = await UserExt.getByEmail(session, email);
    final update = await PasswordUpdate.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    /// Ensure there's an existing password update request for this user.
    if (update == null) {
      throw UserException(
        message: "Password update entry not found. Try again.",
      );
    }

    /// Get the associated validation code for the password update request.
    final passcode = await Passcode.db.findById(session, update.passcodeId);

    if (passcode == null) {
      throw UserException(
        message: "Password update missing passcode. Request a new code.",
      );
    }

    final isExpiredValidationCode =
        DateTime.now().toUtc().difference(passcode.created) >=
            PasswordUpdateDeletion.passcodeDuration;

    /// If the validation code is expired, but has not yet been deleted by the
    /// deletion future call, delete it and cancel the deletion future call.
    if (isExpiredValidationCode) {
      await _unscheduleAndDeletePasswordUpdate(session, update, passcode);
      throw UserException(message: "Passcode expired. Request a new code.");
    }

    if (passcode.value != code) {
      throw UserException(
        message: "Passcode mismatch. Verify the code and try again.",
      );
    }

    try {
      await Future.wait<void>(
        [
          FirebaseApp.auth.updateUser(
            user.uid,
            password: newPassword,
            emailVerified: true,
          ),
          _unscheduleAndDeletePasswordUpdate(session, update, passcode),
        ],
      );

      UserExt.log(user, "Updated password");

      final addedVerifiedTagType = await UserExt.addTagsByType(
        session,
        user.id!,
        {TagType.verified},
      );

      if (addedVerifiedTagType) {
        UserExt.log(user, "Verified user after password update");
      }
    } catch (e) {
      throw UserException(message: "Failed to update password: $e");
    }
  }

  Future<void> validateUserWithCode(
    Session session,
    String email,
    String code,
  ) async {
    final user = await UserExt.getByEmail(session, email);
    final passcode = await Passcode.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    if (passcode == null) {
      throw UserException(message: "Passcode not found. Request a new code.");
    }

    final passwordUpdate = await PasswordUpdate.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    /// If there's an existing password update request for the user, ensure that
    /// the validation code is not being used for the password update.
    ///
    /// This is to prevent a user from validating their email using a passcode
    /// that was sent for a password update request.
    if (passwordUpdate != null && passwordUpdate.passcodeId == passcode.id) {
      throw UserException(
        message: "Passcode belongs to a different request. Request a new code.",
      );
    }

    final isPasscodeExpired =
        DateTime.now().toUtc().difference(passcode.created) >=
            PasscodeDeletion.passcodeDuration;

    if (isPasscodeExpired) {
      await _unscheduleAndDeletePasscode(session, passcode);
      throw UserException(message: "Passcode expired. Request a new code.");
    }

    if (passcode.value != code) {
      throw UserException(
        message: "Passcode mismatch. Verify the code and try again.",
      );
    }

    try {
      await Future.wait<void>(
        [
          FirebaseApp.auth.updateUser(user.uid, emailVerified: true),
          UserExt.addTagsByType(session, user.id!, {TagType.verified}),
          _unscheduleAndDeletePasscode(session, passcode),
        ],
        eagerError: true,
      );

      UserExt.log(user, "User validated with passcode");
    } catch (e) {
      throw UserException(message: "Failed to validate user: $e");
    }
  }

  Future<UserSession> signInWithEmail(Session session, String email) async {
    final authKeySalt = session.passwords["authKeySalt"];

    if (authKeySalt == null) {
      throw UserException(
        message: "Unable to sign in due to missing authentication parameter. "
            "Please contact the server administrator!",
      );
    }

    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
      include: User.include(tags: UserTag.includeList()),
    );

    if (user == null) {
      throw UserException(message: "User not found.");
    }

    if (user.blocked) {
      throw UserException(message: "User is blocked.");
    }

    if (user.tags == null || user.tags!.isEmpty) {
      throw UserException(
        message: "User does not have any associated tags. Unable to sign in.",
      );
    }

    final key = generateRandomString();
    final config = di<ServerConfiguration>();
    final scopeNames = <String>[
      for (final userTag in user.tags!) config.tagById(userTag.tagId).type.name,
    ];

    final authKey = await AuthKey.db.insertRow(
      session,
      AuthKey(
        userId: user.id!,
        hash: hashString(authKeySalt, key),
        key: key,
        scopeNames: scopeNames,

        /// TODO: detect sign-in method
        method: "firebase",
      ),
    );

    UserExt.log(user, "Signed in");

    return UserSession(user: user, keyId: authKey.id!, key: key);
  }

  Future<void> signOut(Session session, String email) async {
    final user = await UserExt.getByEmail(session, email);

    await session.dbNext.transaction<void>((transaction) async {
      try {
        await Future.wait<void>(
          [
            AuthKey.db.deleteWhere(
              session,
              where: (t) => t.userId.equals(user.id),
            ),
            FcmToken.db.deleteWhere(
              session,
              where: (t) => t.userId.equals(user.id),
            ),
          ],
          eagerError: true,
        );
      } catch (e) {
        throw UserException(message: "Failed to sign out: $e");
      }
    });

    UserExt.log(user, "Signed out");
  }

  @override
  Future<void> streamOpened(StreamingSession session) async {
    session.messages.addListener(
      AccountManagerEndpoint.channel,
      (message) async {
        if (message case final UserMessage message
            when message.type == UserMessageType.blocked) {
          /// If the current user id matches the message's user id, sign out the
          /// current user, because they are blocked.
          if (await _isMessageForCurrentUser(session, message)) {
            await signOut(session, message.user.email);
            UserExt.log(message.user, "Signed out because user was blocked");
          }

          /// Propagate the message to all clients.
          await sendStreamMessage(session, message);
        }
      },
    );
  }

  Future<bool> _isMessageForCurrentUser(
    Session session,
    UserMessage message,
  ) async {
    if (await session.auth.authenticatedUserId case final int userId) {
      return userId == message.user.id;
    }

    return false;
  }

  Future<void> _unscheduleAndDeletePasscode(
    Session session,
    Passcode passcode,
  ) async {
    await PasscodeDeletion.unschedule(session, passcode);
    await Passcode.db.deleteRow(session, passcode);
  }

  Future<void> _unscheduleAndDeletePasswordUpdate(
    Session session,
    PasswordUpdate passwordUpdate,
    Passcode passcode,
  ) {
    return session.dbNext.transaction(
      (transaction) async {
        await Future.wait<void>(
          [
            PasswordUpdateDeletion.unschedule(
              session,
              passwordUpdate,
            ),
            PasswordUpdate.db.deleteRow(
              session,
              passwordUpdate,
              transaction: transaction,
            ),
            Passcode.db.deleteRow(
              session,
              passcode,
              transaction: transaction,
            ),
          ],
          eagerError: true,
        );
      },
    );
  }

  bool _isValidationCodeRecentlySent(Passcode validationCode) {
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
        ..from = smtpServer.username
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

  String _generateValidationCodeValue() {
    return [
      for (var i = 0; i < _codeLength; ++i)
        random.nextInt(_maxCodeDigitExclusive),
    ].join();
  }

  static const Duration _validationCodeCooldown = Duration(seconds: 15);

  static const int _maxCodeDigitExclusive = 10;
  static const int _codeLength = 6;

  static SmtpServer? _smtpServer;
  static SmtpServer get smtpServer {
    if (_smtpServer != null) {
      return _smtpServer!;
    }

    final gmailEmail = Serverpod.instance.getPassword("gmailEmail")!;
    final gmailPassword = Serverpod.instance.getPassword("gmailPassword")!;
    _smtpServer = gmail(gmailEmail, gmailPassword);

    // _smtpServer = SmtpServer(
    //   "smtp.sendgrid.net",
    //   port: 587,
    //   username: "apiKey",
    //   password: Serverpod.instance.getPassword("twilioSendGridApiKey")!,
    // );

    return _smtpServer!;
  }
}
