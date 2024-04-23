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

abstract class PasswordUpdateDeletionEntry extends _i1.SerializableEntity {
  PasswordUpdateDeletionEntry._({
    required this.request,
    required this.validationCode,
  });

  factory PasswordUpdateDeletionEntry({
    required _i2.PasswordUpdate request,
    required _i2.Passcode validationCode,
  }) = _PasswordUpdateDeletionEntryImpl;

  factory PasswordUpdateDeletionEntry.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return PasswordUpdateDeletionEntry(
      request: serializationManager
          .deserialize<_i2.PasswordUpdate>(jsonSerialization['request']),
      validationCode: serializationManager
          .deserialize<_i2.Passcode>(jsonSerialization['validationCode']),
    );
  }

  _i2.PasswordUpdate request;

  _i2.Passcode validationCode;

  PasswordUpdateDeletionEntry copyWith({
    _i2.PasswordUpdate? request,
    _i2.Passcode? validationCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request.toJson(),
      'validationCode': validationCode.toJson(),
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'request': request.allToJson(),
      'validationCode': validationCode.allToJson(),
    };
  }
}

class _PasswordUpdateDeletionEntryImpl extends PasswordUpdateDeletionEntry {
  _PasswordUpdateDeletionEntryImpl({
    required _i2.PasswordUpdate request,
    required _i2.Passcode validationCode,
  }) : super._(
          request: request,
          validationCode: validationCode,
        );

  @override
  PasswordUpdateDeletionEntry copyWith({
    _i2.PasswordUpdate? request,
    _i2.Passcode? validationCode,
  }) {
    return PasswordUpdateDeletionEntry(
      request: request ?? this.request.copyWith(),
      validationCode: validationCode ?? this.validationCode.copyWith(),
    );
  }
}
