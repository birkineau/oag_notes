import 'package:notes_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PasscodeDeletion extends FutureCall<Passcode> {
  @override
  Future<void> invoke(Session session, Passcode? object) async {
    if (object == null) {
      throw StateError("Missing $Passcode object.");
    }

    try {
      await Passcode.db.deleteRow(session, object);
      print("Deleted expired email validation code.");
    } catch (e) {
      print("Unable to delete expired email validation code: $e");
    }
  }

  static Future<void> schedule(
    Session session,
    Passcode validationCode,
  ) async {
    await session.serverpod.futureCallAtTime(
      key,
      validationCode,
      validationCode.created.add(passcodeDuration),
      identifier: _getIdentifier(validationCode),
    );
  }

  static Future<void> unschedule(
    Session session,
    Passcode validationCode,
  ) async {
    await session.serverpod.cancelFutureCall(_getIdentifier(validationCode));
  }

  static const Duration passcodeDuration = Duration(minutes: 5);

  static final String key = "$PasscodeDeletion";

  static String _getIdentifier(Passcode validationCode) {
    return "${key}_${validationCode.id}";
  }
}
