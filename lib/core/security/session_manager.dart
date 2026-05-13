import 'package:flutter_template/core/security/session_readiness.dart';

final class SessionManager {
  const SessionManager();

  Future<SessionReadiness> restore() async {
    return const SessionReadiness.unauthenticated();
  }
}
