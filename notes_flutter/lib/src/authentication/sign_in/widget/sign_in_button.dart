import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// A button that sends a sign-in request to the server.
class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final hasCredentials = context.select<SignInCredentialsCubit, bool>(
      (cubit) => cubit.state.isValid && cubit.state.password.isNotEmpty,
    );

    final signInStatus = context.select<SignInCubit, SignInStatus>(
      (cubit) => cubit.state.status,
    );

    final Widget buttonContent;

    if (signInStatus == SignInStatus.signingIn) {
      buttonContent = const CircularProgressIndicator(
        key: ValueKey("sign_in_progress_indicator"),
      );
    } else {
      buttonContent = Text(
        key: const ValueKey("sign_in_button_text"),
        "Sign in",
        style: NotesTheme.textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      );
    }

    return AuthActionButton(
      onPressed: hasCredentials && signInStatus == SignInStatus.signedOut
          ? () => _signIn(context)
          : null,
      child: Align(child: buttonContent),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final SignInCredentialsState(:email, :password) =
        context.read<SignInCredentialsCubit>().state;

    return context.read<SignInCubit>().signIn(
          email: email.value,
          password: password,
        );
  }
}
