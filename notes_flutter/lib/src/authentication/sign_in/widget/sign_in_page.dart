import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:notes_flutter/src/authentication/sign_up/controller/sign_up_cubit/mock_sign_up_api.dart';

/// The sign-in page of the application.
///
/// The sign-in page allows the user to sign in to the application using their
/// email and password. If the user has not yet validated their email, they will
/// be redirected to the [SignUpValidationPage].
///
/// The user can also navigate to the [SignUpPage], and [UpdatePasswordPage]
/// pages from the sign-in page.
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTitle(text: "Sign-in"),
              SignUpFormButton(),
              SizedBox(height: 8.0),
              SignInForm(),
              Align(
                alignment: Alignment.centerRight,
                child: UpdatePasswordFormButton(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: SignInButton(),
              ),
              _SignInError(),
            ],
          ),
        ),
      ),
    );
  }

  /// Path of the sign-in page.
  static const path = "/auth";

  /// Navigates to the sign-in validation page.
  static void go({bool signingOut = false}) {
    return navigatorContext().go(path, extra: signingOut);
  }

  /// Builds the sign-in page.
  ///
  /// Provides the [SignInPage], and the [SignUpPage], [SignUpValidationPage],
  /// and [UpdatePasswordPage] sub-pages with all authentication related blocs.
  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    const signUpApi = kUseMockApi
        ? MockSignUpApi(failureChance: kMockApiFailureChance)
        : FirebaseSignUpApi();

    const updatePasswordApi = kUseMockApi
        ? MockUpdatePasswordApi(failureChance: kMockApiFailureChance)
        : FirebaseUpdatePasswordApi();

    final bool signingOut;

    if (state.extra case final bool slide) {
      signingOut = slide;
    } else {
      signingOut = false;
    }

    return CustomTransitionPage(
      key: state.pageKey,
      maintainState: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(-1.0, .0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        );

        /// When signing out, slide the page from left to right.
        return signingOut
            ? fadeTransitionBuilder(
                context,
                animation,
                secondaryAnimation,
                SlideTransition(
                  position: slideAnimation,
                  child: child,
                ),
              )
            : fadeTransitionBuilder(
                context,
                animation,
                secondaryAnimation,
                child,
              );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: registerBloc(SignUpCredentialsCubit())),
          BlocProvider.value(value: registerBloc(SignUpCubit(signUpApi))),
          BlocProvider.value(value: registerBloc(ValidationCodeCubit())),
          BlocProvider.value(
            value: registerBloc(UpdatePasswordCubit(updatePasswordApi)),
          ),
          BlocProvider.value(value: registerBloc(UpdatePasswordFormCubit())),
        ],
        child: ColoredBox(
          color: NotesTheme.colorScheme.background,
          child: const SafeArea(
            child: SignInPage(),
          ),
        ),
      ),
    );
  }
}

class _SignInError extends StatelessWidget {
  const _SignInError();

  @override
  Widget build(BuildContext context) {
    return AnimatedErrorMessage(
      textAlign: TextAlign.center,
      error: context.select<SignInCubit, String?>((cubit) => cubit.state.error),
    );
  }
}
