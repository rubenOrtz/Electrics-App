import 'package:flutter/material.dart';

/// Centralized navigation service for programmatic navigation
/// Prevents navigation issues and provides type-safe navigation
class NavigationService {
  // Global key for navigator
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Get current context
  BuildContext? get currentContext => navigatorKey.currentContext;

  // Get current navigator state
  NavigatorState? get navigator => navigatorKey.currentState;

  /// Navigate to a named route
  Future<T?>? navigateTo<T>(String routeName, {Object? arguments}) {
    return navigator?.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate and remove all previous routes
  Future<T?>? navigateAndRemoveUntil<T>(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigator?.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  /// Replace current route
  Future<T?>? navigateAndReplace<T, TO>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigator?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Pop current route
  void goBack<T>([T? result]) {
    navigator?.pop<T>(result);
  }

  /// Pop until specific route
  void popUntil(String routeName) {
    navigator?.popUntil((route) => route.settings.name == routeName);
  }

  /// Check if can pop
  bool canPop() {
    return navigator?.canPop() ?? false;
  }

  /// Pop all routes and navigate to new route
  Future<T?>? navigateToAndClearStack<T>(String routeName,
      {Object? arguments}) {
    return navigateAndRemoveUntil<T>(routeName, arguments: arguments);
  }
}

/// Global navigation service instance
final navigationService = NavigationService();
