import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/presentation/widgets/premium_list_tile.dart';
import '../../../../core/presentation/widgets/coming_soon_dialog.dart';
import '../../../../config/theme/theme_cubit.dart';
import '../../domain/entities/app_preferences.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/user_profile_cubit.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/edit_profile_sheet.dart';
import '../widgets/text_size_selector.dart';
import '../widgets/language_selector.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // Load settings and profile on page init
    context.read<SettingsCubit>().loadSettings();
    context.read<UserProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.configuration),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Ayuda",
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Profile Header Card
                ProfileHeaderCard(
                  onEditTap: () => EditProfileSheet.show(context),
                ),

                const SizedBox(height: 24),

                //2. GENERAL Section
                PremiumSectionHeader(title: l10n.settingsGeneral),
                PremiumListTile(
                  icon: Icons.language,
                  iconColor: Colors.blueAccent,
                  title: l10n.settingsLanguage,
                  subtitle: state.locale == 'es'
                      ? 'Español (España)'
                      : 'English (US)',
                  onTap: () => LanguageSelector.show(context),
                ),
                PremiumListTile(
                  icon: Icons.brightness_6,
                  iconColor: Colors.deepPurple,
                  title: l10n.theme,
                  subtitle: _getThemeLabel(l10n, state.themeMode),
                  onTap: () =>
                      _showThemeSelector(context, l10n, state.themeMode),
                ),
                PremiumListTile(
                  icon: Icons.notifications_active,
                  iconColor: Colors.redAccent,
                  title: l10n.notifications,
                  subtitle: l10n.notificationsDesc,
                  trailing: Switch(
                    value: false, // Always disabled
                    onChanged: (val) => showComingSoon(context,
                        featureName: l10n.notifications),
                    thumbColor: WidgetStateProperty.all(Colors.grey),
                  ),
                ),

                const SizedBox(height: 16),

                // 3. ACCESSIBILITY Section
                PremiumSectionHeader(title: 'ACCESIBILIDAD'),
                PremiumListTile(
                  icon: Icons.contrast,
                  iconColor: Colors.amber,
                  title: 'Alto Contraste',
                  subtitle: l10n.brightnessBoost,
                  trailing: Switch(
                    value: false, // Always disabled
                    onChanged: (val) =>
                        showComingSoon(context, featureName: 'Alto Contraste'),
                    thumbColor: WidgetStateProperty.all(Colors.grey),
                  ),
                ),
                PremiumListTile(
                  icon: Icons.text_fields,
                  iconColor: Colors.grey,
                  title: l10n.settingsTextSize,
                  subtitle: _getTextSizeLabel(l10n, state.textSize),
                  onTap: () => TextSizeSelector.show(context),
                ),

                const SizedBox(height: 16),

                // 4. SUPPORT Section
                PremiumSectionHeader(title: l10n.settingsSupport),
                PremiumListTile(
                  icon: Icons.help_outline,
                  iconColor: Colors.cyan,
                  title: l10n.settingsHelp,
                  trailing:
                      Icon(Icons.open_in_new, size: 20, color: Colors.grey),
                  showChevron: false,
                  onTap: () =>
                      showComingSoon(context, featureName: l10n.settingsHelp),
                ),
                PremiumListTile(
                  icon: Icons.bug_report,
                  iconColor: Colors.orange,
                  title: l10n.settingsReport,
                  onTap: () =>
                      showComingSoon(context, featureName: l10n.settingsReport),
                ),

                const SizedBox(height: 32),

                // 5. Version info
                Center(
                  child: Text(
                    "Versión 2.4.1 (Build 2043)\n© 2025 ElectricianApp Pro",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getTextSizeLabel(AppLocalizations l10n, TextSizePreference size) {
    switch (size) {
      case TextSizePreference.small:
        return l10n.textSizeSmall;
      case TextSizePreference.medium:
        return l10n.textSizeMedium;
      case TextSizePreference.large:
        return l10n.textSizeLarge;
      case TextSizePreference.extraLarge:
        return 'Muy Grande';
    }
  }

  String _getThemeLabel(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return l10n.themeLight;
      case AppThemeMode.dark:
        return l10n.themeDark;
      case AppThemeMode.system:
        return 'Automático (Sistema)';
      case AppThemeMode.dynamic:
        return 'Dinámico (Material You)';
      default:
        return 'Automático (Sistema)';
    }
  }

  void _showThemeSelector(
      BuildContext context, AppLocalizations l10n, AppThemeMode currentMode) {
    final theme = Theme.of(context);
    final themeCubit = context.read<ThemeCubit>();
    final isDynamicAvailable = themeCubit.state.isDynamicColorAvailable;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.cardColor,
        title: Text('Seleccionar Tema',
            style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(ctx, l10n.themeLight, Icons.light_mode,
                AppThemeMode.light, currentMode, theme),
            const SizedBox(height: 8),
            _buildThemeOption(ctx, l10n.themeDark, Icons.dark_mode,
                AppThemeMode.dark, currentMode, theme),
            const SizedBox(height: 8),
            _buildThemeOption(ctx, l10n.themeAuto, Icons.brightness_auto,
                AppThemeMode.system, currentMode, theme),
            if (isDynamicAvailable || currentMode == AppThemeMode.dynamic) ...[
              const SizedBox(height: 8),
              _buildThemeOption(ctx, 'Dinámico (Material You)', Icons.palette,
                  AppThemeMode.dynamic, currentMode, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext ctx,
    String label,
    IconData icon,
    AppThemeMode mode,
    AppThemeMode currentMode,
    ThemeData theme,
  ) {
    final isSelected = mode == currentMode;

    return InkWell(
      onTap: () {
        context.read<SettingsCubit>().setThemeMode(mode);
        Navigator.of(ctx).pop();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.primaryColor : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.primaryColor
                  : theme.textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? theme.primaryColor
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: theme.primaryColor, size: 20),
          ],
        ),
      ),
    );
  }
}
