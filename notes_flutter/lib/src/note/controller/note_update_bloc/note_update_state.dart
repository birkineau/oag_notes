part of 'note_update_bloc.dart';

final class NodeUpdateState extends Equatable {
  const NodeUpdateState({required this.note});

  const NodeUpdateState.empty() : note = null;

  final Note? note;

  @override
  List<Object?> get props => [
        note,
      ];
}
