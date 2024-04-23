part of 'note_list_bloc.dart';

sealed class NoteListEvent {
  const NoteListEvent();
}

final class NoteListRepositorySubscriptionEvent extends NoteListEvent {
  const NoteListRepositorySubscriptionEvent();
}

final class NoteListCreateEvent extends NoteListEvent {
  const NoteListCreateEvent({
    required this.note,
  });

  final Note note;
}

final class NoteListDeleteEvent extends NoteListEvent {
  const NoteListDeleteEvent({
    required this.note,
  });

  final Note note;
}
