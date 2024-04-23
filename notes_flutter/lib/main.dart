import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// TODO: ensure connected to server
/// TODO: add biometrics
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di
    ..registerSingleton(
      Client(
        "http://localhost:8080/",
        authenticationKeyManager: FlutterAuthenticationKeyManager(
          runMode: kReleaseMode ? "production" : "development",
        ),
      )..connectivityMonitor = FlutterConnectivityMonitor(),
      dispose: (client) => client.close(),
    )
    ..registerSingleton(FcmNotification());

  runApp(const NotesApplication());
}

/// Simulator push test:
/// xcrun simctl push booted com.example.notesFlutter notes_flutter/ios/push_notification/payload.json

/// Android debug console filter:
/// !D/EGL, !W/, !D/InsetsController, !D/InputMethodManager, !I/ImeTracker, !I/TextInputPlugin, !I/AssistStructure