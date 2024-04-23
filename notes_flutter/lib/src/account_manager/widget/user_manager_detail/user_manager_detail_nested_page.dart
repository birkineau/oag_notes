import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UserManagerDetailNestedPage extends StatelessWidget {
  const UserManagerDetailNestedPage({
    super.key,
    required this.userWithTags,
  });

  final UserWithTags userWithTags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            _CloseBtn(userWithTags: userWithTags),
          ],
        ),
        CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.person),
        ),
        Text(userWithTags.user.email),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            for (final tag in userWithTags.tags)
              Chip(
                label: Text(
                  tag.name,
                  style: NotesTheme.textTheme.bodySmall,
                ),
              ),
            SizedBox(
              width: 40.0,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static const path = "${UserManagerListNestedPage.path}/user";

  static void go({required UserWithTags userWithTags}) {
    userManagerNavigatorContext().go(path, extra: userWithTags);
  }

  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    if (state.extra case final UserWithTags userWithTags) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: sharedZAxisTransitionBuilder,
        child: ColoredBox(
          color: NotesTheme.colorScheme.primaryContainer,
          child: UserManagerDetailNestedPage(userWithTags: userWithTags),
        ),
      );
    }

    throw StateError(
      "GoRouterState.extra instance is not of type $UserWithTags.",
    );
  }
}

class _CloseBtn extends StatefulWidget {
  const _CloseBtn({
    super.key,
    required this.userWithTags,
  });

  final UserWithTags userWithTags;

  @override
  State<_CloseBtn> createState() => _CloseBtnState();
}

class _CloseBtnState extends State<_CloseBtn>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34.0,
      height: 34.0,
      child: FilledButton(
        onPressed: () => _closeDetail(context),
        style: NotesTheme.filledButtonStyle.copyWith(
          backgroundColor: MaterialStatePropertyAll(
            NotesTheme.colorScheme.surface,
          ),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        ),
        child: const Icon(Icons.close),
      ),
    );
  }

  void _closeDetail(BuildContext context) {
    context.read<SelectorCubit<UserWithTags>>().set(null);
    // userManagerNavigatorContext().go(UserManagerListNestedPage.path);
    userManagerNavigatorContext().pop();
  }
}
