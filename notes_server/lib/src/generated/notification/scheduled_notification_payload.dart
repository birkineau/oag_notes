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
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class ScheduledNotificationPayload extends _i1.SerializableEntity {
  ScheduledNotificationPayload._({
    required this.fcmToken,
    required this.title,
    this.body,
    this.data,
    required this.time,
  });

  factory ScheduledNotificationPayload({
    required _i2.FcmToken fcmToken,
    required String title,
    String? body,
    Map<String, String>? data,
    required DateTime time,
  }) = _ScheduledNotificationPayloadImpl;

  factory ScheduledNotificationPayload.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ScheduledNotificationPayload(
      fcmToken: serializationManager
          .deserialize<_i2.FcmToken>(jsonSerialization['fcmToken']),
      title:
          serializationManager.deserialize<String>(jsonSerialization['title']),
      body:
          serializationManager.deserialize<String?>(jsonSerialization['body']),
      data: serializationManager
          .deserialize<Map<String, String>?>(jsonSerialization['data']),
      time:
          serializationManager.deserialize<DateTime>(jsonSerialization['time']),
    );
  }

  _i2.FcmToken fcmToken;

  String title;

  String? body;

  Map<String, String>? data;

  DateTime time;

  ScheduledNotificationPayload copyWith({
    _i2.FcmToken? fcmToken,
    String? title,
    String? body,
    Map<String, String>? data,
    DateTime? time,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'fcmToken': fcmToken.toJson(),
      'title': title,
      if (body != null) 'body': body,
      if (data != null) 'data': data?.toJson(),
      'time': time.toJson(),
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'fcmToken': fcmToken.allToJson(),
      'title': title,
      if (body != null) 'body': body,
      if (data != null) 'data': data?.toJson(),
      'time': time.toJson(),
    };
  }
}

class _Undefined {}

class _ScheduledNotificationPayloadImpl extends ScheduledNotificationPayload {
  _ScheduledNotificationPayloadImpl({
    required _i2.FcmToken fcmToken,
    required String title,
    String? body,
    Map<String, String>? data,
    required DateTime time,
  }) : super._(
          fcmToken: fcmToken,
          title: title,
          body: body,
          data: data,
          time: time,
        );

  @override
  ScheduledNotificationPayload copyWith({
    _i2.FcmToken? fcmToken,
    String? title,
    Object? body = _Undefined,
    Object? data = _Undefined,
    DateTime? time,
  }) {
    return ScheduledNotificationPayload(
      fcmToken: fcmToken ?? this.fcmToken.copyWith(),
      title: title ?? this.title,
      body: body is String? ? body : this.body,
      data: data is Map<String, String>? ? data : this.data?.clone(),
      time: time ?? this.time,
    );
  }
}
