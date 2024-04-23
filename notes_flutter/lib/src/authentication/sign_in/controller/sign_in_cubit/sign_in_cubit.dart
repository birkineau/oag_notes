import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

part 'sign_in_state.dart';

/// A Cubit that manages the sign-in state of the user.
class SignInCubit extends Cubit<SignInState> {
  /// Initializes the [SignInCubit] with the provided [api].
  SignInCubit({required this.client, required this.api})
      : _accountMessageStream = client.user.stream.asBroadcastStream(),
        super(const SignInState.signedOut());

  /// The client used to communicate with the Serverpod server.
  final Client client;

  /// The API used to handle sign-in and sign-out operations.
  final SignInApi api;

  /// The stream of account messages from the server through the [Client].
  final Stream<SerializableEntity> _accountMessageStream;

  /// Handles remote account messages from the server.
  StreamSubscription<SerializableEntity>? _accountMessageListener;

  /// Signs in the user with the provided [email] and [password].
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const SignInState.withoutError(SignInStatus.signingIn));

    if (await api.signIn(email, password) case final String error) {
      emit(
        error == kEmailNotVerified
            ? const SignInState.emailNotVerified()
            : state.withError(error),
      );
    } else {
      await _startAccountMessageListener();
      emit(const SignInState.signedIn());
    }
  }

  /// Signs out the current user from Firebase and the Serverpod server.
  Future<void> signOut() async {
    if (await api.signOut() case final String error) {
      emit(state.withError(error));
    } else {
      await _stopAccountMessageListener();
      emit(const SignInState.signedOut());
    }
  }

  void reset() {
    emit(const SignInState.signedOut());
  }

  @override
  Future<void> close() async {
    await _stopAccountMessageListener();
    return super.close();
  }

  Future<void> _startAccountMessageListener() async {
    if (_accountMessageListener != null) return;

    await client.openStreamingConnection();

    _accountMessageListener = _accountMessageStream.listen(
      (message) async {
        if (message case final UserMessage message
            when message.type == UserMessageType.blocked) {
          log(
            "${message.user.email} (${message.user.id}): "
            "Remote sign-out.",
          );

          if (_isMessageForCurrentUser(message)) {
            await _handleRemoteSignOut();
          }
        }
      },
    );
  }

  Future<void> _stopAccountMessageListener() async {
    if (_accountMessageListener == null) return;

    await _accountMessageListener!.cancel();
    await client.closeStreamingConnection();

    _accountMessageListener = null;
  }

  /// This method is called when the user is signed out remotely.
  ///
  /// Any user auth token or fcm token is assumed to have been revoked by the
  /// server prior to calling this method.
  Future<void> _handleRemoteSignOut() async {
    try {
      await Future.wait<void>(
        [
          di<FcmNotification>().close(),
          client.updateStreamingConnectionAuthenticationKey(null),
          firebase.FirebaseAuth.instance.signOut(),
        ],
      );

      emit(const SignInState.signedOut());
    }

    /// A [NotificationException] is thrown if the FCM token is not found in the
    /// server. This is not an error, so the user is still signed out.
    on NotificationException catch (_) {
      emit(const SignInState.signedOut());
    } catch (e) {
      emit(SignInState(status: SignInStatus.signedOut, error: e.toString()));
    }
  }

  bool _isMessageForCurrentUser(UserMessage message) {
    return di.isRegistered<User>() && di<User>().id == message.user.id;
  }
}

/// Enumeration of Firebase authentication error codes based on the String code
/// from a [firebase.FirebaseAuthException].
enum FirebaseAuthError {
  /// The email address is already in use by another account.
  emailAlreadyInUse("email-already-in-use"),

  /// The email address is not valid.
  invalidEmail("invalid-email"),

  /// Email/password accounts are not enabled. Enable email/password accounts
  /// in the Firebase Console, under the Auth tab.
  operationNotAllowed("operation-not-allowed"),

  /// Too many requests to Firebase in a short period of time.
  tooManyRequests("too-many-requests"),

  /// The user corresponding to the given email has been disabled.
  userDisabled("user-disabled"),

  /// There is no user corresponding to the given email.
  userNotFound("user-not-found"),

  /// The password is not strong enough.
  weakPassword("weak-password"),

  /// The password is invalid for the given email, or the account corresponding
  /// to the email does not have a password set.
  wrongPassword("wrong-password"),

  /// Unknown authentication error.
  unknown("unknown"),
  ;

  const FirebaseAuthError(this.code);

  factory FirebaseAuthError.fromCode(String code) {
    if (code == emailAlreadyInUse.code) {
      return emailAlreadyInUse;
    } else if (code == invalidEmail.code) {
      return invalidEmail;
    } else if (code == operationNotAllowed.code) {
      return operationNotAllowed;
    } else if (code == userDisabled.code) {
      return userDisabled;
    } else if (code == userNotFound.code) {
      return userNotFound;
    } else if (code == wrongPassword.code) {
      return wrongPassword;
    } else if (code == tooManyRequests.code) {
      return tooManyRequests;
    } else if (code == emailAlreadyInUse.code) {
      return emailAlreadyInUse;
    } else {
      return unknown;
    }
  }

  factory FirebaseAuthError.fromException(Object e) {
    if (e is firebase.FirebaseAuthException) {
      return FirebaseAuthError.fromCode(e.code);
    } else {
      return FirebaseAuthError.unknown;
    }
  }

  /// The error code returned by Firebase.
  final String code;

  /// The description of the Firebase error.
  String get description {
    switch (this) {
      case weakPassword:
        return "The password is not strong enough.";
      case invalidEmail:
        return "The email address is not valid.";
      case operationNotAllowed:
        return "Email/password accounts are not enabled. Contact the "
            "application developer.";
      case userDisabled:
        return "The user corresponding to the given email has been disabled.";
      case userNotFound:
        return "There is no user corresponding to the given email.";
      case wrongPassword:
        return "The password is invalid for the given email, or the account "
            "corresponding to the email does not have a password set.";
      case tooManyRequests:
        return "Too many requests. Please wait a moment and try again.";
      case emailAlreadyInUse:
        return "The email address is already in use.";
      case unknown:
        return "An unknown error occurred.";
    }
  }
}
