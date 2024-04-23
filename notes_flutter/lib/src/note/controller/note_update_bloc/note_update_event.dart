part of 'note_update_bloc.dart';

sealed class NoteUpdateEvent {
  const NoteUpdateEvent();
}

final class NoteUpdateRepositorySubscriptionEvent extends NoteUpdateEvent {
  const NoteUpdateRepositorySubscriptionEvent();
}

final class NoteUpdateBeginEvent extends NoteUpdateEvent {
  const NoteUpdateBeginEvent({required this.note});

  final Note note;
}

final class NoteUpdateSaveEvent extends NoteUpdateEvent {
  const NoteUpdateSaveEvent({required this.note});

  final Note note;
}

final class NoteUpdateCancelEvent extends NoteUpdateEvent {
  const NoteUpdateCancelEvent();
}
