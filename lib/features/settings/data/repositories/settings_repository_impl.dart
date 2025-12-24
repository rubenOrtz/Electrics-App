import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../../../../core/error/failures.dart';
import '../../../../config/theme/theme_cubit.dart';
import '../../data/models/app_settings_model.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Isar _isar;
  static const int _settingsId = 1;

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
  // App Preferences (new)
  // ==========================================================================

  @override
  Future<Either<Failure, AppPreferences>> getAppPreferences() async {
    try {
      final settings = await _isar.appSettingsModels.get(_settingsId);

      if (settings == null) {
        // Return default preferences if none exist
        return Right(AppPreferences.defaults());
      }

      return Right(settings.toAppPreferences());
    } catch (e) {
      return Left(CacheFailure("Failed to get app preferences: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> saveAppPreferences(AppPreferences prefs) async {
    try {
      await _isar.writeTxn(() async {
        final existing = await _isar.appSettingsModels.get(_settingsId);
        final settings = existing ?? AppSettingsModel()
          ..id = _settingsId;

        settings.updateFromAppPreferences(prefs);
        await _isar.appSettingsModels.put(settings);
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
        final existing = await _isar.appSettingsModels.get(_settingsId);
        final settings = existing ?? AppSettingsModel()
          ..id = _settingsId;

        settings.locale = locale;
        await _isar.appSettingsModels.put(settings);
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
        final existing = await _isar.appSettingsModels.get(_settingsId);
        final settings = existing ?? AppSettingsModel()
          ..id = _settingsId;

        settings.textSize = size;
        await _isar.appSettingsModels.put(settings);
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
        final existing = await _isar.appSettingsModels.get(_settingsId);
        final settings = existing ?? AppSettingsModel()
          ..id = _settingsId;

        settings.themeMode = mode;
        await _isar.appSettingsModels.put(settings);
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to set theme mode: $e"));
    }
  }
}
