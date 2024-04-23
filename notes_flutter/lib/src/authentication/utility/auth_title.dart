import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// Standardized title for [SignInPage], [SignUpPage], [SignUpValidationPage],
/// and [UpdatePasswordPage].
///
/// The title is displayed at the top of the page.
class AuthTitle extends StatelessWidget {
  const AuthTitle({
    required this.text,
    super.key,
  });

  /// The text to display in the title.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "auth_title",
      createRectTween: (begin, end) => RectTween(begin: begin, end: end),
      flightShuttleBuilder: offsetFadeFlightShuttleBuilder,
      child: Text(
        text,
        style: NotesTheme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Animates an horizontal offset and opacity when transitioning the
/// [AuthTitle].
Widget offsetFadeFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  final popping = flightDirection == HeroFlightDirection.pop;
  final routeAnimation = popping ? ReverseAnimation(animation) : animation;

  final offsetAnimation = Tween<Offset>(
    begin: const Offset(28.0, .0),
    end: Offset.zero,
  ).animate(routeAnimation);

  final opacityAnimation = CurvedAnimation(
    parent: routeAnimation,
    curve: Curves.easeIn,
    reverseCurve: Curves.easeOut,
  );

  return AnimatedBuilder(
    animation: routeAnimation,
    builder: (context, child) {
      return Opacity(
        opacity: opacityAnimation.value,
        child: Transform.translate(
          offset: offsetAnimation.value,
          child: toHeroContext.widget,
        ),
      );
    },
    child: toHeroContext.widget,
  );
}
