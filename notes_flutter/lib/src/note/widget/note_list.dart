import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              "previous notes",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
            const Spacer(),
            BlocSelector<NoteListBloc, NoteListState, bool>(
              selector: (state) => state.fetching,
              builder: (context, fetching) {
                return IconButton(
                  onPressed: fetching
                      ? null
                      : () => di<NoteListRepository>().getNotes(),
                  icon: const Icon(Icons.refresh),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: BlocBuilder<NoteListBloc, NoteListState>(
            builder: (context, state) {
              final Widget child;

              if (state.fetching) {
                child = const Center(
                  key: ValueKey("note_list_fetching"),
                  child: CircularProgressIndicator(),
                );
              } else {
                child = ListView.separated(
                  key: const ValueKey("note_list_result"),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];

                    return NoteListCard(
                      key: ValueKey("note_${note.id ?? index}"),
                      note: note,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 6.0);
                  },
                );
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}
