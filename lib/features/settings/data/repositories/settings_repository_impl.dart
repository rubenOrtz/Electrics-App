import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../../../../core/error/failures.dart';

import '../../../onboarding/data/models/onboarding_status_dto.dart';
import '../../../onboarding/domain/entities/onboarding_preferences.dart';
import '../../data/models/app_preferences_dto.dart';
import '../../data/models/app_settings_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Isar _isar;
  static const int _settingsId = 1;
  static const int _prefsId = 0; // Singleton for AppPreferencesDto

  SettingsRepositoryImpl(this._isar);

  // ==========================================================================
  // Electrical Standard Settings (existing)
  // ==========================================================================

  @override
  Future<Either<Failure, String>> getDefaultElectricalStandard() async {
    try {
      final settings = await _isar.appSettingsModels.get(_settingsId);
      // Default to 'rebt_spain' if not set
      return Right(settings?.defaultElectricalStandardId ?? 'rebt_spain');
    } catch (e) {
      return const Right('rebt_spain'); // Fallback safe
    }
  }

  @override
  Future<Either<Failure, void>> setDefaultElectricalStandard(String id) async {
    try {
      await _isar.writeTxn(() async {
        final existing = await _isar.appSettingsModels.get(_settingsId);
        final settings = existing ?? AppSettingsModel()
          ..id = _settingsId;

        settings.defaultElectricalStandardId = id;
        await _isar.appSettingsModels.put(settings);
      });
      return const Right(null);
    } catch (e) {
      return Left(
          CacheFailure("Failed to set default electrical standard: $e"));
    }
  }

  // ==========================================================================
  // App Preferences (new - using AppPreferencesDto)
  // ==========================================================================

  @override
  Future<Either<Failure, AppPreferences>> getAppPreferences() async {
    try {
      final prefsDto = await _isar.appPreferencesDtos.get(_prefsId);

      if (prefsDto == null) {
        // Fallback to legacy AppSettingsModel if exists (Migration)
        final legacySettings = await _isar.appSettingsModels.get(_settingsId);
        if (legacySettings != null) {
          return Right(legacySettings.toAppPreferences());
        }
        // Return default preferences if none exist
        return Right(AppPreferences.defaults());
      }

      return Right(prefsDto.toDomain());
    } catch (e) {
      return Left(CacheFailure("Failed to get app preferences: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> saveAppPreferences(AppPreferences prefs) async {
    try {
      await _isar.writeTxn(() async {
        final existing = await _isar.appPreferencesDtos.get(_prefsId);
        // We re-use logic from "fromOnboardingPreferences" but adapting for update
        // Since we don't have a direct "fromAppPreferences", we map manually or use a helper
        // But AppPreferencesDto is derived from OnboardingPreferences in prompt.
        // Let's manually map here to be safe and thorough.

        final dto = existing ?? AppPreferencesDto()
          ..id = _prefsId;

        dto.locale = prefs.locale;
        dto.themeMode = prefs.themeMode.name;
        dto.textSize = prefs.textSize.name;
        dto.notificationsEnabled = prefs.notificationsEnabled;
        dto.highContrastEnabled = prefs.highContrastEnabled;

        await _isar.appPreferencesDtos.put(dto);
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to save app preferences: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> setLocale(String locale) async {
    try {
      await _isar.writeTxn(() async {
        final existing = await _isar.appPreferencesDtos.get(_prefsId);
        final dto = existing ?? (await _paramsFromDefaults());
        dto.locale = locale;
        await _isar.appPreferencesDtos.put(dto);
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to set locale: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> setTextSize(TextSizePreference size) async {
    try {
      await _isar.writeTxn(() async {
        final existing = await _isar.appPreferencesDtos.get(_prefsId);
        final dto = existing ?? (await _paramsFromDefaults());
        dto.textSize = size.name;
        await _isar.appPreferencesDtos.put(dto);
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to set text size: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> setThemeMode(AppThemeMode mode) async {
    try {
      await _isar.writeTxn(() async {
        final existing = await _isar.appPreferencesDtos.get(_prefsId);
        final dto = existing ?? (await _paramsFromDefaults());
        dto.themeMode = mode.name;
        await _isar.appPreferencesDtos.put(dto);
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to set theme mode: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> saveOnboardingDataTransaction({
    required UserProfile profile,
    required OnboardingPreferences preferences,
  }) async {
    try {
      // Single atomic transaction for BOTH entities
      await _isar.writeTxn(() async {
        // 1. Save UserProfile as DTO
        final profileDto = UserProfileModel.fromEntity(profile)
          ..id = 1; // Enforcing singleton ID for the primary user
        await _isar.userProfileModels.put(profileDto);

        // 2. Save OnboardingPreferences -> AppPreferences as DTO
        final prefsDto =
            AppPreferencesDto.fromOnboardingPreferences(preferences)
              ..id = _prefsId; // Ensure singleton ID
        await _isar.appPreferencesDtos.put(prefsDto);

        // 3. Mark onboarding as complete
        final onboardingStatus = OnboardingStatusDto()
          ..id = 0
          ..isComplete = true
          ..completedAt = DateTime.now();
        await _isar.onboardingStatusDtos.put(onboardingStatus);
      });

      return const Right(null);
    } on IsarError catch (e) {
      // Transaction auto-rolls back on ANY error
      return Left(CacheFailure('Transaction failed: ${e.message}'));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // Helper to create defaults if missing
  Future<AppPreferencesDto> _paramsFromDefaults() async {
    final defaults = AppPreferences.defaults();
    return AppPreferencesDto()
      ..id = _prefsId
      ..locale = defaults.locale
      ..themeMode = defaults.themeMode.name
      ..textSize = defaults.textSize.name
      ..notificationsEnabled = defaults.notificationsEnabled
      ..highContrastEnabled = defaults.highContrastEnabled;
  }
}
