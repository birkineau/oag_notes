import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// A standardized label text widget for the [SignInForm], [SignUpForm],
/// [SignUpValidationForm], and [UpdatePasswordForm] forms.
class FormText extends StatelessWidget {
  /// Creates a [FormText] widget with the provided [text] and [textAlign].
  const FormText({
    required this.text,
    super.key,
    this.textAlign = TextAlign.justify,
  });

  /// The text label to display.
  final String text;

  /// The alignment of the text.
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: NotesTheme.textTheme.bodyMedium?.copyWith(
        color: NotesTheme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
