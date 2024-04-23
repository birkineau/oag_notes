import 'package:flutter/material.dart';

class NoteCounter extends StatefulWidget {
  const NoteCounter({
    super.key,
    required this.controller,
    required this.maxCharacters,
  });

  final TextEditingController controller;
  final int maxCharacters;

  @override
  State<NoteCounter> createState() => _NoteCounterState();
}

class _NoteCounterState extends State<NoteCounter> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        "${widget.controller.text.length} / ${widget.maxCharacters}",
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _rebuild() {
    setState(
      () {
        /// Rebuild the widget when the text changes to update the counter.
      },
    );
  }
}
