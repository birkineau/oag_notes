import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UserActionConfirmation extends StatelessWidget {
  const UserActionConfirmation({
    super.key,
    required this.heroTag,
    required this.onCancel,
    required this.onConfirm,
    required this.backgroundColor,
    this.foregroundColor = Colors.black,
    required this.title,
    required this.description,
  });

  final String heroTag;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Color backgroundColor;
  final Color foregroundColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final content = ColoredBox(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: NotesTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: foregroundColor,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              description,
              textAlign: TextAlign.justify,
              style: NotesTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: foregroundColor,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onCancel,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text("cancel"),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: FilledButton(
                    onPressed: onConfirm,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("confirm"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Hero(
      tag: heroTag,
      flightShuttleBuilder: _flightShuttleBuilder,
      child: content,
    );
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final bounds = toHeroContext.findRenderObject()?.paintBounds;

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      ),
      axisAlignment: -1.0,
      child: SizedBox.fromSize(
        size: bounds?.size,
        child: ColoredBox(color: backgroundColor),
      ),
    );
  }

  static Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state, {
    required Color backgroundColor,
    Color foregroundColor = Colors.black,
    required String title,
    required String description,
  }) {
    final user = state.extra as User?;

    if (user == null) {
      throw ArgumentError(
        "Missing user in extra data for ActionConfirmation page",
      );
    }

    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: noTransitionBuilder,
      child: UserActionConfirmation(
        heroTag: title,
        onCancel: () {
          userActionNavigatorContext().go(UserActionSelector.path, extra: user);
        },
        onConfirm: () async {
          userActionNavigatorContext().go(UserActionSelector.path, extra: user);
          await context.read<AccountManagerCubit>().block(user.id!);
        },
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        title: title,
        description: description,
      ),
    );
  }
}
