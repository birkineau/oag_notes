import 'dart:io';

import 'package:notes_server/src/future_calls/future_calls.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
import 'package:serverpod/serverpod.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get logSessions => false;

  Future<FcmToken> registerWithUserId(
    Session session,
    int userId,
    String fcmDeviceToken,
  ) async {
    try {
      final user = await UserExt.getById(session, userId);
      return _register(session, user, fcmDeviceToken);
    } on UserException catch (e) {
      throw NotificationException(message: e.message);
    } catch (e) {
      stderr.writeln("Unknown $NotificationEndpoint exception: $e");
      throw NotificationException(message: e.toString());
    }
  }

  Future<FcmToken> registerWithEmail(
    Session session,
    String email,
    String fcmDeviceToken,
  ) async {
    try {
      final user = await UserExt.getByEmail(session, email);
      return _register(session, user, fcmDeviceToken);
    } on UserException catch (e) {
      throw NotificationException(message: e.message);
    } catch (e) {
      stderr.writeln("Unknown $NotificationEndpoint exception: $e");
      throw NotificationException(message: e.toString());
    }
  }

  Future<void> setReminder(
    Session session,
    int userId,
    String reminder,
    DateTime time,
  ) async {
    final utcTime = time.toUtc();

    stdout.writeln(
      "the time is: "
      "$time => before = ${utcTime.isBefore(DateTime.now().toUtc())}",
    );

    if (utcTime.isBefore(DateTime.now().toUtc())) {
      throw NotificationException(message: "Time must be in the future.");
    }

    final user = await UserExt.getById(session, userId);

    final fcmToken = await FcmToken.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    if (fcmToken == null) {
      throw NotificationException(
        message: "User not registered for notifications.",
      );
    }

    stdout.writeln(
      "${user.email} (id: ${user.id}): Scheduled reminder @ $time.",
    );

    return ScheduledNotification.schedule(
      session,
      fcmToken: fcmToken,
      title: "Reminder",
      body: reminder,
      time: utcTime,
    );
  }

  Future<void> unregister(Session session, FcmToken token) async {
    await FcmToken.db.deleteWhere(
      session,
      where: (t) => t.userId.equals(token.userId),
    );

    stdout.writeln("Unregistered FCM token for account '${token.userId}'");
  }

  Future<FcmToken> _register(
    Session session,
    User user,
    String fcmDeviceToken,
  ) async {
    var fcmToken = await FcmToken.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    if (fcmToken == null) {
      fcmToken = await FcmToken.db.insertRow(
        session,
        FcmToken(userId: user.id!, token: fcmDeviceToken),
      );
      stdout.writeln("${user.email} (id: ${user.id}): Created FCM token.");
    } else if (fcmToken.token != fcmDeviceToken) {
      fcmToken = await FcmToken.db.updateRow(
        session,
        fcmToken.copyWith(token: fcmDeviceToken),
      );
      stdout.writeln("${user.email} (id: ${user.id}): Updated FCM token.");
    }

    stdout.writeln("${user.email} (id: ${user.id}): Registered FCM token.");

    return fcmToken;
  }
}
