import 'package:shared_preferences/shared_preferences.dart';
import 'package:electrician_app/features/components/domain/repositories/component_repository.dart';
import 'package:electrician_app/core/domain/entities/app_initialization_result.dart';

/// Use Case for initializing the application
///
/// Orchestrates all initialization logic including:
/// - Database seed data verification and loading
/// - SharedPreferences setup
/// - App status determination (onboarding vs authenticated)
///
/// This keeps initialization logic out of the presentation layer
class InitializeAppUseCase {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  final ComponentRepository _componentRepository;
  final SharedPreferences _prefs;

  const InitializeAppUseCase({
    required ComponentRepository componentRepository,
    required SharedPreferences prefs,
  })  : _componentRepository = componentRepository,
        _prefs = prefs;

  Future<AppInitializationResult> call() async {
    try {
      // 1. Verify and load component seed data if needed
      final hasSeed = await _componentRepository.hasSeedData();
      if (!hasSeed) {
        await _componentRepository.loadSeedData();
      }

      // 2. Determine if user needs onboarding
      final hasCompletedOnboarding =
          _prefs.getBool(_onboardingCompletedKey) ?? false;

      return AppInitializationResult.success(
        shouldShowOnboarding: !hasCompletedOnboarding,
      );
    } catch (e, stackTrace) {
      return AppInitializationResult.failure(
        error: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
