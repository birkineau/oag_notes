import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

/// A [TextField] that is used to enter a single digit of a validation code.
class SignUpValidationDigitTextField extends StatefulWidget {
  const SignUpValidationDigitTextField({
    required this.onSingleDigit,
    required this.onMultipleDigits,
    required this.index,
    required this.controller,
    required this.focusNode,
    super.key,
  });

  /// A callback that is called when a single digit is entered.
  final void Function(int index, String digit) onSingleDigit;

  /// A callback that is called when multiple digits are entered.
  final void Function(int index, String digits) onMultipleDigits;

  /// The index of the [TextField] in the array of validation code [TextField]s.
  final int index;

  /// The controller associated to the [TextField] from the
  /// [SignUpValidationCodeInput].
  final TextEditingController controller;

  /// The focus node associated to the [TextField] from the
  /// [SignUpValidationCodeInput].
  final FocusNode focusNode;

  @override
  State<SignUpValidationDigitTextField> createState() =>
      _SignUpValidationDigitTextFieldState();
}

class _SignUpValidationDigitTextFieldState
    extends State<SignUpValidationDigitTextField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _spreadRadiusAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: DurationConstants.shortAnimation,
    );

    _spreadRadiusAnimation =
        Tween<double>(begin: .0, end: 4.0).animate(_animationController);

    /// Ensures that the cursor is always at the end of the text.
    widget.controller.addListener(
      () {
        if (widget.controller.value.selection.baseOffset == 0) {
          widget.controller.selection = TextSelection.collapsed(
            offset: widget.controller.text.length,
          );
        }
      },
    );

    /// Animates the highlight shadow when the [FocusNode] changes.
    widget.focusNode.addListener(
      () {
        if (widget.focusNode.hasFocus) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shadowColor = NotesTheme.colorScheme.primary.lighten(50);
    final textStyle = NotesTheme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w700,
    );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: NotesTheme.colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: _spreadRadiusAnimation.value,
                spreadRadius: _animationController.value * 1.5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Align(
        child: SizedBox(
          width: 48.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                inputFormatters: [
                  ValidationCodeInputFormatter(
                    onSingleDigit: widget.onSingleDigit,
                    onMultipleDigits: widget.onMultipleDigits,
                    index: widget.index,
                  ),
                ],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: textStyle,
              ),
              IgnorePointer(
                child: BlocBuilder<ValidationCodeCubit, ValidationCodeState>(
                  builder: (context, state) {
                    if (state.code[widget.index] != "*") {
                      return const SizedBox.shrink();
                    }

                    return Text(
                      "*",
                      style: textStyle?.copyWith(
                        color: NotesTheme.inputDecorationTheme.hintStyle?.color,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// An [TextInputFormatter] that formats the input of a [TextField] based on
/// the [onSingleDigit] and [onMultipleDigits] callbacks.
class ValidationCodeInputFormatter extends TextInputFormatter {
  const ValidationCodeInputFormatter({
    required this.onSingleDigit,
    required this.onMultipleDigits,
    required this.index,
  });

  /// A callback that is called when a single digit is entered.
  final void Function(int index, String digit) onSingleDigit;

  /// A callback that is called when multiple digits are entered.
  final void Function(int index, String digits) onMultipleDigits;

  /// The index of the [TextField] that this formatter is attached to.
  final int index;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    /// Prevents the user from entering non-digit characters.
    if (!_digitStringValidator.hasMatch(newValue.text)) {
      return TextEditingValue.empty;
    }

    if (newValue.text.length <= 1) {
      onSingleDigit(index, newValue.text);

      if (oldValue.text == zeroWidthSpace) {
        return TextEditingValue(text: oldValue.text);
      } else {
        return TextEditingValue.empty;
      }
    }

    if (newValue.text.length - oldValue.text.length > 1) {
      /// Remove the first character since the new value will be inserted at
      /// its location/index in the corresponding String.
      onMultipleDigits(index, newValue.text.substring(1));
      return TextEditingValue.empty;
    }

    final digitIndex = newValue.selection.baseOffset == 0
        ? 0
        : newValue.selection.baseOffset - 1;

    onSingleDigit(index, newValue.text[digitIndex]);

    return TextEditingValue.empty;
  }

  /// Unicode character for the zero-width space.
  static const zeroWidthSpace = "\u200b";

  /// A regular expression that matches a digit string that can start with a
  /// zero-width space.
  static final _digitStringValidator = RegExp("^($zeroWidthSpace)?\\d*\$");
}
