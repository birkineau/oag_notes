import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UpdatePasswordValidationSubtitle extends StatelessWidget {
  const UpdatePasswordValidationSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = NotesTheme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: "An email with a password update code has been sent to:\n",
          ),
          TextSpan(
            text: context.read<UpdatePasswordFormCubit>().state.email.value,
            style: textStyle?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      style: textStyle,
    );
  }
}
