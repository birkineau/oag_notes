import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

class NoteSaveButton extends StatefulWidget {
  const NoteSaveButton({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  State<NoteSaveButton> createState() => _NoteSaveButtonState();
}

class _NoteSaveButtonState extends State<NoteSaveButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateButtonEnabledBasedOnText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateButtonEnabledBasedOnText);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = FilledButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.padded,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );

    return FilledButton(
      onPressed: widget.controller.text.isEmpty
          ? null
          : () {
              _saveNote(context);
            },
      style: buttonStyle,
      child: const Text(
        "save",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.5,
        ),
      ),
    );
  }

  Future<void> _saveNote(BuildContext context) async {
    final now = DateTime.now();
    var editedNote = context.read<NoteUpdateBloc>().state.note;

    if (editedNote != null) {
      editedNote = editedNote.copyWith(
        text: widget.controller.text,
        created: now,
      );

      await di<NoteListRepository>().update(note: editedNote);
    } else {
      final note = NoteExtension.create(text: widget.controller.text);
      await di<NoteListRepository>().create(note: note);
    }

    if (!context.mounted) {
      return;
    }

    FocusScope.of(context).unfocus();

    widget.controller.clear();
  }

  void _updateButtonEnabledBasedOnText() {
    setState(
      () {
        /// Rebuild the widget when the text changes to enable or disable the
        /// button.
      },
    );
  }
}
