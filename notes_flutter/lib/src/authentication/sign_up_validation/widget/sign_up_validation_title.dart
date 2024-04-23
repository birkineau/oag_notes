import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

/// The title for the sign-up validation page.
///
/// The title contains the text "Account validation" and a back button to return
/// to the sign-in page.
class SignUpValidationTitle extends StatelessWidget {
  const SignUpValidationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AuthTitle(text: "Account validation"),
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
    final signUpCredentialsCubit = context.read<SignUpCredentialsCubit>();

    context.read<SignInCredentialsCubit>()
      ..setEmail(signUpCredentialsCubit.state.email.value)
      ..setPassword("");

    signUpCredentialsCubit.clear();

    context
      ..read<SignInCubit>().reset()
      ..read<SignUpCubit>().reset()
      ..read<ValidationCodeCubit>().clear();

    SignInPage.go();
  }
}
