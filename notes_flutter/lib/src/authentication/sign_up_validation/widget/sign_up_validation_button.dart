import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// A button that sends the validation code to the server to validate the user's
/// email account.
class SignUpValidationButton extends StatelessWidget {
  const SignUpValidationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final hasCorrectCodeFormat = context.select<ValidationCodeCubit, bool>(
      (cubit) => cubit.state.isValid,
    );

    final signUpStatus = context.select<SignUpCubit, SignUpStatus>(
      (cubit) => cubit.state.status,
    );

    final Widget buttonContent;

    if (signUpStatus == SignUpStatus.validating) {
      buttonContent = const CircularProgressIndicator(
        key: ValueKey("validating_account_progress_indicator"),
      );
    } else {
      buttonContent = const Text(
        key: ValueKey("validate_account_button_label"),
        "Validate my account",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
      );
    }

    return AuthActionButton(
      onPressed: hasCorrectCodeFormat &&
              signUpStatus == SignUpStatus.validationRequired
          ? () => _validateCode(context)
          : null,
      child: AnimatedSwitcher(
        duration: DurationConstants.shortAnimation,
        switchInCurve: Curves.fastOutSlowIn,
        child: Align(child: buttonContent),
      ),
    );
  }

  Future<void> _validateCode(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final signInCredentialsCubit = context.read<SignInCredentialsCubit>();
    final signUpCubit = context.read<SignUpCubit>();
    final signUpCredentialsCubit = context.read<SignUpCredentialsCubit>();
    final signUpValidationCubit = context.read<ValidationCodeCubit>();

    final validated = await signUpCubit.validateAccount(
      signUpCredentialsCubit.state.email.value,
      signUpValidationCubit.state.code,
    );

    if (validated) {
      signInCredentialsCubit
        ..setEmail(signUpCredentialsCubit.state.email.value)
        ..setPassword("");

      signUpCredentialsCubit.clear();
      signUpValidationCubit.clear();
      signUpCubit.reset();

      const duration = Duration(milliseconds: 3250);

      TransientPage.go(
        duration: duration,
        nextPath: SignInPage.path,
        child: const ImageMessage(
          duration: duration,
          imageAssetPath: "lib/assets/images/success_512.png",
          message: "Your account has been created.",
        ),
      );
    }
  }
}
