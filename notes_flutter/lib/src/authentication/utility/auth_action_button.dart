import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

class AuthActionButton extends StatefulWidget {
  const AuthActionButton({
    required this.child,
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<AuthActionButton> createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final ColorTween _gradientColorTweenBegin;
  late final ColorTween _gradientColorTweenEnd;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: DurationConstants.shortAnimation,
    );

    _gradientColorTweenBegin = ColorTween(
      begin: Colors.grey.shade500,
      end: NotesTheme.colorScheme.primary,
    );

    _gradientColorTweenEnd = ColorTween(
      begin: Colors.grey.shade400,
      end: NotesTheme.colorScheme.primary.lighten(40),
    );

    if (widget.onPressed != null) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AuthActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.onPressed != oldWidget.onPressed) {
      if (widget.onPressed == null) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Hero(
        tag: "auth_action_button",
        flightShuttleBuilder: _buttonFlightShuttleBuilder,
        child: ScaleButton(
          onPressed: widget.onPressed,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _gradientColorTweenBegin.evaluate(_animationController)!,
                      _gradientColorTweenEnd.evaluate(_animationController)!,
                    ],
                    stops: const [.225, 1.0],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: child,
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buttonFlightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: toHeroContext.widget,
      ),
    );
  }
}
