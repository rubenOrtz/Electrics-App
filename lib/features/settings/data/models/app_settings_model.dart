import 'package:isar/isar.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/entities/app_theme_mode.dart';

part 'app_settings_model.g.dart';

@collection
class AppSettingsModel {
  Id id = Isar.autoIncrement; // We will use ID 1 for global settings

  // ============================================================================
  // Electrical Settings (existing)
  // ============================================================================

  String? defaultElectricalStandardId;

  // ============================================================================
  // App Preferences (new)
  // ============================================================================

  /// Current locale (language) - 'es' or 'en'
  String locale = 'es'; // Default to Spanish

  /// Text size preference
  @Enumerated(EnumType.name)
  TextSizePreference textSize = TextSizePreference.medium;

  /// Theme mode
  @Enumerated(EnumType.name)
  AppThemeMode themeMode = AppThemeMode.dark;

  /// Notifications enabled (for future use)
  bool notificationsEnabled = true;

  /// High contrast enabled (for future use)
  bool highContrastEnabled = false;

  /// Converts this model to AppPreferences entity
  AppPreferences toAppPreferences() {
    return AppPreferences(
      locale: locale,
      textSize: textSize,
      themeMode: themeMode,
      notificationsEnabled: notificationsEnabled,
      highContrastEnabled: highContrastEnabled,
    );
  }

  /// Updates this model from AppPreferences entity
  void updateFromAppPreferences(AppPreferences prefs) {
    locale = prefs.locale;
    textSize = prefs.textSize;
    themeMode = prefs.themeMode;
    notificationsEnabled = prefs.notificationsEnabled;
    highContrastEnabled = prefs.highContrastEnabled;
  }
}
