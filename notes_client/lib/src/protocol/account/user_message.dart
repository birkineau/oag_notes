/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../protocol.dart' as _i2;

abstract class UserMessage extends _i1.SerializableEntity {
  UserMessage._({
    required this.user,
    required this.type,
  });

  factory UserMessage({
    required _i2.User user,
    required _i2.UserMessageType type,
  }) = _UserMessageImpl;

  factory UserMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserMessage(
      user:
          serializationManager.deserialize<_i2.User>(jsonSerialization['user']),
      type: serializationManager
          .deserialize<_i2.UserMessageType>(jsonSerialization['type']),
    );
  }

  _i2.User user;

  _i2.UserMessageType type;

  UserMessage copyWith({
    _i2.User? user,
    _i2.UserMessageType? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'type': type.toJson(),
    };
  }
}

class _UserMessageImpl extends UserMessage {
  _UserMessageImpl({
    required _i2.User user,
    required _i2.UserMessageType type,
  }) : super._(
          user: user,
          type: type,
        );

  @override
  UserMessage copyWith({
    _i2.User? user,
    _i2.UserMessageType? type,
  }) {
    return UserMessage(
      user: user ?? this.user.copyWith(),
      type: type ?? this.type,
    );
  }
}
