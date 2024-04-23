import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

class UpdatePasswordValidationTitle extends StatelessWidget {
  const UpdatePasswordValidationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AuthTitle(text: "Account recovery"),
        const Spacer(),
        IconButton(
          onPressed: () => _returnToSignInPage(context),
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 32.0,
          ),
        ),
      ],
    );
  }

  Future<void> _returnToSignInPage(BuildContext context) async {
    context
      ..read<UpdatePasswordCubit>().clear()
      ..read<UpdatePasswordFormCubit>().clear()
      ..read<ValidationCodeCubit>().clear();

    SignInPage.go();
  }
}
