import 'package:isar/isar.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../../../onboarding/domain/entities/onboarding_preferences.dart';

part 'app_preferences_dto.g.dart';

@collection
class AppPreferencesDto {
  Id id = 0;

  AppPreferencesDto();

  late String locale;
  late String themeMode;
  late String textSize;
  late bool notificationsEnabled;
  late bool highContrastEnabled;

  // Mapper FROM Domain OnboardingPreferences
  factory AppPreferencesDto.fromOnboardingPreferences(
      OnboardingPreferences prefs) {
    return AppPreferencesDto()
      ..locale = prefs.locale
      ..themeMode = prefs.themeMode.name
      ..textSize = prefs.textSize.name
      ..notificationsEnabled = prefs.notificationsEnabled
      ..highContrastEnabled = false;
  }

  // Mapper TO Domain AppPreferences
  AppPreferences toDomain() {
    return AppPreferences(
      locale: locale,
      themeMode: AppThemeMode.values.byName(themeMode),
      textSize: TextSizePreference.values.byName(textSize),
      notificationsEnabled: notificationsEnabled,
      highContrastEnabled: highContrastEnabled,
    );
  }
}
