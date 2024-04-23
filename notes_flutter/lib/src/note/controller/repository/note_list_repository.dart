import 'dart:async';

import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

part 'note_list_repository_message.dart';

class NoteListRepository implements Repository<NoteListRepositoryMessage> {
  NoteListRepository()
      : _source = DataSource<NoteListRepositoryMessage>(
          const NoteListRepositoryMessage(),
        );

  final DataSource<NoteListRepositoryMessage> _source;

  Future<void> create({required Note note}) async {
    final id = await di<Client>().notes.createNote(note);

    if (id == null) {
      throw Exception('Failed to create note');
    }

    _source.add(NoteListCreatedMessage(note: note.copyWith(id: id)));
  }

  Future<void> update({required Note note}) async {
    final updatedNote = await di<Client>().notes.updateNote(note);
    _source.add(NoteListUpdatedMessage(note: updatedNote));
  }

  Future<void> delete({required Note note}) async {
    await di<Client>().notes.deleteNote(note);
    _source.add(NoteListDeletedMessage(note: note));
  }

  Future<void> getNotes() async {
    _source.add(const NoteListFetchingMessage());
    await Future<void>.delayed(const Duration(seconds: 1));
    final notes = await di<Client>().notes.getNotes();
    _source.add(NoteListLoadedMessage(notes: notes));
  }

  @override
  NoteListRepositoryMessage get last {
    return _source.last;
  }

  @override
  Stream<NoteListRepositoryMessage> get stream {
    return _source.getConfiguredStream();
  }

  @override
  RepositorySubscriber<NoteListRepositoryMessage> listen({
    required FutureOr<void> Function(NoteListRepositoryMessage p1) listener,
    FutureOr<bool> Function(
      NoteListRepositoryMessage p1,
      NoteListRepositoryMessage p2,
    )? listenWhen,
    void Function(Object p1, StackTrace p2)? onError,
  }) {
    return _source.listen(
      listenWhen: listenWhen,
      listener: listener,
      onError: onError,
    );
  }

  @override
  FutureOr<void> close() {
    return _source.close();
  }
}
