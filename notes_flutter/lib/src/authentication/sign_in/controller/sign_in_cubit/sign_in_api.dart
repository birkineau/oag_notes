/// Mock error message for testing a failing sign-in or sign-out operation.
const kMockError =
    "Mock error: Generic error message for a sign-in or sign-out operation "
    "that failed.";

/// Interface for account sign-in and sign-out operations.
abstract interface class SignInApi {
  /// Signs in the user with the provided [email] and [password].
  Future<String?> signIn(String email, String password);

  /// Signs out the current user.
  Future<String?> signOut();
}
