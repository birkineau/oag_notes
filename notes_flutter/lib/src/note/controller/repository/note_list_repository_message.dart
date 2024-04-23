part of 'note_list_repository.dart';

final class NoteListRepositoryMessage {
  const NoteListRepositoryMessage();
}

final class NoteListFetchingMessage extends NoteListRepositoryMessage {
  const NoteListFetchingMessage();
}

final class NoteListLoadedMessage extends NoteListRepositoryMessage {
  const NoteListLoadedMessage({required this.notes});

  final List<Note> notes;
}

final class NoteListCreatedMessage extends NoteListRepositoryMessage {
  const NoteListCreatedMessage({required this.note});

  final Note note;
}

final class NoteListUpdatedMessage extends NoteListRepositoryMessage {
  const NoteListUpdatedMessage({required this.note});

  final Note note;
}

final class NoteListUpdateCancelledMessage extends NoteListRepositoryMessage {
  const NoteListUpdateCancelledMessage();
}

final class NoteListDeletedMessage extends NoteListRepositoryMessage {
  const NoteListDeletedMessage({required this.note});

  final Note note;
}
