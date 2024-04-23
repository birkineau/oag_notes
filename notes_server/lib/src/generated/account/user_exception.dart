/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class UserException extends _i1.SerializableEntity
    implements _i1.SerializableException {
  UserException._({required this.message});

  factory UserException({required String message}) = _UserExceptionImpl;

  factory UserException.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserException(
        message: serializationManager
            .deserialize<String>(jsonSerialization['message']));
  }

  String message;

  UserException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'message': message};
  }
}

class _UserExceptionImpl extends UserException {
  _UserExceptionImpl({required String message}) : super._(message: message);

  @override
  UserException copyWith({String? message}) {
    return UserException(message: message ?? this.message);
  }
}
