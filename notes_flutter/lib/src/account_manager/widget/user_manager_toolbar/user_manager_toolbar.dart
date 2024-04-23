import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

enum UserSelectedAction {
  block,
  delete,
}

class UserManagerToolbar extends StatefulWidget {
  const UserManagerToolbar({super.key});

  @override
  State<UserManagerToolbar> createState() => _UserManagerToolbarState();
}

class _UserManagerToolbarState extends State<UserManagerToolbar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final userWithTags = context.watch<SelectorCubit<UserWithTags>>().state;
    final Widget child;

    if (userWithTags != null) {
      child = BlocProvider(
        key: const ValueKey("user_selected_actions_toolbar"),
        create: (context) => SelectorCubit<UserSelectedAction>(),
        child: UserActionToolbar(userWithTags: userWithTags),
      );
    } else {
      child = const UserSearchToolbar(key: ValueKey("user_search_toolbar"));
    }

    return AnimatedIntrinsicSize(
      vsync: this,
      duration: DurationConstants.shortAnimation,
      child: child,
    );
  }
}

class UserSearchToolbar extends StatelessWidget {
  const UserSearchToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      alignment: Alignment.center,
      child: const Text("UserSearchToolbar placeholder"),
    );
  }
}

/// [AnimatedIntrinsicSize] animates to the intrinsic size of its child, if the
/// widget is rebuilt with a different child.
///
/// The [child] must have a non-null key.
class AnimatedIntrinsicSize extends SingleChildRenderObjectWidget {
  const AnimatedIntrinsicSize({
    super.key,
    required this.vsync,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.fastOutSlowIn,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
    this.useChildKey = false,
    required super.child,
  });

  @override
  Key? get key => useChildKey ? child?.key : super.key;

  final TickerProvider vsync;

  /// The animation duration.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// The child's alignment for tight constraints.
  ///
  /// Applied to the child when a constraint is larger than the child size.
  final Alignment alignment;

  final Clip clipBehavior;

  /// If true, the child's key is returned by [AnimatedIntrinsicSize.key].
  final bool useChildKey;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderAnimatedIntrinsicSize(
        vsync: vsync,
        duration: duration,
        curve: curve,
        alignment: alignment,
        childKey: child!.key,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderAnimatedIntrinsicSize renderObject,
  ) {
    /// The [updateRenderObject] method is called when this widget is rebuilt.
    ///
    /// The [childKey] is updated, and if it is different (i.e. the child
    /// is different), the [RenderAnimatedIntrinsicSize] will animate to the
    /// new child's intrinsic size.
    renderObject
      ..vsync = vsync
      ..duration = duration
      ..curve = curve
      ..alignment = alignment
      ..clipBehavior = clipBehavior
      ..childKey = child!.key;
  }
}

