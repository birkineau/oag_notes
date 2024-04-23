import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class NoteListCard extends StatelessWidget {
  const NoteListCard({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MMM-dd @ h:mm a');

    final buttonStyle = IconButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: IconButton(
                  onPressed: () {
                    _beginEditingNote(context);
                  },
                  style: buttonStyle,
                  icon: const Icon(Icons.edit, size: 18.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  dateFormat.format(note.updated.toLocal()),
                  style: TextStyle(
                    color: note.active ? Colors.green : Colors.amber,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: IconButton(
                  onPressed: () {
                    di<NoteListRepository>().delete(note: note);
                  },
                  style: buttonStyle,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade300),
          Text(note.text),
          Align(
            alignment: Alignment.centerRight,
            child: NoteLastUpdatedLabel(note: note),
          ),
        ],
      ),
    );
  }

  void _beginEditingNote(BuildContext context) {
    context.read<NoteUpdateBloc>().add(NoteUpdateBeginEvent(note: note));
  }
}

class NoteActiveIndicator extends StatelessWidget {
  const NoteActiveIndicator({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return const Text("1");
  }
}

/// This shows the difference between the note's created and updated times.
/// TODO: show show the time since the actual last update.
class NoteLastUpdatedLabel extends StatelessWidget {
  const NoteLastUpdatedLabel({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final duration = note.created.difference(note.updated);
    final components = <String>[];

    final days = duration.inDays;
    if (days != 0) {
      components.add('$days ${days == 1 ? 'day' : 'days'}');
    }

    final hours = duration.inHours % 24;
    if (hours != 0) {
      if (days != 0) {
        components.add(" ");
      }
      components.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }

    final minutes = duration.inMinutes % 60;
    if (minutes != 0) {
      if (days != 0 || hours != 0) {
        components.add(" ");
      }
      components.add('$minutes ${minutes == 1 ? 'minute' : 'minutes'}');
    }

    final label = components.join();

    if (label.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text("Created $label ago."),
    );
  }
}
