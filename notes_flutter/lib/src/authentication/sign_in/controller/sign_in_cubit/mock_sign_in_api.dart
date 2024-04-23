import 'dart:math';

import 'package:notes_flutter/src/authentication/authentication.dart';

abstract class MockApi {
  const MockApi({
    this.delay = const Duration(seconds: 1),
    this.failureChance = .0,
  });

  /// The delay before the response is returned.
  final Duration delay;

  /// The chance of failure in the sign-in and sign-out operations.
  final double failureChance;

  Future<String?> runAsync(Future<String?> Function() callback) async {
    await Future<void>.delayed(delay);

    if (failureChance > .0 && _random.nextDouble() < failureChance) {
      return _mockError;
    }

    return callback();
  }

  static const _mockError = "An error occurred.";
  static final _random = Random();
}

/// A mock implementation of the [SignInApi] that simulates sign-in operations.
///
/// The mock implementation simulates a [delay] before returning a response, and
/// a shared [failureChance] of failure in the operations.
///
/// Operations:
/// * [SignInApi.signIn] simulates signing in.
/// * [SignInApi.signOut] simulates signing out.
class MockSignInApi extends MockApi implements SignInApi {
  const MockSignInApi({
    super.delay = const Duration(seconds: 1),
    super.failureChance = .0,
  });

  @override
  Future<String?> signIn(String email, String password) async {
    return runAsync(
      () async {
        if (email != _kMockEmail || password != _kMockPassword) {
          return "Invalid mock credentials; "
              "use email '$_kMockEmail' and password '$_kMockPassword'.";
        }

        return null;
      },
    );
  }

  @override
  Future<String?> signOut() {
    return runAsync(() async => null);
  }

  static const _kMockEmail = "abc.123@example.com";
  static const _kMockPassword = "a123456!";
}
