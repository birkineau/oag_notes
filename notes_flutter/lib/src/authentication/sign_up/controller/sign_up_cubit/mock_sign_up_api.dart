import 'dart:math';

import 'package:notes_flutter/src/authentication/authentication.dart';

/// A mock implementation of the [SignUpApi] that simulates sign-up operations.
///
/// The mock implementation simulates a [delay] before returning a response, and
/// a shared [failureChance] of failure in the operations.
///
/// Operations:
/// * [SignUpApi.createAccount] simulates creating an account.
/// * [SignUpApi.requestValidationCode] simulates requesting a validation code.
/// * [SignUpApi.validateAccount] simulates validating an account.
class MockSignUpApi implements SignUpApi {
  const MockSignUpApi({
    this.delay = const Duration(seconds: 1),
    this.failureChance = .0,
  });

  static final Random _random = Random();

  /// The delay before the response is returned.
  final Duration delay;

  /// The chance of failure in the sign-in and sign-out operations.
  final double failureChance;

  @override
  Future<String?> createAccount(String email, String password) async {
    await Future<void>.delayed(delay);

    if (failureChance > .0 && _random.nextDouble() < failureChance) {
      return kMockError;
    }

    return null;
  }

  @override
  Future<String?> requestValidationCode(String email) async {
    await Future<void>.delayed(delay);

    if (failureChance > .0 && _random.nextDouble() < failureChance) {
      return kMockError;
    }

    return null;
  }

  @override
  Future<String?> validateAccount(String email, String code) async {
    await Future<void>.delayed(delay);

    if (failureChance > .0 && _random.nextDouble() < failureChance) {
      return kMockError;
    }

    if (code != "123456") {
      return "Invalid code; the mock code is '123456'.";
    }

    return null;
  }
}
