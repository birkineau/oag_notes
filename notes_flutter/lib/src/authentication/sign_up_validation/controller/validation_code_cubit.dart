import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

part 'validation_code_state.dart';

/// A cubit that handles the input and [TextField] validation of the sign-up
/// code.
class ValidationCodeCubit extends Cubit<ValidationCodeState> {
  ValidationCodeCubit() : super(ValidationCodeState.empty());

  /// Sets the digit at the given [index] of the sign-up code.
  void setDigitAt(int index, String digit) {
    if (index < 0 || index >= codeLength) {
      return;
    }

    final newCode = state.code.substring(0, index) +
        digit +
        state.code.substring(index + 1);

    return emit(state.copyWith(code: newCode, lastIndex: index));
  }

  /// Clears the digit at the given [index] of the sign-up code.
  void clearDigitAt(int index) {
    if (index < 0 || index >= codeLength) {
      return;
    }

    final newCode = "${state.code.substring(0, index)}"
        "*"
        "${state.code.substring(index + 1)}";

    return emit(state.copyWith(code: newCode, lastIndex: index));
  }

  /// Sets the digits of the sign-up code starting at the given [index].
  ///
  /// Truncates the [digits] if it is longer than the remaining space in the
  /// code.
  void setDigits(int index, String digits) {
    if (index < 0 || index >= codeLength || digits.isEmpty) {
      return;
    }

    final insertionCount = math.min(codeLength - index, digits.length);

    final newCode = "${state.code.substring(0, index)}"
            "${digits.substring(0, insertionCount)}"
            "${state.code.substring(index + insertionCount)}"
        .replaceAll(ValidationCodeInputFormatter.zeroWidthSpace, "");

    final lastIndex = math.min(index + insertionCount - 1, codeLength - 1);

    emit(state.copyWith(code: newCode, lastIndex: lastIndex));
  }

  /// Clears all the digits of the sign-up code.
  void clear() {
    emit(ValidationCodeState.empty());
  }

  /// The length of the sign-up code.
  static const codeLength = 6;
}
