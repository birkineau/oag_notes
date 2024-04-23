import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UserManagerListNestedPage extends StatelessWidget {
  const UserManagerListNestedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = context.watch<AccountManagerCubit>().state.values;

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final userWithTags = users[index];

        return UserManagerListCard(
          key: ValueKey(userWithTags.user.id),
          userWithTags: userWithTags,
        );
      },
    );
  }

  static const path = "/users";

  static void go() {
    userManagerNavigatorContext().go(path);
  }

  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: sharedZAxisTransitionBuilder,
      child: ColoredBox(
        color: NotesTheme.colorScheme.primaryContainer,
        child: const UserManagerListNestedPage(),
      ),
    );
  }
}
