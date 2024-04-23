import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_flutter/notes_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  static const path = "/notes";

  static void go() {
    navigatorContext().go(path);
  }

  static Page<void> pageBuilder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: ColoredBox(
        color: NotesTheme.colorScheme.background,
        child: const NotesPage(),
      ),
    );
  }

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();

    di.registerSingleton<NoteListRepository>(
      NoteListRepository(),
      dispose: (repo) {
        return repo.close();
      },
    );

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        di<NoteListRepository>().getNotes();
      },
    );
  }

  @override
  void dispose() {
    di.unregister<NoteListRepository>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = Text(
      "NOTES",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteListBloc>(
          create: (context) {
            return NoteListBloc()
              ..add(const NoteListRepositorySubscriptionEvent());
          },
          lazy: false,
        ),
        BlocProvider<NoteUpdateBloc>(
          create: (context) {
            return NoteUpdateBloc()
              ..add(const NoteUpdateRepositorySubscriptionEvent());
          },
          lazy: false,
        ),
      ],
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: title),
                  SignOutButton(
                    child: Icon(Icons.chevron_left_rounded, size: 32.0),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              NoteTextField(),
              SizedBox(height: 16.0),
              Expanded(child: NoteList()),
            ],
          ),
        ),
      ),
    );
  }
}
