/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/account_manager_endpoint.dart' as _i2;
import '../endpoints/notes_endpoint.dart' as _i3;
import '../endpoints/notification_endpoint.dart' as _i4;
import '../endpoints/user_endpoint.dart' as _i5;
import '../endpoints/account_endpoint.dart' as _i6;
import 'package:notes_server/src/generated/account/tag_type.dart' as _i7;
import 'package:notes_server/src/generated/note.dart' as _i8;
import 'package:notes_server/src/generated/notification/fcm_token.dart' as _i9;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'accountManager': _i2.AccountManagerEndpoint()
        ..initialize(
          server,
          'accountManager',
          null,
        ),
      'notes': _i3.NotesEndpoint()
        ..initialize(
          server,
          'notes',
          null,
        ),
      'notification': _i4.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'user': _i5.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['accountManager'] = _i1.EndpointConnector(
      name: 'accountManager',
      endpoint: endpoints['accountManager']!,
      methodConnectors: {
        'getUsers': _i1.MethodConnector(
          name: 'getUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i6.AccountManagerEndpoint)
                  .getUsers(session),
        ),
        'addTagTypes': _i1.MethodConnector(
          name: 'addTagTypes',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<Set<_i7.TagType>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i6.AccountManagerEndpoint)
                  .addTagTypes(
            session,
            params['userId'],
            params['types'],
          ),
        ),
        'removeTagTypes': _i1.MethodConnector(
          name: 'removeTagTypes',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<Set<_i7.TagType>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i6.AccountManagerEndpoint)
                  .removeTagTypes(
            session,
            params['userId'],
            params['types'],
          ),
        ),
        'block': _i1.MethodConnector(
          name: 'block',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i6.AccountManagerEndpoint).block(
            session,
            params['userId'],
          ),
        ),
        'unblock': _i1.MethodConnector(
          name: 'unblock',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i6.AccountManagerEndpoint)
                  .unblock(
            session,
            params['userId'],
          ),
        ),
      },
    );
    connectors['accountManager'] = _i1.EndpointConnector(
      name: 'accountManager',
      endpoint: endpoints['accountManager']!,
      methodConnectors: {
        'getUsers': _i1.MethodConnector(
          name: 'getUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i2.AccountManagerEndpoint)
                  .getUsers(session),
        ),
        'addTagTypes': _i1.MethodConnector(
          name: 'addTagTypes',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<Set<_i7.TagType>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i2.AccountManagerEndpoint)
                  .addTagTypes(
            session,
            params['userId'],
            params['types'],
          ),
        ),
        'removeTagTypes': _i1.MethodConnector(
          name: 'removeTagTypes',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<Set<_i7.TagType>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i2.AccountManagerEndpoint)
                  .removeTagTypes(
            session,
            params['userId'],
            params['types'],
          ),
        ),
        'block': _i1.MethodConnector(
          name: 'block',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i2.AccountManagerEndpoint).block(
            session,
            params['userId'],
          ),
        ),
        'unblock': _i1.MethodConnector(
          name: 'unblock',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['accountManager'] as _i2.AccountManagerEndpoint)
                  .unblock(
            session,
            params['userId'],
          ),
        ),
      },
    );
    connectors['notes'] = _i1.EndpointConnector(
      name: 'notes',
      endpoint: endpoints['notes']!,
      methodConnectors: {
        'createNote': _i1.MethodConnector(
          name: 'createNote',
          params: {
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<_i8.Note>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notes'] as _i3.NotesEndpoint).createNote(
            session,
            params['note'],
          ),
        ),
        'updateNote': _i1.MethodConnector(
          name: 'updateNote',
          params: {
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<_i8.Note>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notes'] as _i3.NotesEndpoint).updateNote(
            session,
            params['note'],
          ),
        ),
        'deleteNote': _i1.MethodConnector(
          name: 'deleteNote',
          params: {
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<_i8.Note>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notes'] as _i3.NotesEndpoint).deleteNote(
            session,
            params['note'],
          ),
        ),
        'getNotes': _i1.MethodConnector(
          name: 'getNotes',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notes'] as _i3.NotesEndpoint).getNotes(session),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'registerWithUserId': _i1.MethodConnector(
          name: 'registerWithUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fcmDeviceToken': _i1.ParameterDescription(
              name: 'fcmDeviceToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i4.NotificationEndpoint)
                  .registerWithUserId(
            session,
            params['userId'],
            params['fcmDeviceToken'],
          ),
        ),
        'registerWithEmail': _i1.MethodConnector(
          name: 'registerWithEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fcmDeviceToken': _i1.ParameterDescription(
              name: 'fcmDeviceToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i4.NotificationEndpoint)
                  .registerWithEmail(
            session,
            params['email'],
            params['fcmDeviceToken'],
          ),
        ),
        'setReminder': _i1.MethodConnector(
          name: 'setReminder',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reminder': _i1.ParameterDescription(
              name: 'reminder',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'time': _i1.ParameterDescription(
              name: 'time',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i4.NotificationEndpoint)
                  .setReminder(
            session,
            params['userId'],
            params['reminder'],
            params['time'],
          ),
        ),
        'unregister': _i1.MethodConnector(
          name: 'unregister',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<_i9.FcmToken>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i4.NotificationEndpoint)
                  .unregister(
            session,
            params['token'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'createUserFromFirebaseIdToken': _i1.MethodConnector(
          name: 'createUserFromFirebaseIdToken',
          params: {
            'idToken': _i1.ParameterDescription(
              name: 'idToken',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint)
                  .createUserFromFirebaseIdToken(
            session,
            params['idToken'],
          ),
        ),
        'requestPasswordUpdate': _i1.MethodConnector(
          name: 'requestPasswordUpdate',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).requestPasswordUpdate(
            session,
            params['email'],
          ),
        ),
        'sendUserValidationCode': _i1.MethodConnector(
          name: 'sendUserValidationCode',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).sendUserValidationCode(
            session,
            params['email'],
          ),
        ),
        'validatePasswordUpdateWithCode': _i1.MethodConnector(
          name: 'validatePasswordUpdateWithCode',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint)
                  .validatePasswordUpdateWithCode(
            session,
            params['email'],
            params['newPassword'],
            params['code'],
          ),
        ),
        'validateUserWithCode': _i1.MethodConnector(
          name: 'validateUserWithCode',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).validateUserWithCode(
            session,
            params['email'],
            params['code'],
          ),
        ),
        'signInWithEmail': _i1.MethodConnector(
          name: 'signInWithEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).signInWithEmail(
            session,
            params['email'],
          ),
        ),
        'signOut': _i1.MethodConnector(
          name: 'signOut',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).signOut(
            session,
            params['email'],
          ),
        ),
      },
    );
  }
}
