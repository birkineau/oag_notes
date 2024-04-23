import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

class UserActionSelectorButton extends StatelessWidget {
  const UserActionSelectorButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    this.foregroundColor = Colors.black,
    required this.title,
    required this.iconData,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final content = GestureDetector(
      onTap: onPressed,
      child: ColoredBox(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: NotesTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: foregroundColor,
                ),
              ),
              const SizedBox(height: 2.0),
              Icon(
                iconData,
                size: 24.0,
                color: foregroundColor,
              ),
            ],
          ),
        ),
      ),
    );

    return Hero(
      tag: title,
      child: content,
    );
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      child: toHeroContext.widget,
    );
  }
}
