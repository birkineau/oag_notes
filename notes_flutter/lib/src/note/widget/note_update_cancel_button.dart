import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/note/note.dart';

class NoteUpdateCancelButton extends StatelessWidget {
  const NoteUpdateCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.padded,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );

    return TextButton(
      onPressed: () {
        context.read<NoteUpdateBloc>().add(const NoteUpdateCancelEvent());
        FocusScope.of(context).unfocus();
      },
      style: buttonStyle,
      child: const Text("cancel"),
    );
  }
}
