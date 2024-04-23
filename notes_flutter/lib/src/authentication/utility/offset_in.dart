import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notes_flutter/notes_flutter.dart';

class OffsetIn extends StatefulWidget {
  const OffsetIn({
    required this.beginOffset,
    required this.child,
    super.key,
    this.endOffset = Offset.zero,
  });

  final Offset beginOffset;
  final Offset endOffset;
  final Widget child;

  @override
  State<OffsetIn> createState() => _OffsetInState();
}

class _OffsetInState extends State<OffsetIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: DurationConstants.mediumAnimation,
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        _animationController.forward(from: .0);
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
        return Transform.translate(
          offset: _offsetAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
