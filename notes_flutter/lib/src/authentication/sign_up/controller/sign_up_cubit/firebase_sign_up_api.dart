import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// A [SignUpApi] implementation that uses Firebase to create accounts, and
/// Serverpod to validate the user.
class FirebaseSignUpApi implements SignUpApi {
  const FirebaseSignUpApi();

  @override
  Future<String?> createAccount(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) {
        return "Failed to create user user in Firebase.";
      }

      final client = di<Client>();
      final idToken = await user.getIdToken();

      if (idToken == null) {
        return "Failed to get user token from Firebase.";
      }

      await client.user.createUserFromFirebaseIdToken(idToken);
      await client.user.sendUserValidationCode(email);

      return null;
    } on UserException catch (e) {
      return e.message;
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthError.fromCode(e.code).description;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> requestValidationCode(String email) async {
    try {
      await di<Client>().user.sendUserValidationCode(email);

      return null;
    } on UserException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> validateAccount(String email, String code) async {
    try {
      await di<Client>().user.validateUserWithCode(email, code);
      return null;
    } on UserException catch (e) {
      return e.message;
    } catch (e) {
      return "Failed to validate user with code: $e";
    }
  }
}
