import 'package:flutter/material.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

class SignInFormButton extends StatelessWidget {
  const SignInFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTransitionButton(
      heroTag: "auth_subtitle",
      onPressed: SignInPage.go,
      label: "Already have an account?",
      buttonLabel: "Sign in",
    );
  }
}
