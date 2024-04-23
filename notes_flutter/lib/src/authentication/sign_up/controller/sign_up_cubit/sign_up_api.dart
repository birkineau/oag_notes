/// Interface for creating a new account and validating the account with a code.
abstract interface class SignUpApi {
  /// Creates a new account with the specified [email] and [password].
  Future<String?> createAccount(String email, String password);

  /// Requests a validation code for the specified [email] from the server.
  Future<String?> requestValidationCode(String email);

  /// Validates the an user [email] account with the server using a [code].
  Future<String?> validateAccount(String email, String code);
}
