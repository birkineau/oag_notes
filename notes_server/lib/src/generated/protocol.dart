/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'account/tag.dart' as _i3;
import 'account/tag_type.dart' as _i4;
import 'account/user.dart' as _i5;
import 'account/user_exception.dart' as _i6;
import 'account/user_message.dart' as _i7;
import 'account/user_message_type.dart' as _i8;
import 'account/user_session.dart' as _i9;
import 'account/user_tag.dart' as _i10;
import 'account/user_with_tags.dart' as _i11;
import 'note.dart' as _i12;
import 'notification/fcm_token.dart' as _i13;
import 'notification/notification_exception.dart' as _i14;
import 'notification/scheduled_notification_payload.dart' as _i15;
import 'passcode.dart' as _i16;
import 'password_update/password_update.dart' as _i17;
import 'password_update/password_update_deletion_entry.dart' as _i18;
import 'protocol.dart' as _i19;
import 'package:notes_server/src/generated/account/user_with_tags.dart' as _i20;
import 'package:notes_server/src/generated/account/tag_type.dart' as _i21;
import 'package:notes_server/src/generated/note.dart' as _i22;
export 'account/tag.dart';
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
export 'notification/scheduled_notification_payload.dart';
export 'passcode.dart';
export 'password_update/password_update.dart';
export 'password_update/password_update_deletion_entry.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'fcm_token',
      dartName: 'FcmToken',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'fcm_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'token',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'fcm_token_fk_0',
          columns: ['userId'],
          referenceTable: 'user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'fcm_token_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'fcm_token__account_id__unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'note',
      dartName: 'Note',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'note_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'created',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updated',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'note_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'passcode',
      dartName: 'Passcode',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'passcode_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'created',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'passcode_fk_0',
          columns: ['userId'],
          referenceTable: 'user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'passcode_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'passcode_user_id_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'password_update',
      dartName: 'PasswordUpdate',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'password_update_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'passcodeId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'password_update_fk_0',
          columns: ['userId'],
          referenceTable: 'user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'password_update_fk_1',
          columns: ['passcodeId'],
          referenceTable: 'passcode',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'password_update_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'password_update_user_id_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tag',
      dartName: 'Tag',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'tag_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TagType',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tag_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'tag_type_unique_index_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user',
      dartName: 'User',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'uid',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'created',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'blocked',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_tag',
      dartName: 'UserTag',
      schema: 'public',
      module: 'notes',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_tag_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'tagId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_tag_fk_0',
          columns: ['userId'],
          referenceTable: 'user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_tag_fk_1',
          columns: ['tagId'],
          referenceTable: 'tag',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_tag_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_tag_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_tag_userId_tagId_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'tagId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i3.Tag) {
      return _i3.Tag.fromJson(data, this) as T;
    }
    if (t == _i4.TagType) {
      return _i4.TagType.fromJson(data) as T;
    }
    if (t == _i5.User) {
      return _i5.User.fromJson(data, this) as T;
    }
    if (t == _i6.UserException) {
      return _i6.UserException.fromJson(data, this) as T;
    }
    if (t == _i7.UserMessage) {
      return _i7.UserMessage.fromJson(data, this) as T;
    }
    if (t == _i8.UserMessageType) {
      return _i8.UserMessageType.fromJson(data) as T;
    }
    if (t == _i9.UserSession) {
      return _i9.UserSession.fromJson(data, this) as T;
    }
    if (t == _i10.UserTag) {
      return _i10.UserTag.fromJson(data, this) as T;
    }
    if (t == _i11.UserWithTags) {
      return _i11.UserWithTags.fromJson(data, this) as T;
    }
    if (t == _i12.Note) {
      return _i12.Note.fromJson(data, this) as T;
    }
    if (t == _i13.FcmToken) {
      return _i13.FcmToken.fromJson(data, this) as T;
    }
    if (t == _i14.NotificationException) {
      return _i14.NotificationException.fromJson(data, this) as T;
    }
    if (t == _i15.ScheduledNotificationPayload) {
      return _i15.ScheduledNotificationPayload.fromJson(data, this) as T;
    }
    if (t == _i16.Passcode) {
      return _i16.Passcode.fromJson(data, this) as T;
    }
    if (t == _i17.PasswordUpdate) {
      return _i17.PasswordUpdate.fromJson(data, this) as T;
    }
    if (t == _i18.PasswordUpdateDeletionEntry) {
      return _i18.PasswordUpdateDeletionEntry.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i3.Tag?>()) {
      return (data != null ? _i3.Tag.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.TagType?>()) {
      return (data != null ? _i4.TagType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.User?>()) {
      return (data != null ? _i5.User.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.UserException?>()) {
      return (data != null ? _i6.UserException.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i7.UserMessage?>()) {
      return (data != null ? _i7.UserMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.UserMessageType?>()) {
      return (data != null ? _i8.UserMessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.UserSession?>()) {
      return (data != null ? _i9.UserSession.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i10.UserTag?>()) {
      return (data != null ? _i10.UserTag.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i11.UserWithTags?>()) {
      return (data != null ? _i11.UserWithTags.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i12.Note?>()) {
      return (data != null ? _i12.Note.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i13.FcmToken?>()) {
      return (data != null ? _i13.FcmToken.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i14.NotificationException?>()) {
      return (data != null
          ? _i14.NotificationException.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i15.ScheduledNotificationPayload?>()) {
      return (data != null
          ? _i15.ScheduledNotificationPayload.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i16.Passcode?>()) {
      return (data != null ? _i16.Passcode.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i17.PasswordUpdate?>()) {
      return (data != null ? _i17.PasswordUpdate.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i18.PasswordUpdateDeletionEntry?>()) {
      return (data != null
          ? _i18.PasswordUpdateDeletionEntry.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.UserTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i19.UserTag>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i19.UserTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i19.UserTag>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i19.TagType>) {
      return (data as List).map((e) => deserialize<_i19.TagType>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as dynamic;
    }
    if (t == List<_i20.UserWithTags>) {
      return (data as List)
          .map((e) => deserialize<_i20.UserWithTags>(e))
          .toList() as dynamic;
    }
    if (t == Set<_i21.TagType>) {
      return (data as List).map((e) => deserialize<_i21.TagType>(e)).toSet()
          as dynamic;
    }
    if (t == List<_i22.Note>) {
      return (data as List).map((e) => deserialize<_i22.Note>(e)).toList()
          as dynamic;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i3.Tag) {
      return 'Tag';
    }
    if (data is _i4.TagType) {
      return 'TagType';
    }
    if (data is _i5.User) {
      return 'User';
    }
    if (data is _i6.UserException) {
      return 'UserException';
    }
    if (data is _i7.UserMessage) {
      return 'UserMessage';
    }
    if (data is _i8.UserMessageType) {
      return 'UserMessageType';
    }
    if (data is _i9.UserSession) {
      return 'UserSession';
    }
    if (data is _i10.UserTag) {
      return 'UserTag';
    }
    if (data is _i11.UserWithTags) {
      return 'UserWithTags';
    }
    if (data is _i12.Note) {
      return 'Note';
    }
    if (data is _i13.FcmToken) {
      return 'FcmToken';
    }
    if (data is _i14.NotificationException) {
      return 'NotificationException';
    }
    if (data is _i15.ScheduledNotificationPayload) {
      return 'ScheduledNotificationPayload';
    }
    if (data is _i16.Passcode) {
      return 'Passcode';
    }
    if (data is _i17.PasswordUpdate) {
      return 'PasswordUpdate';
    }
    if (data is _i18.PasswordUpdateDeletionEntry) {
      return 'PasswordUpdateDeletionEntry';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Tag') {
      return deserialize<_i3.Tag>(data['data']);
    }
    if (data['className'] == 'TagType') {
      return deserialize<_i4.TagType>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i5.User>(data['data']);
    }
    if (data['className'] == 'UserException') {
      return deserialize<_i6.UserException>(data['data']);
    }
    if (data['className'] == 'UserMessage') {
      return deserialize<_i7.UserMessage>(data['data']);
    }
    if (data['className'] == 'UserMessageType') {
      return deserialize<_i8.UserMessageType>(data['data']);
    }
    if (data['className'] == 'UserSession') {
      return deserialize<_i9.UserSession>(data['data']);
    }
    if (data['className'] == 'UserTag') {
      return deserialize<_i10.UserTag>(data['data']);
    }
    if (data['className'] == 'UserWithTags') {
      return deserialize<_i11.UserWithTags>(data['data']);
    }
    if (data['className'] == 'Note') {
      return deserialize<_i12.Note>(data['data']);
    }
    if (data['className'] == 'FcmToken') {
      return deserialize<_i13.FcmToken>(data['data']);
    }
    if (data['className'] == 'NotificationException') {
      return deserialize<_i14.NotificationException>(data['data']);
    }
    if (data['className'] == 'ScheduledNotificationPayload') {
      return deserialize<_i15.ScheduledNotificationPayload>(data['data']);
    }
    if (data['className'] == 'Passcode') {
      return deserialize<_i16.Passcode>(data['data']);
    }
    if (data['className'] == 'PasswordUpdate') {
      return deserialize<_i17.PasswordUpdate>(data['data']);
    }
    if (data['className'] == 'PasswordUpdateDeletionEntry') {
      return deserialize<_i18.PasswordUpdateDeletionEntry>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i3.Tag:
        return _i3.Tag.t;
      case _i5.User:
        return _i5.User.t;
      case _i10.UserTag:
        return _i10.UserTag.t;
      case _i12.Note:
        return _i12.Note.t;
      case _i13.FcmToken:
        return _i13.FcmToken.t;
      case _i16.Passcode:
        return _i16.Passcode.t;
      case _i17.PasswordUpdate:
        return _i17.PasswordUpdate.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'notes';
}
