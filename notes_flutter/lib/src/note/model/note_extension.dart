import 'package:notes_client/notes_client.dart';

extension NoteExtension on Note {
  static Note create({required String text}) {
    final now = DateTime.now();

    return Note(
      text: text,
      created: now,
      updated: now,
      active: true,
    );
  }
}
