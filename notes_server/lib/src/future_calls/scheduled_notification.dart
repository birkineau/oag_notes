import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
import 'package:serverpod/serverpod.dart';

class ScheduledNotification extends FutureCall<ScheduledNotificationPayload> {
  @override
  Future<void> invoke(
    Session session,
    ScheduledNotificationPayload? object,
  ) async {
    if (object == null) {
      throw StateError("Missing FcmToken object.");
    }

    try {
      await FirebaseApp.notify(
        fcmToken: object.fcmToken,
        title: object.title,
        body: object.body,
        data: object.data,
      );
    } catch (e) {
      print(
        "Unable to send scheduled notification to user "
        "'${object.fcmToken.userId}': $e",
      );
    }

    print(
      "Sent scheduled notification to user '${object.fcmToken.userId}'.",
    );
  }

  static Future<void> schedule(
    Session session, {
    required FcmToken fcmToken,
    required String title,
    String? body,
    Map<String, String>? data,
    required DateTime time,
  }) {
    final payload = ScheduledNotificationPayload(
      fcmToken: fcmToken,
      title: title,
      body: body,
      data: data,
      time: time,
    );

    return session.serverpod.futureCallAtTime(
      ScheduledNotification.key,
      payload,
      time,
      identifier: _getIdentifier(payload),
    );
  }

  static Future<void> unschedule(
    Session session,
    ScheduledNotificationPayload payload,
  ) {
    return session.serverpod.cancelFutureCall(_getIdentifier(payload));
  }

  static final String key = "$ScheduledNotification";

  static String _getIdentifier(ScheduledNotificationPayload payload) {
    return "${key}_${payload.fcmToken.userId}_${payload.time}";
  }
}
