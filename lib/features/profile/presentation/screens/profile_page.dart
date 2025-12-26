import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/theme_cubit.dart';
import 'package:electrician_app/features/settings/domain/entities/app_theme_mode.dart';
import '../../../../features/settings/presentation/bloc/user_profile_cubit.dart';
import '../../../../features/settings/domain/entities/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _tensionPreferida = true;
  bool _faceId = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    // Use surface color for cards
    final cardColor = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = state.profile;
          if (profile == null) {
            // Fallback if no profile loaded (rare given the logic)
            return const Center(child: Text('Error al cargar el perfil'));
          }

          final isCompany =
              profile.professionalType == ProfessionalType.company;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Avatar
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: kPrimaryColor, width: 2),
                    ),
                    child: const Icon(Icons.person,
                        size: 60, color: kPrimaryColor),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  profile.personalName.isNotEmpty
                      ? profile.personalName
                      : 'Usuario',
                  style: theme.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  isCompany
                      ? (profile.companyName ?? 'Empresa')
                      : 'Ingeniero Autónomo',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),

                // Theme Selector
                _buildSectionHeader(context, "Apariencia"),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, themeState) {
                      return Column(
                        children: [
                          _buildThemeOption(context, "Claro",
                              AppThemeMode.light, themeState.mode),
                          const Divider(),
                          _buildThemeOption(context, "Oscuro",
                              AppThemeMode.dark, themeState.mode),
                          if (themeState.isDynamicColorAvailable) ...[
                            const Divider(),
                            _buildThemeOption(
                                context,
                                "Dinámico (Material You)",
                                AppThemeMode.dynamic,
                                themeState.mode),
                          ],
                          const Divider(),
                          _buildThemeOption(context, "Alto Contraste Claro",
                              AppThemeMode.highContrastLight, themeState.mode),
                          const Divider(),
                          _buildThemeOption(context, "Alto Contraste Oscuro",
                              AppThemeMode.highContrastDark, themeState.mode),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Professional Data
                _buildSectionHeader(
                    context, AppLocalizations.of(context)!.professionalData),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Column(
                    children: [
                      _buildProfileItem(context, Icons.badge_outlined,
                          l10n.nifCif, profile.personalDni),
                      const Divider(),
                      _buildProfileItem(context, Icons.engineering_outlined,
                          l10n.category, l10n.specialistInstaller),
                      const Divider(),
                      _buildProfileItem(context, Icons.numbers,
                          'Nº Registro Ind.', profile.engineerId),
                      if (isCompany && profile.companyCif != null) ...[
                        const Divider(),
                        _buildProfileItem(context, Icons.business,
                            'CIF Empresa', profile.companyCif!),
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Contact
                _buildSectionHeader(
                    context, AppLocalizations.of(context)!.contact),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Column(
                    children: [
                      _buildProfileItem(
                          context,
                          Icons.mail_outline,
                          AppLocalizations.of(context)!.corporateEmail,
                          profile.personalEmail),
                      const Divider(),
                      _buildProfileItem(
                          context,
                          Icons.phone_android,
                          AppLocalizations.of(context)!.mobilePhone,
                          profile.personalPhone),
                      if (isCompany && profile.companyAddress != null) ...[
                        const Divider(),
                        _buildProfileItem(context, Icons.location_on_outlined,
                            'Dirección', profile.companyAddress!),
                      ]
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Technical Config
                _buildSectionHeader(
                    context, AppLocalizations.of(context)!.technicalConfig),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Column(
                    children: [
                      _buildSettingItem(context, l10n.defaultRegulation,
                          l10n.regulationDesc, 'REBT 2002',
                          isValue: true),
                      const Divider(height: 1),
                      _buildSettingItem(context, 'Tensión Preferida',
                          'Sistema monofásico/trifásico', '',
                          isSwitch: true,
                          switchValue: _tensionPreferida,
                          onChanged: (val) =>
                              setState(() => _tensionPreferida = val)),
                      const Divider(height: 1),
                      _buildSettingItem(context, 'Face ID / Biometría',
                          l10n.quickSecureAccess, '',
                          isSwitch: true,
                          switchValue: _faceId,
                          onChanged: (val) => setState(() => _faceId = val)),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Logout
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(AppLocalizations.of(context)!.logout,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String title,
      AppThemeMode mode, AppThemeMode currentMode) {
    final isSelected = mode == currentMode;
    return InkWell(
      onTap: () {
        context.read<ThemeCubit>().setTheme(mode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal)),
            if (isSelected) const Icon(Icons.check_circle, color: kPrimaryColor)
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon,
            color: Theme.of(context).textTheme.bodyMedium?.color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
      BuildContext context, String title, String subtitle, String value,
      {bool isValue = false,
      bool isSwitch = false,
      bool switchValue = false,
      Function(bool)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (isValue)
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kPrimaryColor)),
          if (isSwitch)
            Switch(
              value: switchValue,
              onChanged: onChanged,
              activeThumbColor: kPrimaryColor,
            ),
        ],
      ),
    );
  }
}
