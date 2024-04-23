/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class NotificationException extends _i1.SerializableEntity
    implements _i1.SerializableException {
  NotificationException._({required this.message});

  factory NotificationException({required String message}) =
      _NotificationExceptionImpl;

  factory NotificationException.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return NotificationException(
        message: serializationManager
            .deserialize<String>(jsonSerialization['message']));
  }

  String message;

  NotificationException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

class _NotificationExceptionImpl extends NotificationException {
  _NotificationExceptionImpl({required String message})
      : super._(message: message);

  @override
  NotificationException copyWith({String? message}) {
    return NotificationException(message: message ?? this.message);
  }
}
