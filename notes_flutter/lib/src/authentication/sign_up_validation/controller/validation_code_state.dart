part of 'validation_code_cubit.dart';

/// The state of the sign-up validation code which includes the code and the
/// index of the last digit that was entered.
///
/// Any missing digits are represented by an asterisk.
class ValidationCodeState {
  const ValidationCodeState({
    required this.code,
    required this.lastIndex,
  });

  /// Creates an empty sign-up code.
  ///
  /// The empty code is represented by a [String] of
  /// [ValidationCodeCubit.codeLength] asterisks.
  ValidationCodeState.empty()
      : code = [
          for (var i = 0; i < ValidationCodeCubit.codeLength; ++i) "*",
        ].join(),
        lastIndex = 0;

  /// The sign-up code.
  final String code;

  /// The index of the last digit that was entered.
  final int lastIndex;

  /// Returns `true` if the sign-up code is a [ValidationCodeCubit.codeLength]
  /// -digit number.
  bool get isValid => _digitCodeValidator.hasMatch(code);

  ValidationCodeState copyWith({
    String? code,
    int? lastIndex,
  }) {
    return ValidationCodeState(
      code: code ?? this.code,
      lastIndex: lastIndex ?? this.lastIndex,
    );
  }

  static final _digitCodeValidator = RegExp(
    "^\\d{${ValidationCodeCubit.codeLength}}\$",
  );
}
