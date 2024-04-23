part of 'update_password_form_cubit.dart';

/// The state of the update password form.
///
/// Holds the email, password, and password confirmation inputs.
class UpdatePasswordFormState extends Equatable with FormzMixin {
  UpdatePasswordFormState({
    EmailInput? email,
    PasswordInput? password,
    PasswordConfirmInput? passwordConfirm,
  })  : email = email ?? EmailInput.pure(),
        password = password ?? PasswordInput.pure(),
        passwordConfirm = passwordConfirm ?? PasswordConfirmInput.pure();

  /// The email input of the account to update the password.
  final EmailInput email;

  /// The password input of the account to update the password.
  final PasswordInput password;

  /// The password confirmation input of the account to update the password.
  final PasswordConfirmInput passwordConfirm;

  UpdatePasswordFormState copyWith({
    EmailInput? email,
    PasswordInput? password,
    PasswordConfirmInput? passwordConfirm,
  }) {
    return UpdatePasswordFormState(
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
