import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class FirebaseUpdatePasswordApi implements UpdatePasswordApi {
  const FirebaseUpdatePasswordApi();

  @override
  Future<String?> requestPasswordUpdate({required String email}) async {
    try {
      await di<Client>().user.requestPasswordUpdate(email);
      return null;
    } on UserException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> updatePassword({
    required String email,
    required String newPassword,
    required String validationCode,
  }) async {
    try {
      await di<Client>().user.validatePasswordUpdateWithCode(
            email,
            newPassword,
            validationCode,
          );

      return null;
    } on UserException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
