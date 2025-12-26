import 'package:equatable/equatable.dart';
import 'package:electrician_app/features/settings/domain/entities/app_preferences.dart';
import 'package:electrician_app/features/settings/domain/entities/app_theme_mode.dart';

class OnboardingPreferences extends Equatable {
  final String locale;
  final AppThemeMode themeMode;
  final TextSizePreference textSize;
  final bool notificationsEnabled;

  const OnboardingPreferences({
    required this.locale,
    required this.themeMode,
    required this.textSize,
    required this.notificationsEnabled,
  });

  @override
  List<Object?> get props =>
      [locale, themeMode, textSize, notificationsEnabled];
}
