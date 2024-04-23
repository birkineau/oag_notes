import 'package:notes_server/src/future_calls/future_calls.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class NotesEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes {
    return {
      Scope(TagType.verified.name),
    };
  }

  @override
  bool get logSessions => false;

  Future<int?> createNote(Session session, Note note) async {
    final createdNote = await Note.db.insertRow(session, note);
    final accountId = await session.auth.authenticatedUserId;
    final findFcmToken = FcmToken.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(accountId),
    );

    if (await findFcmToken case final FcmToken fcmToken) {
      // FirebaseApp.notify(
      //   fcmToken: fcmToken,
      //   title: "Note Created",
      //   data: <String, String>{
      //     "noteId": createdNote.id!.toString(),
      //   },
      // );
      await ScheduledNotification.schedule(
        session,
        fcmToken: fcmToken,
        title: "Note Created",
        data: <String, String>{
          "noteId": createdNote.id!.toString(),
        },
        time: DateTime.now().add(const Duration(seconds: 10)),
      );

      print("Notified user $accountId about new note.");
    } else {
      print("No FCM token found for user $accountId");
    }

    return createdNote.id;
  }

  Future<Note> updateNote(Session session, Note note) async {
    return Note.db.updateRow(session, note);
  }

  Future<void> deleteNote(Session session, Note note) async {
    await Note.db.deleteRow(session, note);
  }

  Future<List<Note>> getNotes(Session session) async {
    final userId = await session.auth.authenticatedUserId;

    if (userId == null) {
      return [];
    }

    print("Get notes for user $userId");

    return Note.db.find(
      session,
      orderBy: (note) {
        return note.created;
      },
      orderDescending: true,
    );
  }
}
