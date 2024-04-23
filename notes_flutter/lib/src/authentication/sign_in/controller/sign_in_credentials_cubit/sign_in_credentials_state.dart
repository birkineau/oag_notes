part of 'sign_in_credentials_cubit.dart';

/// The sign-in email input and password.
class SignInCredentialsState extends Equatable with FormzMixin {
  SignInCredentialsState({
    EmailInput? email,
    String? password,
  })  : email = email ?? EmailInput.pure(),
        password = password ?? "";

  /// The email input.
  final EmailInput email;

  /// The password.
  final String password;

  SignInCredentialsState copyWith({
    EmailInput? email,
    String? password,
  }) {
    return SignInCredentialsState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
      ];

  @override
  List<FormzInput<String, EmailInputError>> get inputs => [
        email,
      ];
}
