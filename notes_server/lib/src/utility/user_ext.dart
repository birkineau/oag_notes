import 'dart:io';

import 'package:collection/collection.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
import 'package:serverpod/serverpod.dart';

class UserExt {
  static Future<User> getById(Session session, int id) async {
    if (await User.db.findById(session, id) case final User user) {
      return user;
    }

    throw UserException(message: "User not found.");
  }

  static Future<User> getByEmail(Session session, String email) async {
    final getUserByEmail = User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );

    if (await getUserByEmail case final User user) {
      return user;
    }

    throw UserException(message: "User not found.");
  }

  static Future<bool> hasTagTypes(
    Session session,
    User user,
    Set<TagType> types,
  ) async {
    final userTags = await UserTag.db.find(
      session,
      where: (t) => t.userId.equals(user.id),
    );

    if (userTags.isEmpty) {
      return false;
    }

    final config = di<ServerConfiguration>();

    for (final type in types) {
      /// Get the tag id associated with the tag type.
      final tagTypeId = config.tagByType(type).id!;

      /// The user is missing this tag if none of the user tag ids match the
      /// tag id obtained from the tag type.
      if (userTags.none((t) => t.tagId == tagTypeId)) {
        return false;
      }
    }

    return true;
  }

  /// Adds tags to a user by [TagType]. If the user already has a tag that
  /// matches the tag type by id, the tag is not added.
  ///
  /// Returns `true` if at least one user tag was added, `false` otherwise.
  static Future<bool> addTagsByType(
    Session session,
    int userId,
    Set<TagType> types,
  ) async {
    final userTags = await UserTag.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final config = di<ServerConfiguration>();
    final newTags = <UserTag>[];

    for (final type in types) {
      /// The id of the tag to add to the user.
      final additionTagId = config.tagByType(type).id!;

      /// The user has this tag if any of their tag ids match the tag id
      /// obtained from the tag type.
      if (userTags.any((t) => t.tagId == additionTagId)) {
        continue;
      }

      newTags.add(UserTag(userId: userId, tagId: additionTagId));
    }

    /// If `newTags` is empty, the user already has all the tags in `types`.
    if (newTags.isEmpty) {
      return false;
    }

    await UserTag.db.insert(session, newTags);
    return true;
  }

  static Future<bool> removeTagsByType(
    Session session,
    int userId,
    Set<TagType> types,
  ) async {
    final userTags = await UserTag.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final config = di<ServerConfiguration>();
    final tagsToRemove = <UserTag>[];

    for (final type in types) {
      /// The id of the tag to remove from the user.
      final removalTagId = config.tagByType(type).id!;

      /// The user has this tag if any of their tag ids match the tag id
      /// obtained from the tag type.
      final tag = userTags.firstWhereOrNull((t) => t.tagId == removalTagId);

      if (tag != null) {
        tagsToRemove.add(tag);
      }
    }

    /// If `tagsToRemove` is empty, the user does not have any of the tags in
    /// `types`.
    if (tagsToRemove.isEmpty) {
      return false;
    }

    await UserTag.db.delete(session, tagsToRemove);
    return true;
  }

  static void log(User user, String message) {
    stdout.writeln(
      "${user.email} (id: ${user.id}): $message @ ${DateTime.now()}",
    );
  }
}
