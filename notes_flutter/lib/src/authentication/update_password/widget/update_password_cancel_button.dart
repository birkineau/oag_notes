import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

class UpdatePasswordCancelButton extends StatelessWidget {
  const UpdatePasswordCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthTransitionButton(
      onPressed: () => _cancelPasswordUpdate(context),
      label: "Remember your password?",
      buttonLabel: "Sign in",
    );
  }

  void _cancelPasswordUpdate(BuildContext context) {
    context
      ..read<UpdatePasswordCubit>().clear()
      ..read<UpdatePasswordFormCubit>().clear()
      ..read<ValidationCodeCubit>().clear();

    SignInPage.go();
  }
}
