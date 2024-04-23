import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

/// A password input validation model that requires the password to be at least
/// 8 characters long, contain at least one letter, one number, and one special
/// character.
class PasswordInput extends FormzInput<String, PasswordValidationError>
    with FormzInputErrorCacheMixin, EquatableMixin {
  PasswordInput.pure() : super.pure("");
  PasswordInput.dirty(super.value) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!_letterRegex.hasMatch(value)) {
      return PasswordValidationError.missingLetter;
    } else if (!_numberRegex.hasMatch(value)) {
      return PasswordValidationError.missingNumber;
    } else if (!_specialCharactersRegex.hasMatch(value)) {
      return PasswordValidationError.missingSpecialCharacter;
    } else if (value.length < _minLength) {
      return PasswordValidationError.tooShort;
    }

    return null;
  }

  @override
  List<Object?> get props => [value];

  static const _minLength = 8;
  static const _specialCharacters = " !\"#\$%&'()*+,-./:;<=>?@[]^_`{|}~\\";
  static final _letterRegex = RegExp(r"^(?=.*[a-zA-Z]).+$");
  static final _numberRegex = RegExp(r"^(?=.*\d).+$");
  static final _specialCharactersRegex = RegExp(
    r"""^(?=.*[ !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~\\]).+$""",
  );
}

enum PasswordValidationError {
  empty,
  tooShort,
  missingLetter,
  missingNumber,
  missingSpecialCharacter,
  ;

  String? get description {
    switch (this) {
      case PasswordValidationError.empty:
        return "password cannot be empty";
      case PasswordValidationError.tooShort:
        return "must have at least ${PasswordInput._minLength} "
            "characters";
      case PasswordValidationError.missingLetter:
        return "must contain at least one letter";
      case PasswordValidationError.missingNumber:
        return "must contain at least one number";
      case PasswordValidationError.missingSpecialCharacter:
        return "must contain at least one special character\n"
            "e.g. ${PasswordInput._specialCharacters}";
    }
  }
}
