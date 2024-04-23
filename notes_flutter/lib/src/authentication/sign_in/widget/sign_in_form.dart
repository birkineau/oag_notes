import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// A form containing the sign-in email and password fields.
class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingValue = 12.0;

    return Hero(
      tag: "auth_form",
      flightShuttleBuilder: authFormPlaceholderShuttleBuilder,
      child: Container(
        padding: const EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          color: NotesTheme.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: const FadeScaleIn(
          from: .985,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormText(text: "Email address"),
              SizedBox(height: 6.0),
              _SignInEmailTextField(),
              SizedBox(height: paddingValue),
              FormText(text: "Password"),
              SizedBox(height: 6.0),
              _SignInPasswordTextField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInEmailTextField extends StatelessWidget {
  const _SignInEmailTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48.0,
          child: DecoratedTextField(
            onTextChanged: context.read<SignInCredentialsCubit>().setEmail,
            iconData: Icons.mail,
            hintText: "e.g. jane.doe@gmail.com",
            keyboardType: TextInputType.emailAddress,
            initialValue:
                context.read<SignInCredentialsCubit>().state.email.value,
          ),
        ),
        const SizedBox(height: 4.0),
        BlocSelector<SignInCredentialsCubit, SignInCredentialsState,
            EmailInputError?>(
          selector: (state) => state.email.error,
          builder: (context, errorType) {
            /// Ignore the empty email error for the sign-in form.
            final error =
                errorType != null && errorType != EmailInputError.empty
                    ? errorType.description
                    : null;

            return AnimatedErrorMessage(error: error);
          },
        ),
      ],
    );
  }
}

class _SignInPasswordTextField extends StatelessWidget {
  const _SignInPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: DecoratedPasswordTextField(
        onTextChanged: context.read<SignInCredentialsCubit>().setPassword,
        hintText: "********",
        initialValue: context.read<SignInCredentialsCubit>().state.password,
      ),
    );
  }
}

/// A placeholder for the sign-in form to avoid layout overflow during hero
/// animations.
Widget authFormPlaceholderShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return const PlaceholderFormContainer();
}
