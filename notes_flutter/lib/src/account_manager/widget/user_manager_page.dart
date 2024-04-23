import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

class UserManagerPage extends StatefulWidget {
  const UserManagerPage({super.key});

  @override
  State<UserManagerPage> createState() => _UserManagerPageState();

  static const navigatorKeyInstanceName = "UserManagerNavigatorKey";

  static const String path = "/users";

  static void go() => navigatorContext().go(path);

  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return fadeTransitionBuilder(
          context,
          animation,
          secondaryAnimation,
          slideTransitionBuilder(context, animation, secondaryAnimation, child),
        );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AccountManagerCubit()..getUsers()),
          BlocProvider(create: (context) => SelectorCubit<UserWithTags>()),
        ],
        child: const SafeArea(
          child: UserManagerPage(),
        ),
      ),
    );
  }
}

class _UserManagerPageState extends State<UserManagerPage> {
  final _routerConfig = createUserManagerRouterConfiguration();

  @override
  void dispose() {
    di.unregister<GlobalKey<NavigatorState>>(
      instanceName: UserManagerPage.navigatorKeyInstanceName,
    );

    _routerConfig.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const SignOutButton(
                child: Icon(Icons.chevron_left_rounded, size: 32.0),
              ),
              const Spacer(),
              Text("Users", style: NotesTheme.textTheme.titleLarge),
            ],
          ),
          const UserManagerToolbar(),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: NotesTheme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              alignment: Alignment.center,
              child: Router.withConfig(config: _routerConfig),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class SelectorCubit<T> extends Cubit<T?> {
  SelectorCubit() : super(null);

  void set(T? value) => emit(value);
}
