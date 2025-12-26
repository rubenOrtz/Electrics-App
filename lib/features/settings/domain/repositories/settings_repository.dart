import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/app_preferences.dart';
import '../entities/app_theme_mode.dart';
import '../entities/user_profile.dart';
import '../../../onboarding/domain/entities/onboarding_preferences.dart';

abstract class SettingsRepository {
  // ============================================================================
  // Electrical Standard Settings (existing)
  // ============================================================================

  Future<Either<Failure, String>> getDefaultElectricalStandard();
  Future<Either<Failure, void>> setDefaultElectricalStandard(String id);

  // ============================================================================
  // App Preferences (new)
  // ============================================================================

  /// Retrieves all app preferences
  Future<Either<Failure, AppPreferences>> getAppPreferences();

  /// Saves all app preferences
  Future<Either<Failure, void>> saveAppPreferences(AppPreferences prefs);

  /// Sets the app locale (language)
  Future<Either<Failure, void>> setLocale(String locale);

  /// Sets the text size preference
  Future<Either<Failure, void>> setTextSize(TextSizePreference size);

  /// Sets the theme mode
  Future<Either<Failure, void>> setThemeMode(AppThemeMode mode);

  /// Uses shared Isar instance for true transactional atomicity
  Future<Either<Failure, void>> saveOnboardingDataTransaction({
    required UserProfile profile,
    required OnboardingPreferences preferences,
  });
}
