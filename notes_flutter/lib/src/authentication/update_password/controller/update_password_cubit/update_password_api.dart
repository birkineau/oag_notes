abstract interface class UpdatePasswordApi {
  Future<String?> requestPasswordUpdate({required String email});

  Future<String?> updatePassword({
    required String email,
    required String newPassword,
    required String validationCode,
  });
}
