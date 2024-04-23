import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// Shows a sign-up form allowing the user to create a new account.
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTitle(text: "Sign-up"),
              SignInFormButton(),
              SizedBox(height: 8.0),
              SignUpForm(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: SignUpButton(),
              ),
              _SignUpError(),
            ],
          ),
        ),
      ),
    );
  }

  /// The path to the sign-up page.
  static const path = "${SignInPage.path}/sign_up";

  /// Opens the sign-up page.
  static void go() => navigatorContext().go(path);

  /// Builds the sign-up page by providing the [SignUpCredentialsCubit],
  /// [ValidationCodeCubit], and [SignUpCubit] through dependency injection.
  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
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
            child: SignUpPage(),
          ),
        ),
      ),
    );
  }
}

class _SignUpError extends StatelessWidget {
  const _SignUpError();

  @override
  Widget build(BuildContext context) {
    return AnimatedErrorMessage(
      textAlign: TextAlign.center,
      error: context.select<SignUpCubit, String?>((cubit) => cubit.state.error),
    );
  }
}
