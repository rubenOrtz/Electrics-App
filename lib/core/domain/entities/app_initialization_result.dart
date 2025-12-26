import 'package:equatable/equatable.dart';

/// Result of app initialization process
class AppInitializationResult extends Equatable {
  final bool isSuccess;
  final bool shouldShowOnboarding;
  final String? error;
  final StackTrace? stackTrace;

  const AppInitializationResult._({
    required this.isSuccess,
    required this.shouldShowOnboarding,
    this.error,
    this.stackTrace,
  });

  factory AppInitializationResult.success({
    required bool shouldShowOnboarding,
  }) {
    return AppInitializationResult._(
      isSuccess: true,
      shouldShowOnboarding: shouldShowOnboarding,
    );
  }

  factory AppInitializationResult.failure({
    required String error,
    StackTrace? stackTrace,
  }) {
    return AppInitializationResult._(
      isSuccess: false,
      shouldShowOnboarding: false,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  List<Object?> get props =>
      [isSuccess, shouldShowOnboarding, error, stackTrace];
}
