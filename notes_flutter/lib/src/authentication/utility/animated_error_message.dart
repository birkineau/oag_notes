import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';

class AnimatedErrorMessage extends StatefulWidget {
  const AnimatedErrorMessage({
    super.key,
    this.textAlign = TextAlign.start,
    required this.error,
  });

  /// The text alignment of the error message.
  final TextAlign textAlign;

  /// The error message to display.
  final String? error;

  @override
  State<AnimatedErrorMessage> createState() => _AnimatedErrorMessageState();
}

class _AnimatedErrorMessageState extends State<AnimatedErrorMessage> {
  final _offsetKey = GlobalKey<AnimatedOffsetState>();

  String? _error;

  @override
  void didUpdateWidget(AnimatedErrorMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animateError(oldWidget.error, widget.error);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOffset(
        key: _offsetKey,
        child: AnimatedSize(
          duration: DurationConstants.mediumAnimation,
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.topCenter,
          child: _error == null
              ? const SizedBox(width: double.infinity)
              : Text(
                  _error!,
                  textAlign: widget.textAlign,
                  style: NotesTheme.textTheme.bodySmall?.copyWith(
                    color: NotesTheme.colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _animateError(String? oldError, String? newError) async {
    final offsetState = _offsetKey.currentState;
    if (offsetState == null) return;

    if (_error == null && oldError == newError) {
      setState(() => _error = newError);
      await offsetState.show();
    } else if (oldError != null && newError == null) {
      setState(() => _error = null);
      await offsetState.hide();
    } else if (oldError == null && newError != null || oldError != newError) {
      setState(() => _error = newError);
      await offsetState.show();
    }
  }
}

class AnimatedOffset extends StatefulWidget {
  const AnimatedOffset({
    required this.child,
    super.key,
    this.duration = DurationConstants.shortAnimation,
    this.curve = Curves.fastOutSlowIn,
    this.beginOffset = const Offset(.0, 32.0),
    this.endOffset = Offset.zero,
  });

  final Duration duration;
  final Curve curve;
  final Offset beginOffset;
  final Offset endOffset;
  final Widget child;

  @override
  State<AnimatedOffset> createState() => AnimatedOffsetState();
}

class AnimatedOffsetState extends State<AnimatedOffset>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  Future<void> show() async {
    return _animationController.forward(from: .0);
  }

  Future<void> hide() async {
    return _animationController.reverse(from: 1.0);
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(curvedAnimation);

    _opacityAnimation = Tween<double>(
      begin: .0,
      end: 1.0,
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: _offsetAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
