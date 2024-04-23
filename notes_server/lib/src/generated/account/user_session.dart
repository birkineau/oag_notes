/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../protocol.dart' as _i2;

abstract class UserSession extends _i1.SerializableEntity {
  UserSession._({
    required this.user,
    required this.keyId,
    required this.key,
  });

  factory UserSession({
    required _i2.User user,
    required int keyId,
    required String key,
  }) = _UserSessionImpl;

  factory UserSession.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserSession(
      user:
          serializationManager.deserialize<_i2.User>(jsonSerialization['user']),
      keyId: serializationManager.deserialize<int>(jsonSerialization['keyId']),
      key: serializationManager.deserialize<String>(jsonSerialization['key']),
    );
  }

  _i2.User user;

  int keyId;

  String key;

  UserSession copyWith({
    _i2.User? user,
    int? keyId,
    String? key,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'keyId': keyId,
      'key': key,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'user': user.allToJson(),
      'keyId': keyId,
      'key': key,
    };
  }
}

class _UserSessionImpl extends UserSession {
  _UserSessionImpl({
    required _i2.User user,
    required int keyId,
    required String key,
  }) : super._(
          user: user,
          keyId: keyId,
          key: key,
        );

  @override
  UserSession copyWith({
    _i2.User? user,
    int? keyId,
    String? key,
  }) {
    return UserSession(
      user: user ?? this.user.copyWith(),
      keyId: keyId ?? this.keyId,
      key: key ?? this.key,
    );
  }
}
