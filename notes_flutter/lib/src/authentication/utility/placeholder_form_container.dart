import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';

class PlaceholderFormContainer extends StatelessWidget {
  const PlaceholderFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NotesTheme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
