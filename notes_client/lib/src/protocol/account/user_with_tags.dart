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

/// An [User] with a list of their associated tags.
abstract class UserWithTags extends _i1.SerializableEntity {
  UserWithTags._({
    required this.user,
    required this.tags,
  });

  factory UserWithTags({
    required _i2.User user,
    required List<_i2.TagType> tags,
  }) = _UserWithTagsImpl;

  factory UserWithTags.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserWithTags(
      user:
          serializationManager.deserialize<_i2.User>(jsonSerialization['user']),
      tags: serializationManager
          .deserialize<List<_i2.TagType>>(jsonSerialization['tags']),
    );
  }

  /// The user.
  _i2.User user;

  /// The user's associated tags.
  List<_i2.TagType> tags;

  UserWithTags copyWith({
    _i2.User? user,
    List<_i2.TagType>? tags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tags': tags.toJson(valueToJson: (v) => v.toJson()),
    };
  }
}

class _UserWithTagsImpl extends UserWithTags {
  _UserWithTagsImpl({
    required _i2.User user,
    required List<_i2.TagType> tags,
  }) : super._(
          user: user,
          tags: tags,
        );

  @override
  UserWithTags copyWith({
    _i2.User? user,
    List<_i2.TagType>? tags,
  }) {
    return UserWithTags(
      user: user ?? this.user.copyWith(),
      tags: tags ?? this.tags.clone(),
    );
  }
}
