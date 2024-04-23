part of 'sign_up_credentials_cubit.dart';

/// The sign-up credentials state.
class SignUpCredentialsState extends Equatable with FormzMixin {
  /// Creates a new sign-up credentials state with the specified inputs.
  ///
  /// If an input is not provided, it will be set to its default pure value.
  SignUpCredentialsState({
    EmailInput? email,
    PasswordInput? password,
    PasswordConfirmInput? passwordConfirm,
  })  : email = email ?? EmailInput.pure(),
        password = password ?? PasswordInput.pure(),
        passwordConfirm = passwordConfirm ?? PasswordConfirmInput.pure();

  /// The email input.
  final EmailInput email;

  /// The password input.
  ///
  /// Requirements:
  /// * At least 8 characters.
  /// * At least one letter.
  /// * At least one number.
  /// * At least one special character.
  final PasswordInput password;

  /// The password confirm input.
  ///
  /// Must match the [password].
  final PasswordConfirmInput passwordConfirm;

  SignUpCredentialsState copyWith({
    EmailInput? email,
    PasswordInput? password,
    PasswordConfirmInput? passwordConfirm,
  }) {
    return SignUpCredentialsState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        passwordConfirm,
      ];

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        email,
        password,
        passwordConfirm,
      ];
}
