import 'package:flutter/material.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

class DecoratedTextField extends StatefulWidget {
  const DecoratedTextField({
    required this.iconData,
    required this.hintText,
    super.key,
    this.onTextChanged,
    this.padding = const EdgeInsets.only(bottom: 4.0),
    this.obscureText = false,
    this.autocorrect = false,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.initialValue,
  });

  final void Function(String)? onTextChanged;
  final EdgeInsets padding;
  final IconData iconData;
  final String hintText;
  final bool obscureText;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final String? initialValue;

  @override
  State<DecoratedTextField> createState() => _DecoratedTextFieldState();
}

class _DecoratedTextFieldState extends State<DecoratedTextField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _spreadRadiusAnimation;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: DurationConstants.shortAnimation,
    );

    _spreadRadiusAnimation =
        Tween<double>(begin: .0, end: 4.0).animate(_animationController);

    if (widget.onTextChanged != null) {
      _controller.addListener(
        () {
          widget.onTextChanged!(_controller.text);
        },
      );
    }

    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
    );

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DecoratedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadowColor = NotesTheme.colorScheme.primary.lighten(50);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: _spreadRadiusAnimation.value,
                spreadRadius: _animationController.value * 1.5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(widget.iconData),
            const SizedBox(width: 8.0),
            Expanded(
              child: Padding(
                padding: widget.padding,
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(hintText: widget.hintText),
                  obscureText: widget.obscureText,
                  autocorrect: widget.autocorrect,
                  textCapitalization: widget.textCapitalization,
                  keyboardType: widget.keyboardType,
                  enableSuggestions: false,
                  style: NotesTheme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DecoratedPasswordTextField extends StatefulWidget {
  const DecoratedPasswordTextField({
    required this.hintText,
    super.key,
    this.onTextChanged,
    this.initialValue,
  });

  final void Function(String)? onTextChanged;
  final String? initialValue;
  final String hintText;

  @override
  State<DecoratedPasswordTextField> createState() =>
      _DecoratedPasswordTextFieldState();
}

class _DecoratedPasswordTextFieldState
    extends State<DecoratedPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    const iconButtonWidth = 40.0;
    const iconButtonPadding = 4.0;

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedTextField(
            onTextChanged: widget.onTextChanged,
            iconData: Icons.lock,
            hintText: widget.hintText,
            initialValue: widget.initialValue,
            obscureText: _obscureText,
            padding: const EdgeInsets.only(right: 32.0),
          ),
        ),
        Positioned(
          width: iconButtonWidth,
          top: iconButtonPadding,
          bottom: iconButtonPadding,
          right: iconButtonPadding,
          child: IconButton(
            onPressed: () {
              setState(
                () {
                  _obscureText = !_obscureText;
                },
              );
            },
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ],
    );
  }
}
