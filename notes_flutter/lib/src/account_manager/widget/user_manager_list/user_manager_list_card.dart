import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart' hide AnimatedIntrinsicSize;

/// TODO: create accounts
/// TODO: delete accounts
/// TODO: update accounts
///   - reset password (automatically send email w/code)
///   - update scopes
///   - update email
///   - update name
///   - update profile image
class UserManagerListCard extends StatelessWidget {
  const UserManagerListCard({
    super.key,
    required this.userWithTags,
  });

  final UserWithTags userWithTags;

  @override
  Widget build(BuildContext context) {
    final isVerified = userWithTags.tags.any((tag) => tag == TagType.verified);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userWithTags.user.email,
                      overflow: TextOverflow.ellipsis,
                      style: NotesTheme.textTheme.bodySmall,
                    ),
                    Text(
                      DateFormat("MMMM d, yyyy @ h:mm a").format(
                        userWithTags.user.created.toLocal(),
                      ),
                      style: NotesTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 34.0,
                height: 34.0,
                child: FilledButton(
                  style: NotesTheme.filledButtonStyle.copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                      NotesTheme.colorScheme.surface,
                    ),
                    padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                  onPressed: () => _openDetail(context),
                  child: const Icon(Icons.edit, size: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context) {
    context.read<SelectorCubit<UserWithTags>>().set(userWithTags);
    UserManagerDetailNestedPage.go(userWithTags: userWithTags);
  }
}
