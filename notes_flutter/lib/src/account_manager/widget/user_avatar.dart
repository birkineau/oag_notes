import 'package:flutter/material.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: NotesTheme.colorScheme.primaryContainer,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4.0),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(Icons.person),
        // child: user.photoUrl == null
        //     ? const Icon(Icons.person)
        //     : Image(image: NetworkImage(user.photoUrl!)),
      ),
    );
  }
}
