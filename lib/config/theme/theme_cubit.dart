import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_themes.dart';

import '../../features/settings/domain/entities/app_theme_mode.dart';

class ThemeState {
  final ThemeData themeData;
  final AppThemeMode mode;
  final ColorScheme? dynamicLightScheme;
  final ColorScheme? dynamicDarkScheme;
  final bool isDynamicColorAvailable;

  ThemeState(this.themeData, this.mode,
      {this.dynamicLightScheme,
      this.dynamicDarkScheme,
      this.isDynamicColorAvailable = false});
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(darkTheme(), AppThemeMode.dark));

  void updateDynamicColorAvailability(bool isAvailable,
      {ColorScheme? lightScheme, ColorScheme? darkScheme}) {
    if (state.mode == AppThemeMode.dynamic && isAvailable) {
      emit(ThemeState(
        darkScheme != null ? dynamicDarkTheme(darkScheme) : darkTheme(),
        AppThemeMode.dynamic,
        dynamicLightScheme: lightScheme,
        dynamicDarkScheme: darkScheme,
        isDynamicColorAvailable: isAvailable,
      ));
    } else {
      emit(ThemeState(
        state.themeData,
        state.mode,
        dynamicLightScheme: lightScheme,
        dynamicDarkScheme: darkScheme,
        isDynamicColorAvailable: isAvailable,
      ));
    }
  }

  void setTheme(AppThemeMode mode,
      {ColorScheme? lightScheme, ColorScheme? darkScheme}) {
    switch (mode) {
      case AppThemeMode.light:
        emit(ThemeState(theme(), AppThemeMode.light,
            dynamicLightScheme: state.dynamicLightScheme,
            dynamicDarkScheme: state.dynamicDarkScheme,
            isDynamicColorAvailable: state.isDynamicColorAvailable));
        break;
      case AppThemeMode.dark:
        emit(ThemeState(darkTheme(), AppThemeMode.dark,
            dynamicLightScheme: state.dynamicLightScheme,
            dynamicDarkScheme: state.dynamicDarkScheme,
            isDynamicColorAvailable: state.isDynamicColorAvailable));
        break;
      case AppThemeMode.highContrastLight:
        emit(ThemeState(
            highContrastLightTheme(), AppThemeMode.highContrastLight,
            dynamicLightScheme: state.dynamicLightScheme,
            dynamicDarkScheme: state.dynamicDarkScheme,
            isDynamicColorAvailable: state.isDynamicColorAvailable));
        break;
      case AppThemeMode.highContrastDark:
        emit(ThemeState(highContrastDarkTheme(), AppThemeMode.highContrastDark,
            dynamicLightScheme: state.dynamicLightScheme,
            dynamicDarkScheme: state.dynamicDarkScheme,
            isDynamicColorAvailable: state.isDynamicColorAvailable));
        break;
      case AppThemeMode.system:
        emit(ThemeState(theme(), AppThemeMode.system,
            dynamicLightScheme: state.dynamicLightScheme,
            dynamicDarkScheme: state.dynamicDarkScheme,
            isDynamicColorAvailable: state.isDynamicColorAvailable));
        break;
      case AppThemeMode.dynamic:
        final useLightScheme = state.dynamicLightScheme ?? lightScheme;
        final useDarkScheme = state.dynamicDarkScheme ?? darkScheme;

        final themeData = useLightScheme != null
            ? dynamicLightTheme(useLightScheme)
            : theme();

        emit(ThemeState(themeData, AppThemeMode.dynamic,
            dynamicLightScheme: useLightScheme,
            dynamicDarkScheme: useDarkScheme,
            isDynamicColorAvailable: state.isDynamicColorAvailable));
        break;
    }
  }

  void updateDynamicThemeFromBrightness(Brightness brightness) {
    if (state.mode != AppThemeMode.dynamic && state.mode != AppThemeMode.system)
      return;

    final themeData = brightness == Brightness.dark
        ? (state.mode == AppThemeMode.dynamic && state.dynamicDarkScheme != null
            ? dynamicDarkTheme(state.dynamicDarkScheme!)
            : darkTheme())
        : (state.mode == AppThemeMode.dynamic &&
                state.dynamicLightScheme != null
            ? dynamicLightTheme(state.dynamicLightScheme!)
            : theme());

    emit(ThemeState(themeData, state.mode,
        dynamicLightScheme: state.dynamicLightScheme,
        dynamicDarkScheme: state.dynamicDarkScheme,
        isDynamicColorAvailable: state.isDynamicColorAvailable));
  }

  void toggleTheme(bool isHighContrast) {
    if (isHighContrast) {
      setTheme(AppThemeMode.highContrastDark);
    } else {
      setTheme(AppThemeMode.light);
    }
  }
}
