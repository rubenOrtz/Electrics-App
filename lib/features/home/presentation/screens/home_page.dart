import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import '../../../settings/presentation/bloc/user_profile_cubit.dart';
import '../../../../core/presentation/widgets/coming_soon_dialog.dart';
import '../../../../core/presentation/widgets/beta_feature_banner.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavigateToTab;

  const HomePage({Key? key, this.onNavigateToTab}) : super(key: key);

  String _getGreeting(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.homeGreetingMorning;
    if (hour < 18) return l10n.homeGreetingAfternoon;
    return l10n.homeGreetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Beta warning banner
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: BetaFeatureBanner(),
              ),

              // Header with user info
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Avatar
                    BlocBuilder<UserProfileCubit, UserProfileState>(
                      builder: (context, state) {
                        return Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          child: state.profile?.personalPhotoBytes != null
                              ? ClipOval(
                                  child: Image.memory(
                                    Uint8List.fromList(
                                      state.profile!.personalPhotoBytes!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  color: theme.colorScheme.onPrimaryContainer,
                                  size: 28,
                                ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    // User name and greeting
                    Expanded(
                      child: BlocBuilder<UserProfileCubit, UserProfileState>(
                        builder: (context, state) {
                          final name =
                              state.profile?.personalName.isNotEmpty == true
                                  ? state.profile!.personalName.split(' ').first
                                  : 'INGENIERO';

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_getGreeting(context).toUpperCase()}, $name',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                AppLocalizations.of(context)!.controlPanel,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Notifications icon
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: theme.colorScheme.onSurface,
                      ),
                      onPressed:
                          () {}, // Notifications feature not yet implemented
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.searchPlaceholderFull,
                      hintStyle: TextStyle(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.qr_code_scanner,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                        onPressed:
                            () {}, // QR scanner feature not yet implemented
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onTap: () {}, // Search feature not yet implemented
                    readOnly: true,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Status badges
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildStatusBadge(
                      context,
                      icon: Icons.cloud_done_outlined,
                      text: AppLocalizations.of(context)!.synchronized,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    _buildStatusBadge(
                      context,
                      icon: Icons.warning_amber_rounded,
                      text: AppLocalizations.of(context)!.activeAlerts(2),
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Modules section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocalizations.of(context)!.modules,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Module cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildModuleCard(
                      context,
                      icon: Icons.folder_outlined,
                      title: 'Gestión de Proyectos',
                      subtitle: '3 Activos • Última: Nueva Industrial BCN',
                      color: theme.colorScheme.primary,
                      onTap: () {
                        // Navigate to projects tab (index 2)
                        if (onNavigateToTab != null) {
                          onNavigateToTab!(2);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildModuleCard(
                            context,
                            icon: Icons.calculate_outlined,
                            title: 'Cálculo y Diseño',
                            subtitle: 'BT/AT',
                            color: Colors.brown,
                            onTap: () {
                              // Navigate to calculations tab (index 1)
                              if (onNavigateToTab != null) {
                                onNavigateToTab!(1);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildModuleCard(
                            context,
                            icon: Icons.library_books_outlined,
                            title: 'Biblioteca Normativa',
                            subtitle: 'ITC/UNE',
                            color: Colors.purple,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const ComingSoonDialog(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildModuleCard(
                            context,
                            icon: Icons.construction_outlined,
                            title: 'Mantenimiento Predictivo',
                            subtitle: 'IoT',
                            color: Colors.teal,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const ComingSoonDialog(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildModuleCard(
                            context,
                            icon: Icons.inventory_2_outlined,
                            title: 'Biblioteca Componentes',
                            subtitle: 'Catálogo',
                            color: Colors.green,
                            onTap: () =>
                                Navigator.pushNamed(context, '/library'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? theme.colorScheme.surfaceContainerHighest
                : theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
