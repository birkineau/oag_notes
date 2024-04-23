import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

/// A password confirmation input validation model that requires the password
/// confirmation to match the [password].
class PasswordConfirmInput
    extends FormzInput<String, PasswordConfirmValidationError>
    with FormzInputErrorCacheMixin, EquatableMixin {
  PasswordConfirmInput.pure()
      : password = "",
        super.pure("");

  PasswordConfirmInput.dirty([
    this.password,
    super.value = "",
  ]) : super.dirty();

  final String? password;

  @override
  PasswordConfirmValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordConfirmValidationError.empty;
    } else if (password != value) {
      return PasswordConfirmValidationError.notMatching;
    }

    return null;
  }

  @override
  List<Object?> get props => [
        password,
        value,
      ];
}

enum PasswordConfirmValidationError {
  empty,
  notMatching,
  ;

  String? get description {
    switch (this) {
      case PasswordConfirmValidationError.empty:
        return "password confirmation cannot be empty";
      case PasswordConfirmValidationError.notMatching:
        return "passwords do not match";
    }
  }
}
