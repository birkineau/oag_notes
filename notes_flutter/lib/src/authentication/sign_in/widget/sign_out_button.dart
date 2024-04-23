import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  bool _signingOut = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _signingOut ? null : () => _signOut(context),
      icon: widget.child,
    );
  }

  Future<void> _signOut(BuildContext context) async {
    setState(() => _signingOut = true);

    await context.read<SignInCubit>().signOut();

    if (mounted) {
      setState(() => _signingOut = false);
    }
  }
}
