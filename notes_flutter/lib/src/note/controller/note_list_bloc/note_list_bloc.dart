import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(const NoteListState.empty()) {
    on<NoteListRepositorySubscriptionEvent>(_noteListRepositorySubscription);
  }

  Future<void> _noteListRepositorySubscription(
    NoteListRepositorySubscriptionEvent event,
    Emitter<NoteListState> emit,
  ) async {
    await emit.forEach(
      di<NoteListRepository>().stream,
      onData: (message) {
        switch (message) {
          case NoteListFetchingMessage():
            log("fetching notes");
            return state.copyWith(fetching: true);
          case NoteListLoadedMessage(:final notes):
            log("fetched ${message.notes.length} note(s)");
            return NoteListState(notes: notes, fetching: false);
          case NoteListCreatedMessage(note: final createdNote):
            log("created note @ ${createdNote.created.toIso8601String()}");
            return state.copyWith(
              notes: [...state.notes, createdNote]
                ..sort(_compareNotesByCreationDateTimeDescending),
            );
          case NoteListUpdatedMessage(note: final updatedNote):
            log("updated note @ ${updatedNote.id}");
            return state.copyWith(
              notes: [
                for (final note in state.notes)
                  if (note.id != updatedNote.id) note else updatedNote,
              ]..sort(_compareNotesByCreationDateTimeDescending),
            );
          case NoteListDeletedMessage(note: final deletedNote):
            log("deleted note @ ${deletedNote.id}");
            return state.copyWith(
              notes: [
                for (final note in state.notes)
                  if (note.id != deletedNote.id) note,
              ],
            );
        }

        return state;
      },
    );
  }
}

int _compareNotesByCreationDateTimeDescending(Note a, Note b) {
  return b.created.compareTo(a.created);
}
