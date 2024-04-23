import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';

class AuthTransitionButton extends StatelessWidget {
  const AuthTransitionButton({
    required this.label,
    required this.buttonLabel,
    super.key,
    this.heroTag,
    this.onPressed,
  });

  final String? heroTag;
  final VoidCallback? onPressed;
  final String label;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final button = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: NotesTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonLabel),
        ),
      ],
    );

    return SizedBox(
      height: 32.0,
      child: heroTag != null
          ? Hero(
              tag: heroTag!,
              flightShuttleBuilder: offsetFadeFlightShuttleBuilder,
              child: button,
            )
          : button,
    );
  }
}
