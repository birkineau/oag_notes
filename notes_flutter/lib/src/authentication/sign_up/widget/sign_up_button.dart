import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// A button that sends a sign-up request to the server.
class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final hasValidCredentials = context.select<SignUpCredentialsCubit, bool>(
      (cubit) => cubit.state.isValid,
    );

    final signUpStatus = context.select<SignUpCubit, SignUpStatus>(
      (cubit) => cubit.state.status,
    );

    final Widget buttonContent;

    if (signUpStatus == SignUpStatus.creating) {
      buttonContent = const CircularProgressIndicator(
        key: ValueKey("creating_account_progress_indicator"),
      );
    } else {
      buttonContent = const Text(
        key: ValueKey("create_account_button_label"),
        "Create my account",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
      );
    }

    return AuthActionButton(
      onPressed:
          hasValidCredentials && signUpStatus == SignUpStatus.creationRequired
              ? () => _createAccount(context)
              : null,
      child: AnimatedSwitcher(
        duration: DurationConstants.shortAnimation,
        switchInCurve: Curves.fastOutSlowIn,
        child: Align(child: buttonContent),
      ),
    );
  }

  Future<void> _createAccount(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final (:email, :password) =
        context.read<SignUpCredentialsCubit>().credentials();

    final didSignUp = await context.read<SignUpCubit>().createAccount(
          email: email,
          password: password,
        );

    if (didSignUp) {
      SignUpValidationPage.go();
    }
  }
}
