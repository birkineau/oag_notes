import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

part 'note_update_event.dart';
part 'note_update_state.dart';

class NoteUpdateBloc extends Bloc<NoteUpdateEvent, NodeUpdateState> {
  NoteUpdateBloc() : super(const NodeUpdateState.empty()) {
    on<NoteUpdateRepositorySubscriptionEvent>(_subscription);
    on<NoteUpdateBeginEvent>(_onBegin);
    on<NoteUpdateSaveEvent>(_onSave);
    on<NoteUpdateCancelEvent>(_onCancel);
  }

  Future<void> _subscription(
    NoteUpdateRepositorySubscriptionEvent event,
    Emitter<NodeUpdateState> emit,
  ) async {
    await emit.forEach(
      di<NoteListRepository>().stream,
      onData: (message) {
        if (message case NoteListUpdatedMessage(note: final Note _)) {
          return const NodeUpdateState.empty();
        }

        if (message is NoteListUpdateCancelledMessage) {
          return const NodeUpdateState.empty();
        }

        return state;
      },
    );
  }

  void _onBegin(NoteUpdateBeginEvent event, Emitter<NodeUpdateState> emit) {
    emit(NodeUpdateState(note: event.note));
  }

  Future<void> _onSave(
    NoteUpdateSaveEvent event,
    Emitter<NodeUpdateState> emit,
  ) async {
    await di<NoteListRepository>().update(note: event.note);
    emit(const NodeUpdateState.empty());
  }

  Future<void> _onCancel(
    NoteUpdateCancelEvent event,
    Emitter<NodeUpdateState> emit,
  ) async {
    emit(const NodeUpdateState.empty());
  }
}
