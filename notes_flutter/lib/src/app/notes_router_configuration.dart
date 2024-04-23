import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// Creates the application router configuration.
GoRouter createRouterConfiguration() {
  final navigatorKey = di.registerSingleton(GlobalKey<NavigatorState>());

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: SignInPage.path,
    routes: [
      ShellRoute(
        parentNavigatorKey: navigatorKey,
        builder: (context, state, child) {
          return Scaffold(body: child);
        },
        routes: [
          GoRoute(
            path: SignInPage.path,
            pageBuilder: SignInPage.pageBuilder,
            routes: [
              GoRoute(
                path: getSubPath(SignUpPage.path),
                pageBuilder: SignUpPage.pageBuilder,
              ),
              GoRoute(
                path: getSubPath(SignUpValidationPage.path),
                pageBuilder: SignUpValidationPage.pageBuilder,
              ),
              GoRoute(
                path: getSubPath(UpdatePasswordPage.path),
                pageBuilder: UpdatePasswordPage.pageBuilder,
              ),
            ],
          ),
          GoRoute(
            path: UserManagerPage.path,
            pageBuilder: UserManagerPage.pageBuilder,
          ),
          GoRoute(
            path: NotesPage.path,
            pageBuilder: NotesPage.pageBuilder,
          ),
          GoRoute(
            path: TransientPage.path,
            pageBuilder: TransientPage.pageBuilder,
          ),
        ],
      ),
    ],
  );
}

/// Returns the navigation context used by the application.
BuildContext navigatorContext() {
  final context = di<GlobalKey<NavigatorState>>().currentContext;

  if (context == null) {
    throw Exception(
      "No navigation context found; "
      "did you forget to add the navigator key to the GoRouter configuration?",
    );
  }

  return context;
}

String navigatorPath() {
  final routerDelegate = GoRouter.of(navigatorContext()).routerDelegate;

  final lastMatch = routerDelegate.currentConfiguration.last;

  final matchList = lastMatch is ImperativeRouteMatch
      ? lastMatch.matches
      : routerDelegate.currentConfiguration;

  return matchList.uri.toString();
}

String getSubPath(String path) {
  final subpath = path.split("/").last;
  return subpath;
}