class RenderAnimatedIntrinsicSize extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  RenderAnimatedIntrinsicSize({
    required TickerProvider vsync,
    required Duration duration,
    required Curve curve,
    required Alignment alignment,
    Key? childKey,
  })  : _vsync = vsync,
        _animationController = AnimationController(
          vsync: vsync,
          duration: duration,
        ),
        _sizeTween = SizeTween(begin: Size.zero, end: Size.zero),
        _alignment = alignment,
        _childKey = childKey,
        _needsChildSizeUpdate = false {
    _onLayout = _onFirstLayout;
    _animation = CurvedAnimation(parent: _animationController, curve: curve);
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _animationController.addListener(_updateAnimationValue);
  }

  @override
  void detach() {
    super.detach();
    _animationController.removeListener(_updateAnimationValue);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// The function that is called in [performLayout].
  late Size Function() _onLayout;

  /// Indicates that the child size needs to be updated in the next layout pass.
  bool _needsChildSizeUpdate;

  TickerProvider _vsync;
  set vsync(TickerProvider value) {
    if (_vsync == value) return;
    _vsync = value;
    _animationController.resync(value);
  }

  set duration(Duration value) {
    if (_animationController.duration == value) return;
    _animationController.duration = value;
  }

  set curve(Curve value) {
    if (_animation.curve == value) return;
    _animation.curve = value;
  }

  /// The child's alignment for tight constraints.
  ///
  /// Applied to the child when a constraint is larger than the child size.
  Alignment _alignment;
  set alignment(Alignment value) {
    if (_alignment == value) return;
    _alignment = value;
    markNeedsLayout();
  }

  Clip _clipBehavior = Clip.none;
  set clipBehavior(Clip value) {
    if (_clipBehavior == value) return;
    _clipBehavior = value;
    markNeedsPaint();
  }

  /// Used to identify child changes.
  Key? _childKey;

  /// Updates [_childKey] if the received value is different, and triggers
  /// the animation.
  set childKey(Key? value) {
    // assert(
    //   value != null,
    //   "Children of $AnimatedIntrinsicSize must have a key.",
    // );

    /// `TODO`: optimize this to not rebuild if the size tween begin == end.
    if (_childKey == value) {
      return;
    }
    _childKey = value;
    _needsChildSizeUpdate = true;
    _animationController.forward(from: .0);
  }

  final double _animationValue = double.infinity;
  final AnimationController _animationController;
  late final CurvedAnimation _animation;

  /// Stores the size of the old child in [begin] and the size of the current
  /// child in [end].
  final SizeTween _sizeTween;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is BoxParentData) return;
    child.parentData = BoxParentData();
  }

  /// The first layout pass lays out the child without any animation and stores
  /// its size in [_childSizeCache]. The [_sizeTween.end] is updated with the
  /// child's size for use in [_onSubsequentLayout].
  ///
  /// Returns the size of the child.
  Size _onFirstLayout() {
    child!.layout(constraints, parentUsesSize: true);
    _onLayout = _onSubsequentLayout;

    /// Assign the size to [_sizeTween.begin] as well, because the so that
    /// [_sizeTween.evaluate] returns the child's size without having to start
    /// the animation inside [_onSubsequentLayout].
    return _sizeTween.begin = _sizeTween.end = child!.size;
  }

  /// Subsequent layout passes check [_needsChildSizeUpdate] to determine if
  /// [_sizeTween] needs to be updated and lay out the child with tight
  /// constraints using the evaluated [_sizeTween] value.
  ///
  /// Returns the animated size of the child.
  Size _onSubsequentLayout() {
    /// `TODO`: add parameter to allow resizing child to animation value.
    final myChild = child!..layout(constraints, parentUsesSize: true);

    if (_needsChildSizeUpdate) {
      /// Begin from the size of the old child and end at the size of the new
      /// child.
      _sizeTween
        ..begin = _sizeTween.end
        ..end = myChild.size;

      /// No further size updates are needed until the child changes again.
      _needsChildSizeUpdate = false;
    }

    /// `TODO`: Replace temporary fix for the child size not updating.
    if (_sizeTween.end != myChild.size) {
      /// This size change does not animate, but returns the correct size.
      final sz = _sizeTween.end = myChild.size;
      return sz;
    }

    return _sizeTween.evaluate(_animation)!;
  }

  /// The subsequent layout passes don't work because the child is the same,
  /// and I'm returning the animation evaluated size. However, since it's the
  /// same child, there's no animation.

  @override
  void performLayout() {
    /// Lay out the child and get its size.
    final childSize = _onLayout();

    // log("begin: ${_sizeTween.begin}, end: ${_sizeTween.end}");

    /// If any constraint is tight, use the applicable tight constraint.
    ///
    /// If the constraints are not tight, use the child's size, but ensure that
    /// the size is not lesser than the minimum or greater than the maximum
    /// applicable constraint.
    // size = constraints.constrain(childSize);
    size = Size(
      constraints.hasTightWidth
          ? constraints.maxWidth
          : childSize.width.clamp(
              constraints.minWidth,
              constraints.maxWidth,
            ),
      constraints.hasTightHeight
          ? constraints.maxHeight
          : childSize.height.clamp(
              constraints.minHeight,
              constraints.maxHeight,
            ),
    );

    /// Center the child horizontally and vertically.
    (child!.parentData! as BoxParentData).offset =
        _alignment.alongOffset(size - childSize as Offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final childOffset = (child!.parentData! as BoxParentData).offset;

    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      (context, offset) => context.paintChild(child!, childOffset + offset),
      clipBehavior: _clipBehavior,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final childParentData = child!.parentData! as BoxParentData;

    return result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (result, transformed) {
        assert(
          transformed == position - childParentData.offset,
          "Invalid hit test position for child inside $AnimatedIntrinsicSize.",
        );
        return child!.hitTest(result, position: transformed);
      },
    );
  }

  @override
  bool get sizedByParent => false;

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      hasSize ? size : child!.getDryLayout(constraints);

  @override
  double computeMinIntrinsicWidth(double height) =>
      hasSize ? size.width : child!.getMinIntrinsicWidth(height);

  @override
  double computeMaxIntrinsicWidth(double height) =>
      hasSize ? size.width : child!.getMaxIntrinsicWidth(height);

  @override
  double computeMinIntrinsicHeight(double width) =>
      hasSize ? size.height : child!.getMinIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) =>
      hasSize ? size.height : child!.getMaxIntrinsicHeight(width);

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) =>
      child!.getDistanceToActualBaseline(baseline);

  /// Updates [_animationValue] and calls [markNeedsLayout] if [_animationValue]
  /// has changed since the method was last called update.
  void _updateAnimationValue() {
    // if (_animationValue == _animationController.value) return;
    // _animationValue = _animationController.value;
    markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<Duration>(
          "duration",
          _animationController.duration,
        ),
      )
      ..add(DiagnosticsProperty<Curve>("curve", _animation.curve))
      ..add(DiagnosticsProperty<Alignment>("alignment", _alignment))
      ..add(DoubleProperty("_animationValue", _animationValue))
      ..add(DiagnosticsProperty<Key?>("childKey", _childKey));
  }
}
