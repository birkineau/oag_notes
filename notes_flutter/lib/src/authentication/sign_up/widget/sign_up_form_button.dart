import 'package:flutter/material.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

/// Button to navigate to the [SignUpPage].
class SignUpFormButton extends StatelessWidget {
  const SignUpFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTransitionButton(
      heroTag: "auth_subtitle",
      onPressed: SignUpPage.go,
      label: "Don't have an account?",
      buttonLabel: "Sign up",
    );
  }
}
