import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

Widget sharedAxisTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  SharedAxisTransitionType type,
  Widget child,
) {
  return SharedAxisTransition(
    animation: animation,
    secondaryAnimation: secondaryAnimation,
    transitionType: type,
    fillColor: Colors.transparent,
    child: child,
  );
}

Widget sharedXAxisTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return sharedAxisTransitionBuilder(
    context,
    animation,
    secondaryAnimation,
    SharedAxisTransitionType.horizontal,
    child,
  );
}

Widget sharedYAxisTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return sharedAxisTransitionBuilder(
    context,
    animation,
    secondaryAnimation,
    SharedAxisTransitionType.vertical,
    child,
  );
}

Widget sharedZAxisTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return sharedAxisTransitionBuilder(
    context,
    animation,
    secondaryAnimation,
    SharedAxisTransitionType.scaled,
    child,
  );
}

Widget noTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}

Widget fadeTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

Widget slideTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final slideAnimation = Tween<Offset>(
    begin: const Offset(1.0, .0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: animation,
      curve: Curves.fastLinearToSlowEaseIn,
    ),
  );

  return SlideTransition(
    position: slideAnimation,
    child: child,
  );
}
