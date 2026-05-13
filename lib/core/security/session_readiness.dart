enum SessionStatus {
  unknown,
  unauthenticated,
  authenticated,
  expired,
  forbidden,
}

final class SessionReadiness {
  const SessionReadiness.ready() : status = SessionStatus.unauthenticated;

  const SessionReadiness.notReady() : status = SessionStatus.unknown;

  const SessionReadiness.unauthenticated()
    : status = SessionStatus.unauthenticated;

  const SessionReadiness.authenticated() : status = SessionStatus.authenticated;

  const SessionReadiness.expired() : status = SessionStatus.expired;

  const SessionReadiness.forbidden() : status = SessionStatus.forbidden;

  final SessionStatus status;

  bool get isReady => status != SessionStatus.unknown;

  bool get hasRestoredSession => status == SessionStatus.authenticated;

  bool get isAuthenticated => status == SessionStatus.authenticated;
}
