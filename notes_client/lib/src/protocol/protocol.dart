/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'account/tag_type.dart' as _i2;
import 'account/user.dart' as _i3;
import 'account/user_exception.dart' as _i4;
import 'account/user_message.dart' as _i5;
import 'account/user_message_type.dart' as _i6;
import 'account/user_session.dart' as _i7;
import 'account/user_tag.dart' as _i8;
import 'account/user_with_tags.dart' as _i9;
import 'note.dart' as _i10;
import 'notification/fcm_token.dart' as _i11;
import 'notification/notification_exception.dart' as _i12;
import 'protocol.dart' as _i13;
import 'package:notes_client/src/protocol/account/user_with_tags.dart' as _i14;
import 'package:notes_client/src/protocol/account/tag_type.dart' as _i15;
import 'package:notes_client/src/protocol/note.dart' as _i16;
export 'account/tag_type.dart';
export 'account/user.dart';
export 'account/user_exception.dart';
export 'account/user_message.dart';
export 'account/user_message_type.dart';
export 'account/user_session.dart';
export 'account/user_tag.dart';
export 'account/user_with_tags.dart';
export 'note.dart';
export 'notification/fcm_token.dart';
export 'notification/notification_exception.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.TagType) {
      return _i2.TagType.fromJson(data) as T;
    }
    if (t == _i3.User) {
      return _i3.User.fromJson(data, this) as T;
    }
    if (t == _i4.UserException) {
      return _i4.UserException.fromJson(data, this) as T;
    }
    if (t == _i5.UserMessage) {
      return _i5.UserMessage.fromJson(data, this) as T;
    }
    if (t == _i6.UserMessageType) {
      return _i6.UserMessageType.fromJson(data) as T;
    }
    if (t == _i7.UserSession) {
      return _i7.UserSession.fromJson(data, this) as T;
    }
    if (t == _i8.UserTag) {
      return _i8.UserTag.fromJson(data, this) as T;
    }
    if (t == _i9.UserWithTags) {
      return _i9.UserWithTags.fromJson(data, this) as T;
    }
    if (t == _i10.Note) {
      return _i10.Note.fromJson(data, this) as T;
    }
    if (t == _i11.FcmToken) {
      return _i11.FcmToken.fromJson(data, this) as T;
    }
    if (t == _i12.NotificationException) {
      return _i12.NotificationException.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.TagType?>()) {
      return (data != null ? _i2.TagType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.User?>()) {
      return (data != null ? _i3.User.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.UserException?>()) {
      return (data != null ? _i4.UserException.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i5.UserMessage?>()) {
      return (data != null ? _i5.UserMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.UserMessageType?>()) {
      return (data != null ? _i6.UserMessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.UserSession?>()) {
      return (data != null ? _i7.UserSession.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.UserTag?>()) {
      return (data != null ? _i8.UserTag.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i9.UserWithTags?>()) {
      return (data != null ? _i9.UserWithTags.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i10.Note?>()) {
      return (data != null ? _i10.Note.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i11.FcmToken?>()) {
      return (data != null ? _i11.FcmToken.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i12.NotificationException?>()) {
      return (data != null
          ? _i12.NotificationException.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.UserTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i13.UserTag>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i13.TagType>) {
      return (data as List).map((e) => deserialize<_i13.TagType>(e)).toList()
          as dynamic;
    }
    if (t == List<_i14.UserWithTags>) {
      return (data as List)
          .map((e) => deserialize<_i14.UserWithTags>(e))
          .toList() as dynamic;
    }
    if (t == Set<_i15.TagType>) {
      return (data as List).map((e) => deserialize<_i15.TagType>(e)).toSet()
          as dynamic;
    }
    if (t == List<_i16.Note>) {
      return (data as List).map((e) => deserialize<_i16.Note>(e)).toList()
          as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i2.TagType) {
      return 'TagType';
    }
    if (data is _i3.User) {
      return 'User';
    }
    if (data is _i4.UserException) {
      return 'UserException';
    }
    if (data is _i5.UserMessage) {
      return 'UserMessage';
    }
    if (data is _i6.UserMessageType) {
      return 'UserMessageType';
    }
    if (data is _i7.UserSession) {
      return 'UserSession';
    }
    if (data is _i8.UserTag) {
      return 'UserTag';
    }
    if (data is _i9.UserWithTags) {
      return 'UserWithTags';
    }
    if (data is _i10.Note) {
      return 'Note';
    }
    if (data is _i11.FcmToken) {
      return 'FcmToken';
    }
    if (data is _i12.NotificationException) {
      return 'NotificationException';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'TagType') {
      return deserialize<_i2.TagType>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i3.User>(data['data']);
    }
    if (data['className'] == 'UserException') {
      return deserialize<_i4.UserException>(data['data']);
    }
    if (data['className'] == 'UserMessage') {
      return deserialize<_i5.UserMessage>(data['data']);
    }
    if (data['className'] == 'UserMessageType') {
      return deserialize<_i6.UserMessageType>(data['data']);
    }
    if (data['className'] == 'UserSession') {
      return deserialize<_i7.UserSession>(data['data']);
    }
    if (data['className'] == 'UserTag') {
      return deserialize<_i8.UserTag>(data['data']);
    }
    if (data['className'] == 'UserWithTags') {
      return deserialize<_i9.UserWithTags>(data['data']);
    }
    if (data['className'] == 'Note') {
      return deserialize<_i10.Note>(data['data']);
    }
    if (data['className'] == 'FcmToken') {
      return deserialize<_i11.FcmToken>(data['data']);
    }
    if (data['className'] == 'NotificationException') {
      return deserialize<_i12.NotificationException>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
