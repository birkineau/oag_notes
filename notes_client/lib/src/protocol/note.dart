/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Note extends _i1.SerializableEntity {
  Note._({
    this.id,
    required this.text,
    required this.created,
    required this.updated,
    required this.active,
  });

  factory Note({
    int? id,
    required String text,
    required DateTime created,
    required DateTime updated,
    required bool active,
  }) = _NoteImpl;

  factory Note.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Note(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      text: serializationManager.deserialize<String>(jsonSerialization['text']),
      created: serializationManager
          .deserialize<DateTime>(jsonSerialization['created']),
      updated: serializationManager
          .deserialize<DateTime>(jsonSerialization['updated']),
      active:
          serializationManager.deserialize<bool>(jsonSerialization['active']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String text;

  DateTime created;

  DateTime updated;

  bool active;

  Note copyWith({
    int? id,
    String? text,
    DateTime? created,
    DateTime? updated,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'created': created.toJson(),
      'updated': updated.toJson(),
      'active': active,
    };
  }
}

class _Undefined {}

class _NoteImpl extends Note {
  _NoteImpl({
    int? id,
    required String text,
    required DateTime created,
    required DateTime updated,
    required bool active,
  }) : super._(
          id: id,
          text: text,
          created: created,
          updated: updated,
          active: active,
        );

  @override
  Note copyWith({
    Object? id = _Undefined,
    String? text,
    DateTime? created,
    DateTime? updated,
    bool? active,
  }) {
    return Note(
      id: id is int? ? id : this.id,
      text: text ?? this.text,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      active: active ?? this.active,
    );
  }
}
