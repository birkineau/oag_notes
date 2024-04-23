import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

/// If you're going to install Serverpod, and run the server locally, you can
/// set this to `false` to use the real API.
const kUseMockApi = true;

/// Use this to simulate API failures.
const kMockApiFailureChance = .2;

/// Dependency injection container.
final di = GetIt.instance;

/// The main application widget.
///
/// A [Client] must be initialized and registered with the dependency injector.
class NotesApplication extends StatefulWidget {
  const NotesApplication({super.key});

  @override
  State<NotesApplication> createState() => _NotesApplicationState();
}

class _NotesApplicationState extends State<NotesApplication> {
  final _routerConfig = createRouterConfiguration();
  final _signInCubit = SignInCubit(
    client: di<Client>(),
    api: kUseMockApi
        ? const MockSignInApi(failureChance: kMockApiFailureChance)
        : const FirebaseSignInApi(),
  );

  @override
  void dispose() {
    _routerConfig.dispose();

    di
      ..unregister<GlobalKey<NavigatorState>>()
      ..unregister<Client>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!di.isRegistered<EdgeInsets>()) {
      di.registerSingleton<EdgeInsets>(MediaQuery.viewPaddingOf(context));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCredentialsCubit()
            ..setEmail("abc.123@example.com")
            ..setPassword("a123456!"),
        ),
        BlocProvider(create: (context) => _signInCubit),
      ],
      child: BlocListener<SignInCubit, SignInState>(
        bloc: _signInCubit,
        listener: (context, state) async {
          if (_onValidationRequired(context, state)) return;
          if (_onSignedOut(context, state)) return;
          if (_onSignedIn(context, state)) return;
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: NotesTheme.lightTheme,
          routerConfig: _routerConfig,
        ),
      ),
    );
  }

  bool _onValidationRequired(BuildContext context, SignInState state) {
    if (state.status != SignInStatus.validationRequired) return false;

    final email = context.read<SignInCredentialsCubit>().state.email.value;

    /// These cubits should be available because they are registered when the
    /// [SignInPage] is built, and the [SignInPage] is the first page that is
    /// built/shown when the application starts.
    di<SignUpCredentialsCubit>().setEmail(email);
    di<SignUpCubit>().requestValidationCode(email);

    SignUpValidationPage.go();

    return true;
  }

  bool _onSignedOut(BuildContext context, SignInState state) {
    if (state.status != SignInStatus.signedOut) return false;
    if (navigatorPath() == SignInPage.path) return false;

    context.read<SignInCredentialsCubit>().setPassword("");
    SignInPage.go(signingOut: true);

    return true;
  }

  bool _onSignedIn(BuildContext context, SignInState state) {
    if (state.status != SignInStatus.signedIn) return false;

    /// Unregister all authentication-related blocs when the user
    /// signs in.
    ///
    /// The sign-in bloc is not unregistered because it is used to
    /// sign out the user and it is listened to by the application
    /// in order to navigate to the sign-in page when a sign-out
    /// event occurs.
    ///
    /// These blocs are registered when the [SignInPage] is built.
    unregisterBloc<SignUpCredentialsCubit>();
    unregisterBloc<SignUpCubit>();
    unregisterBloc<ValidationCodeCubit>();
    unregisterBloc<UpdatePasswordCubit>();
    unregisterBloc<UpdatePasswordFormCubit>();

    context.read<SignInCredentialsCubit>().setPassword("");
    UserManagerPage.go();

    return true;
  }
}

/// Registers a [BlocBase] instance with the dependency injection container, and
/// provides a dispose function that closes the bloc when it is unregistered.
T registerBloc<T extends BlocBase<Object>>(T value) {
  if (di.isRegistered<T>()) {
    return di.get<T>();
  }

  return di.registerSingleton<T>(value, dispose: (bloc) async => bloc.close());
}

/// Unregisters a [BlocBase] instance from the dependency injection container.
void unregisterBloc<T extends BlocBase<Object>>() {
  if (di.isRegistered<T>()) {
    di.unregister<T>();
  }
}
