import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// The reset password page of the application.
///
/// Allows the user to reset their password by entering their email address.
class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const page = Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UpdatePasswordValidationTitle(),
              _UpdatePasswordSubtitle(),
              SizedBox(height: 8.0),
              UpdatePasswordForm(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: UpdatePasswordButton(),
              ),
              _UpdatePasswordErrorDisplay(),
            ],
          ),
        ),
      ),
    );

    return BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
      listener: _showPasswordUpdatedSuccessMessage,
      child: page,
    );
  }

  void _showPasswordUpdatedSuccessMessage(
    BuildContext context,
    UpdatePasswordState state,
  ) {
    if (state.status != UpdatePasswordStatus.updated) return;

    context.read<SignInCredentialsCubit>().setEmail(
          context.read<UpdatePasswordFormCubit>().state.email.value,
        );

    const duration = Duration(milliseconds: 3250);

    TransientPage.go(
      duration: duration,
      nextPath: SignInPage.path,
      child: const ImageMessage(
        duration: duration,
        imageAssetPath: "lib/assets/images/success_512.png",
        message: "Your password has been updated.",
      ),
    );
  }

  /// The path for the reset password page.
  static const path = "${SignInPage.path}/recovery";

  /// Navigates to the reset password page.
  static void go() => navigatorContext().go(path);

  /// Builds the reset password page.
  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionsBuilder: fadeTransitionBuilder,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: di<UpdatePasswordCubit>()..clear()),
          BlocProvider.value(value: di<UpdatePasswordFormCubit>()..clear()),
          BlocProvider.value(value: di<ValidationCodeCubit>()..clear()),
        ],
        child: ColoredBox(
          color: NotesTheme.colorScheme.background,
          child: const SafeArea(
            child: UpdatePasswordPage(),
          ),
        ),
      ),
    );
  }
}

typedef _UpdatePasswordStatusSelector = BlocSelector<UpdatePasswordCubit,
    UpdatePasswordState, UpdatePasswordStatus>;

class _UpdatePasswordSubtitle extends StatelessWidget {
  const _UpdatePasswordSubtitle();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "auth_subtitle",
      flightShuttleBuilder:
          _offsetFadeWithUpdatePasswordCubitFlightShuttleBuilder,
      child: AnimatedSize(
        duration: DurationConstants.shortAnimation,
        curve: Curves.fastOutSlowIn,
        child: _UpdatePasswordStatusSelector(
          selector: (state) => state.status,
          builder: (context, status) {
            final isNotRequested =
                status == UpdatePasswordStatus.notRequested ||
                    status == UpdatePasswordStatus.requesting;

            final child = isNotRequested
                ? const UpdatePasswordCancelButton(
                    key: ValueKey("update_password_cancel_button"),
                  )
                : const UpdatePasswordValidationSubtitle(
                    key: ValueKey("update_password_validation_subtitle"),
                  );

            return AnimatedSwitcher(
              duration: DurationConstants.shortAnimation,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              child: child,
            );
          },
        ),
      ),
    );
  }

  Widget _offsetFadeWithUpdatePasswordCubitFlightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<UpdatePasswordCubit>()),
        BlocProvider.value(value: di<UpdatePasswordFormCubit>()),
      ],
      child: offsetFadeFlightShuttleBuilder(
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ),
    );
  }
}

class _UpdatePasswordErrorDisplay extends StatelessWidget {
  const _UpdatePasswordErrorDisplay();

  @override
  Widget build(BuildContext context) {
    return AnimatedErrorMessage(
      textAlign: TextAlign.center,
      error: context.select<UpdatePasswordCubit, String?>(
        (cubit) => cubit.state.error,
      ),
    );
  }
}
