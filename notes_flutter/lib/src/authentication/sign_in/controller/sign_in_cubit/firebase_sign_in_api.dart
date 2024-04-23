import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/foundation.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// The error message when the user user email is not verified.
const kEmailNotVerified = "User user email not verified.";

/// A [SignInApi] implementation that uses Firebase authentication.
class FirebaseSignInApi implements SignInApi {
  const FirebaseSignInApi();

  @override
  Future<String?> signIn(String email, String password) async {
    String? error;

    try {
      final userCredential = await firebase.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        await firebase.FirebaseAuth.instance.signOut();
        return "Unable to obtain user from Firebase.";
      }

      if (!firebaseUser.emailVerified) {
        await firebase.FirebaseAuth.instance.signOut();
        return kEmailNotVerified;
      }

      final client = di<Client>();
      final session = await client.user.signInWithEmail(email);
      final User user;

      if (di.isRegistered<User>()) {
        user = di<User>()
          ..id = session.user.id
          ..uid = session.user.uid
          ..email = session.user.email
          ..created = session.user.created
          // ..scopes = session.user.scopes
          ..blocked = session.user.blocked;
      } else {
        user = di.registerSingleton(session.user);
      }

      final authKey = "${session.keyId}:${session.key}";

      await Future.wait<void>(
        [
          /// TODO: fix web notifications
          if (!kIsWeb) di<FcmNotification>().initialize(user),
          client.authenticationKeyManager!.put(authKey),
          client.updateStreamingConnectionAuthenticationKey(authKey),
        ],
        eagerError: true,
      );

      return null;
    } on UserException catch (e) {
      error = e.message;
    } on NotificationException catch (e) {
      error = e.message;
    } on firebase.FirebaseAuthException catch (e) {
      error = FirebaseAuthError.fromException(e).description;
    } catch (e) {
      error = e.toString();
    }

    try {
      await firebase.FirebaseAuth.instance.signOut();
    } catch (e) {
      error = "Sign-out error: $e";
    }

    return error;
  }

  @override
  Future<String?> signOut() async {
    try {
      final client = di<Client>();

      await Future.wait<void>(
        [
          /// This call removes the user auth key and fcm token from the server.
          client.user.signOut(di<User>().email),
          client.updateStreamingConnectionAuthenticationKey(null),

          /// Closing the FCM notification service will remove FCM listeners.
          ///
          /// The `unregister` parameter should be `false`, because signing out
          /// already removes the token server-side.
          di<FcmNotification>().close(),
          firebase.FirebaseAuth.instance.signOut(),
        ],
        eagerError: true,
      );

      return null;
    } catch (e) {
      return "Sign-out error: $e";
    }
  }
}
