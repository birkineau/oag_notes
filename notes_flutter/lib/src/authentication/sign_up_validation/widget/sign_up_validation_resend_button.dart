import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

/// A button that allows the user to request a new validation code.
class SignUpValidationResendButton extends StatelessWidget {
  const SignUpValidationResendButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isValidationRequired = context.select<SignUpCubit, bool>(
      (cubit) => cubit.state.status == SignUpStatus.validationRequired,
    );

    return AuthTransitionButton(
      onPressed: isValidationRequired
          ? () => _requestNewValidationCode(context)
          : null,
      label: "Didn't receive an email code?",
      buttonLabel: "Resend",
    );
  }

  Future<void> _requestNewValidationCode(BuildContext context) async {
    await context.read<SignUpCubit>().requestValidationCode(
          context.read<SignUpCredentialsCubit>().state.email.value,
        );
  }
}
