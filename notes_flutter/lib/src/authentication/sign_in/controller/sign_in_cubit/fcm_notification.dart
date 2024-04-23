import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/notes_flutter.dart';

typedef _Messaging = FirebaseMessaging;
typedef _Message = RemoteMessage;

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(
  _Message message, [
  void Function(RemoteMessage message)? onInitialMessage,
  void Function(RemoteMessage message)? onBackgroundMessage,
  bool fromUserInteraction = false,
]) async {
  if (fromUserInteraction) {
    final getInitialMessage = _Messaging.instance.getInitialMessage();

    if (await getInitialMessage case final _Message initialMessage) {
      log("FCM background initial message: ${initialMessage.data}");
      onInitialMessage?.call(initialMessage);
    }
  }

  log(
    "FCM background message(fromUserInteraction=$fromUserInteraction): "
    "${message.data}",
  );

  if (onBackgroundMessage != null) {
    onBackgroundMessage(message);
  }
}

class FcmNotification {
  late StreamSubscription<String> _tokenSubscription;
  late StreamSubscription<_Message> _backgroundSubscription;
  late StreamSubscription<_Message> _foregroundSubscription;

  FcmToken? _fcmToken;

  /// Initializes the Firebase Messaging connection.
  ///
  /// The [User] is used to register the FCM token with the server.
  ///
  /// Throws an exception if the Firebase Messaging connection is already
  /// initialized.
  Future<void> initialize(
    User session, {
    void Function(RemoteMessage)? onInitialMessage,
    void Function(RemoteMessage)? onBackgroundMessage,
    void Function(RemoteMessage)? onForegroundMessage,
  }) async {
    if (_fcmToken != null) {
      throw Exception("Firebase Messaging already initialized.");
    }

    /// TODO: remove permission request from here
    await _Messaging.instance.requestPermission();

    if (!kIsWeb &&
        (Platform.isIOS || Platform.isMacOS) &&
        await _Messaging.instance.getAPNSToken() == null) {
      throw Exception("Unable to get APNs token for iOS/MacOS.");
    }

    await _Messaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const vapidPublicKey =
        "BFElsGUQxqfLdBDK1kJIoJVj7YsEhMJ78SPW3bEAfcuFjIfk0G0yNtIH9lPo2A0dGtHVdv"
        "xusTFhEEHxbwfkyE8";

    final fcmDeviceToken = await _Messaging.instance.getToken(
      vapidKey: kIsWeb ? vapidPublicKey : null,
    );

    if (fcmDeviceToken == null) {
      throw Exception("Unable to get FCM token.");
    }

    _fcmToken = await di<Client>().notification.registerWithUserId(
          session.id!,
          fcmDeviceToken,
        );

    _tokenSubscription = _Messaging.instance.onTokenRefresh.listen(
      (fcmDeviceToken) async {
        _fcmToken = await di<Client>().notification.registerWithUserId(
              session.id!,
              fcmDeviceToken,
            );
      },
    );

    _tokenSubscription.onError(
      (error) {
        /// TODO: handle error
        log("token error: $error");
      },
    );

    _Messaging.onBackgroundMessage(_onBackgroundMessage);

    _backgroundSubscription = _Messaging.onMessageOpenedApp.listen(
      (message) async => _onBackgroundMessage(
        message,
        onInitialMessage,
        onBackgroundMessage,
        true,
      ),
    );

    _foregroundSubscription = _Messaging.onMessage
        .listen(onForegroundMessage ?? _onForegroundMessage);
  }

  Future<void> setReminder(String reminder, DateTime time) {
    return di<Client>().notification.setReminder(
          di<User>().id!,
          reminder,
          time,
        );
  }

  void _onForegroundMessage(_Message message) {
    log("FCM foreground message: ${message.data}");
  }

  /// Closes the Firebase Messaging connection.
  ///
  /// If [unregister] is `true`, the FCM token is unregistered from the server.
  ///
  /// Throws an exception if the Firebase Messaging connection is not
  /// initialized.
  Future<void> close({bool unregister = false}) async {
    await Future.wait<void>(
      [
        if (unregister) di<Client>().notification.unregister(_fcmToken!),
        _foregroundSubscription.cancel(),
        _backgroundSubscription.cancel(),
        _tokenSubscription.cancel(),
        _Messaging.instance.deleteToken(),
      ],
    );

    _fcmToken = null;
  }
}
