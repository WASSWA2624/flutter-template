import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/security/session_readiness.dart';

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return const SessionManager();
});

final class SessionManager {
  const SessionManager();

  Future<SessionReadiness> restore() async {
    return const SessionReadiness.unauthenticated();
  }

  Future<String?> readAccessToken() async {
    return null;
  }

  Future<void> handleUnauthorizedResponse() async {}
}
