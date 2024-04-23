import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

class TransientPage extends StatefulWidget {
  const TransientPage({
    super.key,
    required this.nextPath,
    required this.duration,
    required this.child,
  });

  final Duration duration;
  final String nextPath;
  final Widget child;

  @override
  State<TransientPage> createState() => _TransientPageState();

  static const String path = "/transient";

  static void go({
    Duration duration = const Duration(milliseconds: 300),
    required String nextPath,
    required Widget child,
  }) {
    navigatorContext().go(
      path,
      extra: <Object>[
        duration,
        nextPath,
        child,
      ],
    );
  }

  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    if (state.extra
        case [
          final Duration duration,
          final String nextPath,
          final Widget child,
        ]) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: TransientPage(
          duration: duration,
          nextPath: nextPath,
          child: child,
        ),
      );
    }

    throw StateError(
      "Invalid arguments for TransientPage; "
      "Expected (Duration duration, String nextPath, Widget child), but got "
      "${state.extra}",
    );
  }
}

class _TransientPageState extends State<TransientPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      widget.duration,
      () {
        if (mounted) {
          context.go(widget.nextPath);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
