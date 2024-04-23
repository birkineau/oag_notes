part of 'note_list_bloc.dart';

final class NoteListState extends Equatable {
  const NoteListState({
    required this.notes,
    required this.fetching,
  });

  const NoteListState.empty()
      : notes = const <Note>[],
        fetching = false;

  final List<Note> notes;
  final bool fetching;

  NoteListState copyWith({
    List<Note>? notes,
    bool? fetching,
  }) {
    return NoteListState(
      notes: notes ?? this.notes,
      fetching: fetching ?? this.fetching,
    );
  }

  @override
  List<Object?> get props => [
        notes,
        fetching,
      ];
}
