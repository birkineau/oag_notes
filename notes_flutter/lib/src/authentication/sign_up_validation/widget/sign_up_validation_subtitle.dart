import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// Displays a message indicating that a validation code has been sent to the
/// user's email address that was used to sign up.
class SignUpValidationSubtitle extends StatelessWidget {
  const SignUpValidationSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = NotesTheme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Hero(
      tag: "auth_subtitle",
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: "An email with a validation code has been sent to:\n",
            ),
            TextSpan(
              text: context.read<SignUpCredentialsCubit>().state.email.value,
              style: textStyle?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        style: textStyle,
      ),
    );
  }
}
