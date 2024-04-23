import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

/// The form used to sign up a new user.
///
/// The form contains the user's email address field, the password field, and
/// the password confirmation field.
class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingValue = 12.0;
    const textToTextFieldSpacing = SizedBox(height: 6.0);

    return Hero(
      tag: "auth_form",
      flightShuttleBuilder: authFormPlaceholderShuttleBuilder,
      child: Container(
        padding: const EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          color: NotesTheme.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: FadeScaleIn(
          from: .985,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormText(text: "Email address"),
              textToTextFieldSpacing,
              const _SignUpEmailTextField(),
              // verticalSpacing,
              AxisFade(
                axis: Axis.horizontal,
                stops: const [.0, .2, .8, 1.0],
                child: Divider(color: NotesTheme.colorScheme.surface),
              ),
              const FormText(text: "Create password"),
              textToTextFieldSpacing,
              const _SignUpPasswordTextField(),
              const SizedBox(height: paddingValue),
              const FormText(text: "Confirm password"),
              textToTextFieldSpacing,
              const _SignUpPasswordConfirmTextField(),
            ],
          ),
        ),
      ),
    );
  }
}

typedef _SignUpCredentialsErrorSelector
    = BlocSelector<SignUpCredentialsCubit, SignUpCredentialsState, String?>;

class _SignUpEmailTextField extends StatelessWidget {
  const _SignUpEmailTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedTextField(
            onTextChanged: context.read<SignUpCredentialsCubit>().setEmail,
            iconData: Icons.mail,
            hintText: "e.g. jane.doe@gmail.com",
            keyboardType: TextInputType.emailAddress,
            initialValue: context.select<SignUpCredentialsCubit, String>(
              (cubit) => cubit.state.email.value,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        _SignUpCredentialsErrorSelector(
          selector: (state) => state.email.displayError?.description,
          builder: (context, error) => AnimatedErrorMessage(error: error),
        ),
      ],
    );
  }
}

class _SignUpPasswordTextField extends StatelessWidget {
  const _SignUpPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedPasswordTextField(
            onTextChanged: context.read<SignUpCredentialsCubit>().setPassword,
            hintText: "Enter your password",
          ),
        ),
        const SizedBox(height: 4.0),
        _SignUpCredentialsErrorSelector(
          selector: (state) => state.password.error?.description,
          builder: (context, error) => AnimatedErrorMessage(error: error),
        ),
      ],
    );
  }
}

class _SignUpPasswordConfirmTextField extends StatelessWidget {
  const _SignUpPasswordConfirmTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedPasswordTextField(
            onTextChanged:
                context.read<SignUpCredentialsCubit>().setPasswordConfirm,
            hintText: "Enter your password again",
          ),
        ),
        const SizedBox(height: 4.0),
        _SignUpCredentialsErrorSelector(
          selector: (state) => state.passwordConfirm.error?.description,
          builder: (context, error) => AnimatedErrorMessage(error: error),
        ),
      ],
    );
  }
}
