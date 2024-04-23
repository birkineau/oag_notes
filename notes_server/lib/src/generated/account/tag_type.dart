/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// A tag associated with a user account.
///
/// Tags are used to handle account capabilities and restrictions.
enum TagType with _i1.SerializableEntity {
  admin,

  /// The user has created an account, but has not yet verified their
  /// authentication provider; unable to sign in.
  unverified,

  /// The user has verified their authentication provider; able to sign in.
  verified;

  static TagType? fromJson(String name) {
    switch (name) {
      case 'admin':
        return admin;
      case 'unverified':
        return unverified;
      case 'verified':
        return verified;
      default:
        return null;
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => toJson();
}
