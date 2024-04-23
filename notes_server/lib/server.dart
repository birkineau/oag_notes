import 'package:notes_server/src/future_calls/future_calls.dart';
<<<<<<< HEAD
import 'package:notes_server/src/generated/endpoints.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
=======
import 'package:serverpod/serverpod.dart';
>>>>>>> parent of a64c4e5 (fcm)
import 'package:notes_server/src/web/routes/root.dart';
import 'package:serverpod/serverpod.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

Future<void> run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: authenticationHandler,
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  pod
    ..registerFutureCall(PasscodeDeletion(), PasscodeDeletion.key)
    ..registerFutureCall(ScheduledNotification(), ScheduledNotification.key)
    ..registerFutureCall(PasswordUpdateDeletion(), PasswordUpdateDeletion.key);

<<<<<<< HEAD
=======
  // Start the server.
>>>>>>> parent of a64c4e5 (fcm)
  await pod.start();
  await ServerConfiguration(pod).initialize();
}
