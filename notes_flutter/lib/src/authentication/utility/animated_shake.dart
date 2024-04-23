import 'package:flutter/material.dart';

class AnimatedShake extends StatefulWidget {
  const AnimatedShake({
    super.key,
    this.duration = const Duration(milliseconds: 300),
    required this.child,
  });

  final Duration duration;
  final Widget child;

  @override
  State<AnimatedShake> createState() => _AnimatedShakeState();
}

class _AnimatedShakeState extends State<AnimatedShake>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    const offsetValue = 8.0;
    const leftOffset = Offset(-offsetValue, .0);
    const rightOffset = Offset(offsetValue, .0);

    _shakeAnimation = TweenSequence<Offset>(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem(
          tween: Tween<Offset>(begin: Offset.zero, end: rightOffset),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(begin: rightOffset, end: leftOffset),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(begin: leftOffset, end: rightOffset),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(begin: rightOffset, end: Offset.zero),
          weight: 1.0,
        ),
      ],
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
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
        return Transform.translate(
          offset: _shakeAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
