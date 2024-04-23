import 'dart:math' as math;
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<AuthenticationInfo?> authenticationHandler(
  Session session,
  String key,
) async {
  try {
    final parts = key.split(":");
    final keyId = int.tryParse(parts[0]);

    if (keyId == null) {
      stderr.writeln("Unable to parse authentication key id.");
      return null;
    }

    // Get the authentication key from the database
    final tempSession = await Serverpod.instance.createSession(
      enableLogging: false,
    );

    final authKey = await tempSession.dbNext.findById<AuthKey>(keyId);
    final closeTmpSession = tempSession.close();

    if (authKey == null) {
      stderr.writeln("Missing authentication key.");
      return null;
    }

    assert(
      session.passwords.containsKey("authKeySalt"),
      "Missing 'authKeySalt' in session passwords.",
    );

    final authKeySalt = session.passwords["authKeySalt"]!;

    if (authKey.hash != hashString(authKeySalt, parts[1])) {
      stderr.writeln("Invalid authentication key hash.");
      return null;
    }

    await closeTmpSession;

    return AuthenticationInfo(
      authKey.userId,
      <Scope>{
        for (final scopeName in authKey.scopeNames) Scope(scopeName),
      },
    );
  } catch (exception, stackTrace) {
    stderr.writeln('Failed authentication: $exception');
    stderr.writeln('$stackTrace');
    return null;
  }
}

final random = math.Random.secure();

String hashString(String secret, String string) {
  return sha256.convert(utf8.encode(secret + string)).toString();
}

String generateRandomString([int length = 32]) {
  var values = List<int>.generate(length, (int i) => random.nextInt(256));
  return base64Url.encode(values).substring(0, length);
}
