import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';
=======
import 'package:firebase_messaging/firebase_messaging.dart';
>>>>>>> parent of a64c4e5 (fcm)
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/firebase_options.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// TODO: ensure connected to server
/// TODO: add biometrics
/// TODO: add loading indicators for async operations such as sign-in, sign-out
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

<<<<<<< HEAD
  // timeDilation = 3.0;

  di
    ..registerSingleton(
      Client(
        // "http://192.168.1.71:8080/",
        "http://10.1.10.221:8080/",
        // "http://localhost:8080/",
        authenticationKeyManager: FlutterAuthenticationKeyManager(
          runMode: kReleaseMode ? "production" : "development",
        ),
      )..connectivityMonitor = FlutterConnectivityMonitor(),
      dispose: (client) => client.close(),
    )
    ..registerSingleton(FcmNotification());
=======
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission();

  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
>>>>>>> parent of a64c4e5 (fcm)

  runApp(const NotesApplication());
}

<<<<<<< HEAD
/// Simulator push test:
/// xcrun simctl push booted com.example.notesFlutter notes_flutter/ios/push_notification/payload.json

=======
>>>>>>> parent of a64c4e5 (fcm)
/// Android debug console filter:
/// !D/EGL, !W/, !D/InsetsController, !D/InputMethodManager, !I/ImeTracker, !I/TextInputPlugin, !I/AssistStructure