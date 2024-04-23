import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FadeScaleIn extends StatefulWidget {
  const FadeScaleIn({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.delay = Duration.zero,
    this.curve = Curves.linear,
    required this.from,
    required this.child,
    this.to = 1.0,
  });

  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double from;
  final double to;
  final Widget child;

  @override
  State<FadeScaleIn> createState() => _FadeScaleInState();
}

class _FadeScaleInState extends State<FadeScaleIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    _scaleAnimation = widget.from == widget.to
        ? ConstantTween(1.0).animate(_animationController)
        : Tween<double>(begin: widget.from, end: widget.to).animate(curve);

    _opacityAnimation = Tween<double>(begin: .0, end: 1.0).animate(curve);

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        return _playAnimationWithDelay();
      },
    );
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
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  Future<void> _playAnimationWithDelay() async {
    if (widget.delay != Duration.zero) {
      await Future<void>.delayed(widget.delay);
    }

    if (!mounted) {
      return;
    }

    return _animationController.forward();
  }
}
