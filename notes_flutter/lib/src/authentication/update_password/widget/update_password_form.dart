import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

class UpdatePasswordForm extends StatelessWidget {
  const UpdatePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "auth_form",
      flightShuttleBuilder: authFormPlaceholderShuttleBuilder,
      child: BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
        builder: (context, state) {
          final Widget child;

          if (state.status == UpdatePasswordStatus.notRequested ||
              state.status == UpdatePasswordStatus.requesting) {
            child = const _EmailForm(key: ValueKey("update_email_form"));
          } else {
            child = const _PasswordForm(key: ValueKey("update_password_form"));
          }

          return AnimatedSize(
            duration: DurationConstants.shortAnimation,
            curve: Curves.fastOutSlowIn,
            child: AnimatedSwitcher(
              duration: DurationConstants.shortAnimation,
              switchInCurve: Curves.slowMiddle,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingValue = 12.0;

    return Container(
      padding: const EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
        color: NotesTheme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: const FadeScaleIn(
        from: .985,
        child: Column(
          children: [
            FormText(
              text: "Enter the email address associated with your account to "
                  "receive a password update code.",
            ),
            SizedBox(height: paddingValue),
            _EmailTextField(),
          ],
        ),
      ),
    );
  }
}

class _PasswordForm extends StatelessWidget {
  const _PasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingValue = 12.0;
    const textToTextFieldSpacing = SizedBox(height: 6.0);

    return Container(
      padding: const EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
        color: NotesTheme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: FadeScaleIn(
        from: .985,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FormText(text: "New password"),
            textToTextFieldSpacing,
            const _PasswordTextField(),
            const SizedBox(height: paddingValue),
            const FormText(text: "Confirm password"),
            textToTextFieldSpacing,
            const _PasswordConfirmTextField(),
            AxisFade(
              axis: Axis.horizontal,
              stops: const [.0, .2, .8, 1.0],
              child: Divider(
                color: NotesTheme.colorScheme.surface,
                height: 20.0,
              ),
            ),
            const FormText(
              text: "Enter the ${ValidationCodeCubit.codeLength}-digit code "
                  "sent to your email.",
            ),
            const SizedBox(height: paddingValue),
            const SizedBox(
              height: 56.0,
              child: SignUpValidationCodeInput(),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedTextField(
            onTextChanged: context.read<UpdatePasswordFormCubit>().setEmail,
            iconData: Icons.email,
            hintText: "Enter the email you used to sign up",
            keyboardType: TextInputType.emailAddress,
            initialValue:
                context.read<SignInCredentialsCubit>().state.email.value,
          ),
        ),
        const SizedBox(height: 4.0),
        BlocBuilder<UpdatePasswordFormCubit, UpdatePasswordFormState>(
          buildWhen: (previous, current) {
            return previous.email != current.email;
          },
          builder: (context, state) {
            return AnimatedErrorMessage(
              error: state.email.error?.description,
            );
          },
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedPasswordTextField(
            onTextChanged: context.read<UpdatePasswordFormCubit>().setPassword,
            hintText: "Enter your new password",
          ),
        ),
        const SizedBox(height: 4.0),
        BlocBuilder<UpdatePasswordFormCubit, UpdatePasswordFormState>(
          buildWhen: (previous, current) {
            return previous.password != current.password;
          },
          builder: (context, state) {
            return AnimatedErrorMessage(
              error: state.password.error?.description,
            );
          },
        ),
      ],
    );
  }
}

class _PasswordConfirmTextField extends StatelessWidget {
  const _PasswordConfirmTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedPasswordTextField(
            onTextChanged:
                context.read<UpdatePasswordFormCubit>().setPasswordConfirm,
            hintText: "Confirm your new password",
          ),
        ),
        const SizedBox(height: 4.0),
        BlocBuilder<UpdatePasswordFormCubit, UpdatePasswordFormState>(
          buildWhen: (previous, current) {
            return previous.passwordConfirm != current.passwordConfirm;
          },
          builder: (context, state) {
            return AnimatedErrorMessage(
              error: state.passwordConfirm.error?.description,
            );
          },
        ),
      ],
    );
  }
}
