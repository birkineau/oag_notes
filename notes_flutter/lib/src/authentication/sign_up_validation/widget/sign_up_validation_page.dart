import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// The sign-up validation page of the application allows the user to validate
/// their email address.
///
/// The email address is obtained from the [SignUpCredentialsState.email] field,
/// which is set in the [SignUpCredentialsCubit] from one of two places:
/// * The [SignInPage] when the user signs in and is redirected to the
///  [SignUpValidationPage] because their email address has not yet been
/// validated.
/// * The [SignUpPage] when the user creates an account.
class SignUpValidationPage extends StatelessWidget {
  const SignUpValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SignUpValidationTitle(),
              SignUpValidationSubtitle(),
              SizedBox(height: 12.0),
              SignUpValidationForm(),
              Align(
                alignment: Alignment.centerRight,
                child: SignUpValidationResendButton(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: SignUpValidationButton(),
              ),
              _SignUpValidationError(),
            ],
          ),
        ),
      ),
    );
  }

  /// The path of the [SignUpValidationPage] page.
  static const path = "${SignInPage.path}/validation";

  /// Navigates to the [SignUpValidationPage] page.
  static void go() => navigatorContext().go(path);

  /// Builds the [SignUpValidationPage] page.
  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      transitionsBuilder: fadeTransitionBuilder,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: di<SignUpCredentialsCubit>()),
          BlocProvider.value(value: di<ValidationCodeCubit>()),
          BlocProvider.value(value: di<SignUpCubit>()),
        ],
        child: ColoredBox(
          color: NotesTheme.colorScheme.background,
          child: const SafeArea(
            child: SignUpValidationPage(),
          ),
        ),
      ),
    );
  }
}

class _SignUpValidationError extends StatelessWidget {
  const _SignUpValidationError();

  @override
  Widget build(BuildContext context) {
    return AnimatedErrorMessage(
      textAlign: TextAlign.center,
      error: context.select<SignUpCubit, String?>(
        (cubit) => cubit.state.error,
      ),
    );
  }
}
