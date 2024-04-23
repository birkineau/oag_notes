import 'package:notes_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PasswordUpdateDeletion extends FutureCall<PasswordUpdateDeletionEntry> {
  @override
  Future<void> invoke(
    Session session,
    PasswordUpdateDeletionEntry? object,
  ) async {
    if (object == null) {
      throw StateError("Missing $PasswordUpdateDeletionEntry object.");
    }

    try {
      await session.dbNext.transaction(
        (transaction) async {
          await PasswordUpdate.db.deleteRow(
            session,
            object.request,
            transaction: transaction,
          );

          await Passcode.db.deleteRow(
            session,
            object.validationCode,
            transaction: transaction,
          );
        },
      );
      print("Deleted expired password update.");
    } catch (e) {
      print("Unable to delete expired password update: $e");
    }
  }

  static Future<void> schedule(
    Session session,
    PasswordUpdate passwordUpdate,
    Passcode validationCode,
  ) {
    return session.serverpod.futureCallAtTime(
      PasswordUpdateDeletion.key,
      PasswordUpdateDeletionEntry(
        request: passwordUpdate,
        validationCode: validationCode,
      ),
      validationCode.created.add(passcodeDuration),
      identifier: _getIdentifier(passwordUpdate),
    );
  }

  static Future<void> unschedule(
    Session session,
    PasswordUpdate passwordUpdate,
  ) {
    return session.serverpod.cancelFutureCall(
      _getIdentifier(passwordUpdate),
    );
  }

  static const Duration passcodeDuration = Duration(minutes: 5);

  static final String key = "$PasswordUpdateDeletion";

  static String _getIdentifier(PasswordUpdate passwordUpdate) {
    return "${key}_${passwordUpdate.userId}_${passwordUpdate.passcodeId}";
  }
}
