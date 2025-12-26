import 'package:flutter/material.dart';

/// Custom route observer for lifecycle tracking
/// Helps with resource management and analytics
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation('POP', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _logNavigation('REPLACE', newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logNavigation('REMOVE', route, previousRoute);
  }

  void _logNavigation(
    String action,
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    // Debug logging for development - stripped in release builds
    if (route.settings.name != null) {
      debugPrint(
        '🧭 Navigation [$action]: ${route.settings.name} '
        '${previousRoute?.settings.name != null ? "from ${previousRoute?.settings.name}" : ""}',
      );
    }
  }
}

/// Global route observer instance
final appRouteObserver = AppRouteObserver();
