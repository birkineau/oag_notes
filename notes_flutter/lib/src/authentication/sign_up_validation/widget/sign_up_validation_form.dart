import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

typedef _ValidationCubit = ValidationCodeCubit;
typedef _ValidationState = ValidationCodeState;

/// Displays an instruction label, and the [SignUpValidationCodeInput].
class SignUpValidationForm extends StatelessWidget {
  const SignUpValidationForm({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingValue = 12.0;
    const textFieldHeight = 56.0;

    return Hero(
      tag: "auth_form",
      flightShuttleBuilder: authFormPlaceholderShuttleBuilder,
      child: Container(
        padding: const EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          color: NotesTheme.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: FadeScaleIn(
          from: .985,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormText(
                text: "Enter the ${_ValidationCubit.codeLength}-digit code "
                    "sent to your email.",
              ),
              Divider(height: 20.0, color: NotesTheme.colorScheme.surface),
              const SizedBox(
                height: textFieldHeight,
                child: SignUpValidationCodeInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget holding the text fields for the validation code.
///
/// This widget is responsible for handling the focus and unfocus of the text
/// fields, as well as updating the text fields when the validation code is
/// updated.
///
/// The [TextField]s behave as a single entity.
class SignUpValidationCodeInput extends StatefulWidget {
  const SignUpValidationCodeInput({super.key});

  @override
  State<SignUpValidationCodeInput> createState() =>
      _SignUpValidationCodeInputState();
}

class _SignUpValidationCodeInputState extends State<SignUpValidationCodeInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = [
      for (var i = 0; i < _ValidationCubit.codeLength; ++i)
        TextEditingController(
          text: ValidationCodeInputFormatter.zeroWidthSpace,
        ),
    ];

    _focusNodes = [
      for (var i = 0; i < _ValidationCubit.codeLength; ++i) FocusNode(),
    ];
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<_ValidationCubit, _ValidationState>(
      listener: _updateTextFields,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < _controllers.length; ++i)
            Focus(
              onKeyEvent: (focusNode, key) {
                return _handleBackspace(focusNode, key, i);
              },
              child: SignUpValidationDigitTextField(
                onSingleDigit: _setDigitAt,
                onMultipleDigits: (index, digits) {
                  context.read<_ValidationCubit>().setDigits(index, digits);
                },
                index: i,
                controller: _controllers[i],
                focusNode: _focusNodes[i],
              ),
            ),
        ],
      ),
    );
  }

  void _updateTextFields(BuildContext context, _ValidationState state) {
    for (var i = 0; i < _ValidationCubit.codeLength; ++i) {
      final digit = state.code[i];

      if (digit == "*") {
        _controllers[i].text = ValidationCodeInputFormatter.zeroWidthSpace;
        continue;
      }

      _controllers[i].text = digit;
    }

    /// Unfocuses when the last digit is entered and the code is valid.
    if (state.lastIndex == _ValidationCubit.codeLength - 1 && state.isValid) {
      _unfocus();
    } else if (state.code[state.lastIndex] != "*") {
      _nextFocus();
    }
  }

  KeyEventResult _handleBackspace(
    FocusNode focusNode,
    KeyEvent key,
    int index,
  ) {
    if (index > 0 &&
        key is KeyUpEvent &&
        key.logicalKey == LogicalKeyboardKey.backspace) {
      final lastIndex = context.read<ValidationCodeCubit>().state.lastIndex;
      _focusNodes[lastIndex - 1].requestFocus();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _setDigitAt(int index, String digit) {
    final validationCubit = context.read<_ValidationCubit>();
    final codeDigit = validationCubit.state.code[index];

    if (codeDigit.isNotEmpty && digit.isEmpty) {
      if (codeDigit != "*") {
        validationCubit.clearDigitAt(index);
      } else {
        validationCubit.clearDigitAt(index - 1);
        _previousFocus(index);
      }
    } else {
      validationCubit.setDigitAt(index, digit);
    }
  }

  void _previousFocus(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _nextFocus() {
    final lastIndex = context.read<_ValidationCubit>().state.lastIndex;

    _focusNodes[(lastIndex + 1) % _ValidationCubit.codeLength].requestFocus();
  }

  void _unfocus() {
    for (var i = 0; i < _focusNodes.length; ++i) {
      final focusNode = _focusNodes[i];
      if (focusNode.hasFocus) {
        focusNode.unfocus();
        break;
      }
    }
  }
}
