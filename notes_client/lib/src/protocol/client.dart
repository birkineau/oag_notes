/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:notes_client/src/protocol/account/user_with_tags.dart' as _i3;
import 'package:notes_client/src/protocol/account/tag_type.dart' as _i4;
import 'package:notes_client/src/protocol/note.dart' as _i5;
import 'package:notes_client/src/protocol/notification/fcm_token.dart' as _i6;
import 'package:notes_client/src/protocol/account/user_session.dart' as _i7;
import 'protocol.dart' as _i8;

/// {@category Endpoint}
class EndpointAccountManager extends _i1.EndpointRef {
  EndpointAccountManager(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'accountManager';

  _i2.Future<List<_i3.UserWithTags>> getUsers() =>
      caller.callServerEndpoint<List<_i3.UserWithTags>>(
        'accountManager',
        'getUsers',
        {},
      );

  _i2.Future<bool> addTagTypes(
    int userId,
    Set<_i4.TagType> types,
  ) =>
      caller.callServerEndpoint<bool>(
        'accountManager',
        'addTagTypes',
        {
          'userId': userId,
          'types': types,
        },
      );

  _i2.Future<bool> removeTagTypes(
    int userId,
    Set<_i4.TagType> types,
  ) =>
      caller.callServerEndpoint<bool>(
        'accountManager',
        'removeTagTypes',
        {
          'userId': userId,
          'types': types,
        },
      );

  _i2.Future<void> block(int userId) => caller.callServerEndpoint<void>(
        'accountManager',
        'block',
        {'userId': userId},
      );

  _i2.Future<void> unblock(int userId) => caller.callServerEndpoint<void>(
        'accountManager',
        'unblock',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointNotes extends _i1.EndpointRef {
  EndpointNotes(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notes';

  _i2.Future<int?> createNote(_i5.Note note) => caller.callServerEndpoint<int?>(
        'notes',
        'createNote',
        {'note': note},
      );

  _i2.Future<_i5.Note> updateNote(_i5.Note note) =>
      caller.callServerEndpoint<_i5.Note>(
        'notes',
        'updateNote',
        {'note': note},
      );

  _i2.Future<void> deleteNote(_i5.Note note) => caller.callServerEndpoint<void>(
        'notes',
        'deleteNote',
        {'note': note},
      );

  _i2.Future<List<_i5.Note>> getNotes() =>
      caller.callServerEndpoint<List<_i5.Note>>(
        'notes',
        'getNotes',
        {},
      );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<_i6.FcmToken> registerWithUserId(
    int userId,
    String fcmDeviceToken,
  ) =>
      caller.callServerEndpoint<_i6.FcmToken>(
        'notification',
        'registerWithUserId',
        {
          'userId': userId,
          'fcmDeviceToken': fcmDeviceToken,
        },
      );

  _i2.Future<_i6.FcmToken> registerWithEmail(
    String email,
    String fcmDeviceToken,
  ) =>
      caller.callServerEndpoint<_i6.FcmToken>(
        'notification',
        'registerWithEmail',
        {
          'email': email,
          'fcmDeviceToken': fcmDeviceToken,
        },
      );

  _i2.Future<void> setReminder(
    int userId,
    String reminder,
    DateTime time,
  ) =>
      caller.callServerEndpoint<void>(
        'notification',
        'setReminder',
        {
          'userId': userId,
          'reminder': reminder,
          'time': time,
        },
      );

  _i2.Future<void> unregister(_i6.FcmToken token) =>
      caller.callServerEndpoint<void>(
        'notification',
        'unregister',
        {'token': token},
      );
}

/// TODO: Microsoft and Google email providers.
/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<void> createUserFromFirebaseIdToken(String idToken) =>
      caller.callServerEndpoint<void>(
        'user',
        'createUserFromFirebaseIdToken',
        {'idToken': idToken},
      );

  _i2.Future<void> requestPasswordUpdate(String email) =>
      caller.callServerEndpoint<void>(
        'user',
        'requestPasswordUpdate',
        {'email': email},
      );

  /// TODO: check this
  /// This one overwrites any existing passcode, even if it is a passcode that
  /// was created due to a password update request.
  _i2.Future<void> sendUserValidationCode(String email) =>
      caller.callServerEndpoint<void>(
        'user',
        'sendUserValidationCode',
        {'email': email},
      );

  _i2.Future<void> validatePasswordUpdateWithCode(
    String email,
    String newPassword,
    String code,
  ) =>
      caller.callServerEndpoint<void>(
        'user',
        'validatePasswordUpdateWithCode',
        {
          'email': email,
          'newPassword': newPassword,
          'code': code,
        },
      );

  _i2.Future<void> validateUserWithCode(
    String email,
    String code,
  ) =>
      caller.callServerEndpoint<void>(
        'user',
        'validateUserWithCode',
        {
          'email': email,
          'code': code,
        },
      );

  _i2.Future<_i7.UserSession> signInWithEmail(String email) =>
      caller.callServerEndpoint<_i7.UserSession>(
        'user',
        'signInWithEmail',
        {'email': email},
      );

  _i2.Future<void> signOut(String email) => caller.callServerEndpoint<void>(
        'user',
        'signOut',
        {'email': email},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i8.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    accountManager = EndpointAccountManager(this);
    notes = EndpointNotes(this);
    notification = EndpointNotification(this);
    user = EndpointUser(this);
  }

  late final EndpointAccountManager accountManager;

  late final EndpointNotes notes;

  late final EndpointNotification notification;

  late final EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'accountManager': accountManager,
        'notes': notes,
        'notification': notification,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
