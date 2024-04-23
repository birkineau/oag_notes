import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';
// import 'package:oag_utils/oag_utils.dart';

export 'user_action_confirmation.dart';
export 'user_action_selector.dart';
export 'user_action_selector_button.dart';

class UserActionToolbar extends StatefulWidget {
  const UserActionToolbar({
    super.key,
    required this.userWithTags,
  });

  final UserWithTags userWithTags;

  @override
  State<UserActionToolbar> createState() => _UserActionToolbarState();
}

class _UserActionToolbarState extends State<UserActionToolbar>
    with SingleTickerProviderStateMixin {
  late final GoRouter _routerConfig;

  @override
  void initState() {
    super.initState();

    _routerConfig = createUserActionButtonRouterConfig(
      vsync: this,
      user: widget.userWithTags.user,
    );
  }

  @override
  void dispose() {
    di.unregister<GlobalKey<NavigatorState>>(
      instanceName: UserActionSelector.navigatorKeyInstanceName,
    );

    _routerConfig.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Router.withConfig(config: _routerConfig);
  }
}

GoRouter createUserActionButtonRouterConfig({
  required TickerProvider vsync,
  required User user,
}) {
  return GoRouter(
    initialExtra: user,
    navigatorKey: di.registerSingleton(
      GlobalKey<NavigatorState>(),
      instanceName: UserActionSelector.navigatorKeyInstanceName,
    ),
    initialLocation: UserActionSelector.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AnimatedIntrinsicSize(
            vsync: vsync,
            duration: DurationConstants.shortAnimation,
            curve: Curves.linear,
            child: KeyedSubtree(
              key: ValueKey(state.matchedLocation),
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: UserActionSelector.path,
            pageBuilder: UserActionSelector.pageBuilder,
          ),
          GoRoute(
            path: "/block",
            pageBuilder: (context, state) => UserActionConfirmation.pageBuilder(
              context,
              state,
              backgroundColor: Colors.amber,
              title: "block",
              description: "Blocking a user will prevent them from being able "
                  "to sign in. Are you sure?",
            ),
          ),
          GoRoute(
            path: "/delete",
            pageBuilder: (context, state) => UserActionConfirmation.pageBuilder(
              context,
              state,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              title: "delete",
              description: "Deleting a user will remove their credentials "
                  "permanently. Are you sure? This operation is irreversible.",
            ),
          ),
        ],
      ),
    ],
  );
}

BuildContext userActionNavigatorContext() {
  final context = di
      .get<GlobalKey<NavigatorState>>(
        instanceName: UserActionSelector.navigatorKeyInstanceName,
      )
      .currentContext;

  assert(
    context != null,
    "No user action navigation context found; "
    "Did you forget to add the navigator key to the GoRouter configuration?",
  );

  return context!;
}
