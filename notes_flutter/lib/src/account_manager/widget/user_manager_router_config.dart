import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

GoRouter createUserManagerRouterConfiguration() {
  final navigatorKey = di.registerSingleton(
    GlobalKey<NavigatorState>(),
    instanceName: UserManagerPage.navigatorKeyInstanceName,
  );

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: UserManagerListNestedPage.path,
    routes: [
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: UserManagerListNestedPage.path,
        pageBuilder: UserManagerListNestedPage.pageBuilder,
        routes: [
          GoRoute(
            path: getSubPath(UserManagerDetailNestedPage.path),
            pageBuilder: UserManagerDetailNestedPage.pageBuilder,
          ),
        ],
      ),
    ],
  );
}

BuildContext userManagerNavigatorContext() {
  final context = di
      .get<GlobalKey<NavigatorState>>(
        instanceName: UserManagerPage.navigatorKeyInstanceName,
      )
      .currentContext;

  assert(
    context != null,
    "No user manager navigation context found; "
    "Did you forget to add the navigator key to the GoRouter configuration?",
  );

  return context!;
}
