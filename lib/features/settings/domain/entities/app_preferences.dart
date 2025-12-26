import 'app_theme_mode.dart';

/// Enum representing text size preference
enum TextSizePreference {
  small,
  medium,
  large,
  extraLarge,
}

/// Extension to convert TextSizePreference to text scale factor
extension TextSizeScale on TextSizePreference {
  double get scaleFactor {
    switch (this) {
      case TextSizePreference.small:
        return 0.85;
      case TextSizePreference.medium:
        return 1.0;
      case TextSizePreference.large:
        return 1.15;
      case TextSizePreference.extraLarge:
        return 1.3;
    }
  }

  String get displayName {
    switch (this) {
      case TextSizePreference.small:
        return 'Pequeño';
      case TextSizePreference.medium:
        return 'Mediano';
      case TextSizePreference.large:
        return 'Grande';
      case TextSizePreference.extraLarge:
        return 'Muy Grande';
    }
  }
}

/// Domain entity representing app-wide preferences
class AppPreferences {
  /// Current locale (language) setting ('es' or 'en')
  final String locale;

  /// Text size preference for the entire app
  final TextSizePreference textSize;

  /// Theme mode (light, dark, high contrast, etc.)
  final AppThemeMode themeMode;

  /// Whether notifications are enabled (for future use)
  final bool notificationsEnabled;

  /// Whether high contrast mode is enabled (for future use)
  final bool highContrastEnabled;

  const AppPreferences({
    required this.locale,
    required this.textSize,
    required this.themeMode,
    required this.notificationsEnabled,
    required this.highContrastEnabled,
  });

  /// Default preferences
  factory AppPreferences.defaults() {
    return const AppPreferences(
      locale: 'es',
      textSize: TextSizePreference.medium,
      themeMode: AppThemeMode.dark,
      notificationsEnabled: true,
      highContrastEnabled: false,
    );
  }

  AppPreferences copyWith({
    String? locale,
    TextSizePreference? textSize,
    AppThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? highContrastEnabled,
  }) {
    return AppPreferences(
      locale: locale ?? this.locale,
      textSize: textSize ?? this.textSize,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      highContrastEnabled: highContrastEnabled ?? this.highContrastEnabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppPreferences &&
        other.locale == locale &&
        other.textSize == textSize &&
        other.themeMode == themeMode &&
        other.notificationsEnabled == notificationsEnabled &&
        other.highContrastEnabled == highContrastEnabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      locale,
      textSize,
      themeMode,
      notificationsEnabled,
      highContrastEnabled,
    );
  }
}
