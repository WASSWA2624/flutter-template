import 'package:flutter_template/app/router/app_routes.dart';
import 'package:flutter_template/core/permissions/app_permission.dart';
import 'package:flutter_template/core/security/session_readiness.dart';

final class AppRouteGuardRequest {
  const AppRouteGuardRequest({
    required this.location,
    this.grantedPermissions = const <AppPermission>{},
  });

  final Uri location;
  final Set<AppPermission> grantedPermissions;
}

final class AppRouteGuards {
  const AppRouteGuards({
    required this.sessionReadiness,
    this.routes = AppRoutes.all,
  });

  final SessionReadiness sessionReadiness;
  final List<AppRouteData> routes;

  String? redirect(AppRouteGuardRequest request) {
    final AppRouteData? targetRoute = _matchRoute(request.location.path);
    if (targetRoute == null || !targetRoute.requiresAuthenticatedSession) {
      return null;
    }

    if (!sessionReadiness.isReady) {
      return AppRoutes.sessionRestoring.locationWithFrom(request.location);
    }

    if (!sessionReadiness.isAuthenticated) {
      return switch (sessionReadiness.status) {
        SessionStatus.forbidden => AppRoutes.forbidden.locationWithFrom(
          request.location,
        ),
        SessionStatus.expired || SessionStatus.unauthenticated =>
          AppRoutes.authRequired.locationWithFrom(request.location),
        SessionStatus.unknown => AppRoutes.sessionRestoring.locationWithFrom(
          request.location,
        ),
        SessionStatus.authenticated => null,
      };
    }

    if (!_hasRequiredPermissions(targetRoute, request.grantedPermissions)) {
      return AppRoutes.forbidden.locationWithFrom(request.location);
    }

    return null;
  }

  AppRouteData? _matchRoute(String locationPath) {
    for (final AppRouteData route in routes) {
      if (route.matchesPath(locationPath)) {
        return route;
      }
    }

    return null;
  }

  bool _hasRequiredPermissions(
    AppRouteData route,
    Set<AppPermission> grantedPermissions,
  ) {
    return grantedPermissions.containsAll(route.requiredPermissions);
  }
}
