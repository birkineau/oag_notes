/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class User extends _i1.SerializableEntity {
  User._({
    this.id,
    required this.uid,
    required this.email,
    required this.created,
    required this.blocked,
  });

  factory User({
    int? id,
    required String uid,
    required String email,
    required DateTime created,
    required bool blocked,
  }) = _UserImpl;

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      uid: serializationManager.deserialize<String>(jsonSerialization['uid']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      created: serializationManager
          .deserialize<DateTime>(jsonSerialization['created']),
      blocked:
          serializationManager.deserialize<bool>(jsonSerialization['blocked']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String uid;

  String email;

  DateTime created;

  bool blocked;

  User copyWith({
    int? id,
    String? uid,
    String? email,
    DateTime? created,
    bool? blocked,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'uid': uid,
      'email': email,
      'created': created.toJson(),
      'blocked': blocked,
    };
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String uid,
    required String email,
    required DateTime created,
    required bool blocked,
  }) : super._(
          id: id,
          uid: uid,
          email: email,
          created: created,
          blocked: blocked,
        );

  @override
  User copyWith({
    Object? id = _Undefined,
    String? uid,
    String? email,
    DateTime? created,
    bool? blocked,
  }) {
    return User(
      id: id is int? ? id : this.id,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      created: created ?? this.created,
      blocked: blocked ?? this.blocked,
    );
  }
}
