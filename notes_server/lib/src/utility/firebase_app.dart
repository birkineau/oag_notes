import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_admin/firebase_admin.dart' hide AccessToken;
import 'package:googleapis/fcm/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:notes_server/src/generated/protocol.dart';

class FirebaseApp {
  static const _serviceAccountPath = "config/firebase_service_account_key.json";

  static App? _instance;
  static App get _app {
    if (_instance != null) {
      return _instance!;
    }

    final cert = FirebaseAdmin.instance.certFromPath(
      "config/firebase_service_account_key.json",
    );

    /// TODO: handle the case where the app cannot be created
    _instance = FirebaseAdmin.instance.initializeApp(
      AppOptions(credential: cert),
    );

    return _instance!;
  }

  static Auth get auth => _app.auth();

  static AutoRefreshingAuthClient? _client;
  static FirebaseCloudMessagingApi? _fcmInstance;
  static String? _projectId;

  static FirebaseCloudMessagingApi get _fcm {
    if (_fcmInstance == null) {
      throw StateError("FirebaseCloudMessagingApi not initialized.");
    }

    return _fcmInstance!;
  }

  static Future<void> initializeFCM() async {
    if (_projectId != null) {
      return;
    }

    final json = jsonDecode(File(_serviceAccountPath).readAsStringSync());

    if (json case <String, dynamic>{"project_id": final String projectId}) {
      _projectId = projectId;
    } else {
      throw StateError("Project ID not found in service account file.");
    }

    _client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(json),
      <String>[
        "https://www.googleapis.com/auth/firebase.messaging",
      ],
    );

    _fcmInstance = FirebaseCloudMessagingApi(_client!);
  }

  static Future<void> notify({
    required FcmToken fcmToken,
    required String title,
    String? body,
    Map<String, String>? data,
  }) async {
    if (_projectId == null) {
      throw NotificationException(message: "FCM not initialized.");
    }

    try {
      final message = Message(
        token: fcmToken.token,
        data: <String, String>{},
        notification: Notification(title: title, body: body),
      );

      await FirebaseApp._fcm.projects.messages.send(
        SendMessageRequest(message: message),
        "projects/${_projectId!}",
      );
    } on DetailedApiRequestError catch (e) {
      stderr.writeln("DETAILED?: ${e.jsonResponse}");
    } on ApiRequestError catch (e) {
      throw NotificationException(message: e.message ?? "Unknown error.");
    }
  }

  static void close() {
    _client?.close();
    _instance?.delete();
  }
}
