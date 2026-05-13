final class SessionReadiness {
  const SessionReadiness.ready() : isReady = true, hasRestoredSession = false;

  const SessionReadiness.notReady()
    : isReady = false,
      hasRestoredSession = false;

  final bool isReady;
  final bool hasRestoredSession;
}
