import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_client/notes_client.dart';

import '../note.dart';

class NoteTextField extends StatefulWidget {
  const NoteTextField({super.key});

  @override
  State<NoteTextField> createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  static const int _maxCharacters = 200;

  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textFieldBottomBarHeight = 40.0;

    final textField = Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 2.0, right: 2.0),
            child: BlocListener<NoteUpdateBloc, NodeUpdateState>(
              listener: (context, state) {
                switch (state) {
                  case const NodeUpdateState.empty():
                    _textEditingController.clear();
                    break;
                  case NodeUpdateState(note: final Note note):
                    _textEditingController.text = note.text;
                    break;
                }
              },
              child: TextField(
                controller: _textEditingController,
                maxLines: null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_maxCharacters),
                ],
                decoration: const InputDecoration(
                  hintText: "Write a note!",
                  contentPadding: EdgeInsets.only(
                    bottom: textFieldBottomBarHeight,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Positioned(
            height: 36.0,
            bottom: .0,
            left: .0,
            right: .0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                NoteCounter(
                  controller: _textEditingController,
                  maxCharacters: _maxCharacters,
                ),
                Row(
                  children: [
                    BlocBuilder<NoteUpdateBloc, NodeUpdateState>(
                      builder: (context, state) {
                        if (state.note == null) {
                          return const SizedBox.shrink();
                        } else {
                          return const NoteUpdateCancelButton();
                        }
                      },
                    ),
                    const SizedBox(width: 8.0),
                    NoteSaveButton(controller: _textEditingController)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<NoteUpdateBloc, NodeUpdateState>(
          builder: (context, state) {
            return Text(
              state.note == null ? "create note" : "update note",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            );
          },
        ),
        const SizedBox(height: 8.0),
        textField,
      ],
    );
  }
}
