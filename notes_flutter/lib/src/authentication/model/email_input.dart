import 'package:formz/formz.dart';

/// An input for email validation.
class EmailInput extends FormzInput<String, EmailInputError>
    with FormzInputErrorCacheMixin {
  EmailInput.pure() : super.pure("");
  EmailInput.dirty(super.value) : super.dirty();

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) {
      return EmailInputError.empty;
    } else if (!_emailRegex.hasMatch(value)) {
      return EmailInputError.invalid;
    }

    return null;
  }

  static final _emailRegex = RegExp(
    r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*\.[a-zA-Z]{2,}$",
  );
}

/// The possible email validation errors.
enum EmailInputError {
  /// The email is empty.
  empty,

  /// The email format is invalid.
  invalid,
  ;

  /// The error message for the email validation error.
  String? get description {
    switch (this) {
      case EmailInputError.empty:
        return "email cannot be empty";
      case EmailInputError.invalid:
        return "must have a valid format; e.g. jane.doe@gmail.com";
    }
  }
}
