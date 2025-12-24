import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/theme_cubit.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsState extends Equatable {
  // Electrical settings (existing)
  final String defaultStandardId;

  // App preferences
  final String locale;
  final TextSizePreference textSize;
  final AppThemeMode themeMode;
  final bool notificationsEnabled;
  final bool highContrastEnabled;

  final bool isLoading;

  const SettingsState({
    this.defaultStandardId = 'rebt_spain',
    this.locale = 'es',
    this.textSize = TextSizePreference.medium,
    this.themeMode = AppThemeMode.dark,
    this.notificationsEnabled = true,
    this.highContrastEnabled = false,
    this.isLoading = false,
  });

  SettingsState copyWith({
    String? defaultStandardId,
    String? locale,
    TextSizePreference? textSize,
    AppThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? highContrastEnabled,
    bool? isLoading,
  }) {
    return SettingsState(
      defaultStandardId: defaultStandardId ?? this.defaultStandardId,
      locale: locale ?? this.locale,
      textSize: textSize ?? this.textSize,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      highContrastEnabled: highContrastEnabled ?? this.highContrastEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  AppPreferences toAppPreferences() {
    return AppPreferences(
      locale: locale,
      textSize: textSize,
      themeMode: themeMode,
      notificationsEnabled: notificationsEnabled,
      highContrastEnabled: highContrastEnabled,
    );
  }

  @override
  List<Object> get props => [
        defaultStandardId,
        locale,
        textSize,
        themeMode,
        notificationsEnabled,
        highContrastEnabled,
        isLoading,
      ];
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;
  final ThemeCubit? _themeCubit;

  SettingsCubit(this._repository, {ThemeCubit? themeCubit})
      : _themeCubit = themeCubit,
        super(const SettingsState());

  /// Loads all settings from repository
  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true));

    // Load electrical standard
    final standardResult = await _repository.getDefaultElectricalStandard();
    String standardId = 'rebt_spain';
    standardResult.fold(
      (failure) => null,
      (id) => standardId = id,
    );

    // Load app preferences
    final prefsResult = await _repository.getAppPreferences();
    final prefs = prefsResult.getOrElse(() => AppPreferences.defaults());

    emit(state.copyWith(
      defaultStandardId: standardId,
      locale: prefs.locale,
      textSize: prefs.textSize,
      themeMode: prefs.themeMode,
      notificationsEnabled: prefs.notificationsEnabled,
      highContrastEnabled: prefs.highContrastEnabled,
      isLoading: false,
    ));

    // Sync theme with ThemeCubit
    _themeCubit?.setTheme(state.themeMode);
  }

  /// Updates the default electrical standard
  Future<void> updateDefaultStandard(String id) async {
    // Optimistic update
    final old = state.defaultStandardId;
    emit(state.copyWith(defaultStandardId: id));

    final result = await _repository.setDefaultElectricalStandard(id);
    result.fold(
      (failure) => emit(state.copyWith(defaultStandardId: old)),
      (_) {}, // Success
    );
  }

  /// Changes the app locale (language)
  Future<void> setLocale(String locale) async {
    final old = state.locale;
    emit(state.copyWith(locale: locale));

    final result = await _repository.setLocale(locale);
    result.fold(
      (failure) => emit(state.copyWith(locale: old)),
      (_) async {
        // Also save to full preferences
        await _repository.saveAppPreferences(state.toAppPreferences());
      },
    );
  }

  /// Changes the text size preference
  Future<void> setTextSize(TextSizePreference size) async {
    final old = state.textSize;
    emit(state.copyWith(textSize: size));

    final result = await _repository.setTextSize(size);
    result.fold(
      (failure) => emit(state.copyWith(textSize: old)),
      (_) async {
        // Also save to full preferences
        await _repository.saveAppPreferences(state.toAppPreferences());
      },
    );
  }

  /// Changes the theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    final old = state.themeMode;
    emit(state.copyWith(themeMode: mode));

    // Update ThemeCubit immediately
    _themeCubit?.setTheme(mode);

    final result = await _repository.setThemeMode(mode);
    result.fold(
      (failure) {
        emit(state.copyWith(themeMode: old));
        _themeCubit?.setTheme(old);
      },
      (_) async {
        // Also save to full preferences
        await _repository.saveAppPreferences(state.toAppPreferences());
      },
    );
  }

  /// Toggles notifications (for future use)
  void toggleNotifications(bool enabled) {
    emit(state.copyWith(notificationsEnabled: enabled));
    _repository.saveAppPreferences(state.toAppPreferences());
  }

  /// Toggles high contrast (for future use)
  void toggleHighContrast(bool enabled) {
    emit(state.copyWith(highContrastEnabled: enabled));
    _repository.saveAppPreferences(state.toAppPreferences());
  }
}
