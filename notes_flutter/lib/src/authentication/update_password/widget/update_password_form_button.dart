import 'package:flutter/material.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

/// A button that opens the reset password page.
class UpdatePasswordFormButton extends StatelessWidget {
  const UpdatePasswordFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthTransitionButton(
      onPressed: () => _openResetPasswordPage(context),
      label: "Forgot your password?",
      buttonLabel: "Recover",
    );
  }

  void _openResetPasswordPage(BuildContext context) {
    UpdatePasswordPage.go();
  }
}
