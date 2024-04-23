import 'package:notes_flutter/src/authentication/authentication.dart';

class MockUpdatePasswordApi extends MockApi implements UpdatePasswordApi {
  const MockUpdatePasswordApi({
    super.delay = const Duration(seconds: 1),
    super.failureChance = .0,
  });

  @override
  Future<String?> requestPasswordUpdate({required String email}) {
    return runAsync(() async => null);
  }

  @override
  Future<String?> updatePassword({
    required String email,
    required String newPassword,
    required String validationCode,
  }) {
    return runAsync(() async => null);
  }
}
