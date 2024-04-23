import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/src/authentication/authentication.dart';

class UpdatePasswordButton extends StatelessWidget {
  const UpdatePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select<UpdatePasswordCubit, UpdatePasswordStatus>(
      (cubit) => cubit.state.status,
    );

    final isEmailValid = context.select<UpdatePasswordFormCubit, bool>(
      (cubit) => cubit.state.email.isValid,
    );

    final isCodeInputValid = context.select<ValidationCodeCubit, bool>(
      (cubit) => cubit.state.isValid,
    );

    final isFormValid = context.select<UpdatePasswordFormCubit, bool>(
      (cubit) =>
          isEmailValid &&
          isCodeInputValid &&
          cubit.state.password.isValid &&
          cubit.state.passwordConfirm.isValid,
    );

    /// The button is enabled if:
    /// * The email input valid.
    /// * The password form inputs are valid.
    /// * The password update request is NOT being requested.
    /// * The password update request is NOT being validated.
    final enabled =
        (isEmailValid && status == UpdatePasswordStatus.notRequested) ||
            (isFormValid && status == UpdatePasswordStatus.requested);

    final Widget buttonContent;

    final isPendingServerResponse = status == UpdatePasswordStatus.requesting ||
        status == UpdatePasswordStatus.updating;

    /// If the password update request is being requested or validated, show a
    /// loading indicator. Otherwise, show the button text.
    if (isPendingServerResponse) {
      buttonContent = const CircularProgressIndicator(
        key: ValueKey("update_password_button_progress"),
      );
    } else {
      buttonContent = Text(
        key: const ValueKey("update_password_button_text"),
        status.index >= UpdatePasswordStatus.requested.index
            ? "Update my password"
            : "Continue",
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
      );
    }

    return AuthActionButton(
      onPressed: enabled ? () => _processPasswordUpdate(context) : null,
      child: Align(child: buttonContent),
    );
  }

  Future<void> _processPasswordUpdate(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final updatePasswordCubit = context.read<UpdatePasswordCubit>();
    final updatePasswordFormCubit = context.read<UpdatePasswordFormCubit>();

    /// If the password update request has not been requested, request it.
    if (updatePasswordCubit.state.status == UpdatePasswordStatus.notRequested) {
      await context.read<UpdatePasswordCubit>().requestPasswordUpdate(
            email: updatePasswordFormCubit.state.email.value,
          );
    } else {
      final updatePasswordFormState = updatePasswordFormCubit.state;

      /// If the password update request has been requested, try to update the
      /// password with the provided validation code.
      await updatePasswordCubit.updatePassword(
        email: updatePasswordFormState.email.value,
        newPassword: updatePasswordFormState.password.value,
        validationCode: context.read<ValidationCodeCubit>().state.code,
      );
    }
  }
}
