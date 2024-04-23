import 'dart:collection';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:notes_server/src/generated/protocol.dart';
import 'package:notes_server/src/utility/utility.dart';
import 'package:serverpod/serverpod.dart';

final di = GetIt.instance;

class ServerConfiguration {
  ServerConfiguration(this.serverpod)
      : _tagsById = HashMap<int, Tag>(),
        _tagsByType = HashMap<TagType, Tag>();

  final Serverpod serverpod;
  late final Session session;

  final Map<int, Tag> _tagsById;
  final Map<TagType, Tag> _tagsByType;

  Tag tagById(int id) {
    return _tagsById[id]!;
  }

  Tag tagByType(TagType type) {
    return _tagsByType[type]!;
  }

  Future<void> initialize() async {
    if (di.isRegistered<ServerConfiguration>()) {
      return;
    }

    session = await serverpod.createSession(enableLogging: false);

    await Future.wait<void>(
      [
        FirebaseApp.initializeFCM(),
        _initializeTagTypes(),
      ],
    );

    di.registerSingleton<ServerConfiguration>(this);
  }

  Future<void> _initializeTagTypes() async {
    try {
      final tags = await session.dbNext.find<Tag>();
      final requiredTagTypes = HashSet<TagType>.of(TagType.values);
      final existingTagTypes = HashSet<TagType>.of([
        for (final tag in tags) tag.type,
      ]);

      final missingTagTypes = requiredTagTypes.difference(existingTagTypes);

      /// Insert missing tags and update cache.
      if (missingTagTypes.isNotEmpty) {
        final insertedTags = await session.dbNext.insert<Tag>([
          for (final type in missingTagTypes) Tag(type: type),
        ]);

        tags.addAll(insertedTags);

        final databaseTagTypes = HashSet<TagType>.of([
          for (final tag in tags..addAll(insertedTags)) tag.type,
        ]);

        if (!requiredTagTypes.containsAll(databaseTagTypes)) {
          throw Exception(
            "Missing required tags: "
            "${requiredTagTypes.difference(databaseTagTypes)}",
          );
        }

        stdout.writeln("Tags updated: $databaseTagTypes");
      } else {
        stdout.writeln("Tags are up to date.");
      }

      for (final tag in tags) {
        _tagsById[tag.id!] = tag;
        _tagsByType[tag.type] = tag;
      }
    } catch (exception, stackTrace) {
      stderr
        ..writeln("Failed $TagType initialization: $exception")
        ..writeln('$stackTrace');
    }
  }

  Future<void> close() {
    return session.close();
  }
}
