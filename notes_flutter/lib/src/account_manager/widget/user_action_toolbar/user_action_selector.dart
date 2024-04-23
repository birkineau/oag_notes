import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UserActionSelector extends StatelessWidget {
  const UserActionSelector({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          UserActionSelectorButton(
            onPressed: () {
              userActionNavigatorContext().go("/block", extra: user);
            },
            backgroundColor: Colors.amber,
            iconData: Icons.block,
            title: "block",
          ),
          UserActionSelectorButton(
            onPressed: () {
              userActionNavigatorContext().go("/delete", extra: user);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            iconData: Icons.delete_rounded,
            title: "delete",
          ),
        ],
      ),
    );
  }

  static const path = "/actions";

  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    final user = state.extra as User?;

    if (user == null) {
      throw ArgumentError(
        "Missing user in extra data for UserActionSelector page",
      );
    }

    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: noTransitionBuilder,
      child: UserActionSelector(user: user),
    );
  }

  static const navigatorKeyInstanceName = "UserActionSelector";
}
