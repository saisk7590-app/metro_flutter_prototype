import 'package:flutter/foundation.dart';

void logTokenDiagnostics(String stage, String token) {
  final fingerprint = token.hashCode.toRadixString(16).padLeft(8, '0');

  debugPrint(
    'Token [$stage]: fingerprint=$fingerprint '
    'length=${token.length} '
    'parts=${token.split('.').length} '
    'hasGf=${token.contains('&gF=')}',
  );
}

