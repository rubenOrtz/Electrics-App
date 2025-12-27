import 'package:flutter/material.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/entities/project.dart';
import '../../../../injection_container.dart';
import '../bloc/project_cubit.dart';
import '../../../settings/presentation/bloc/settings_cubit.dart';
import 'package:electrician_app/core/presentation/widgets/coming_soon_dialog.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // cardColor removed as it's now handled by dynamic theme properties directly or via container decoration

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.projectsTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final defaultStd =
                  context.read<SettingsCubit>().state.defaultStandardId;
              context
                  .read<ProjectCubit>()
                  .createNewProject(defaultStandard: defaultStd);
              Navigator.pushNamed(context, '/projects/config');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchPlaceholder,
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.tune, color: theme.colorScheme.primary),
                    onPressed: () {},
                  ),
                ),
              ),
            ),

            // Filters (Horizontal Scroll)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildFilterChip(
                      AppLocalizations.of(context)!.filterAll, true, theme),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                      AppLocalizations.of(context)!.filterDesign, false, theme),
                  const SizedBox(width: 12),
                  _buildFilterChip(AppLocalizations.of(context)!.filterPending,
                      false, theme),
                  const SizedBox(width: 12),
                  _buildFilterChip(AppLocalizations.of(context)!.filterFinished,
                      false, theme),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Project List
            Expanded(
              child: StreamBuilder<List<Project>>(
                stream: sl<ProjectRepository>().getProjectsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final projects = snapshot.data ?? [];

                  if (projects.isEmpty) {
                    return Center(
                      child: Text(
                          "No hay proyectos creados. \nPulsa + para crear uno.",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.5),
                          )),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: projects.length + 1, // +1 for spacer
                    itemBuilder: (context, index) {
                      if (index == projects.length) {
                        return const SizedBox(height: 80);
                      }
                      final project = projects[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildProjectCard(
                          context,
                          project: project,
                          title: project.name,
                          subtitle: project.reference ?? "Sin referencia",
                          status: "En Diseño",
                          statusColor:
                              theme.colorScheme.primary, // Dynamic color
                          time: _formatDate(project.updatedAt),
                          client: project.client ?? "Cliente",
                          icon: Icons.storefront,
                          iconColor: theme.colorScheme.primary,
                          iconBg: theme.colorScheme.primaryContainer,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [
                BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ]
            : [],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
    required String time,
    required String client,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Project project,
    double opacity = 1.0,
  }) {
    final theme = Theme.of(context);
    final cardColor = theme.colorScheme.surface;

    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1))
          ],
        ),
        child: InkWell(
          onTap: () {
            // Direct navigation to Diagram
            context.read<ProjectCubit>().setProject(project);
            Navigator.pushNamed(
              context,
              '/diagram/single-line',
              arguments: project.id,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: iconColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert,
                          color: theme.colorScheme.onSurfaceVariant),
                      onPressed: () => _showProjectOptions(context, project),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(height: 1, color: theme.dividerColor),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: statusColor.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(time, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showProjectOptions(BuildContext context, Project project) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Set Active Project
    context.read<ProjectCubit>().setProject(project);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(project.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Divider(height: 1, color: theme.dividerColor),
              ListTile(
                leading: Icon(Icons.settings,
                    color: theme.textTheme.bodyMedium?.color
                        ?.withValues(alpha: 0.7)),
                title: Text(l10n.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/projects/config');
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_on, color: Colors.indigo),
                title: const Text('Diseño Esquema'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/diagram/single-line',
                    arguments: project.id,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.description, color: Colors.blueGrey),
                title: const Text('Documentación (PDF)'),
                onTap: () {
                  Navigator.pop(context);
                  // "Coming Soon" popup
                  showComingSoon(context, featureName: 'Documentación (PDF)');
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Eliminar Proyecto',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, project);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Project project) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Proyecto'),
        content: Text(
            '¿Estás seguro de que quieres eliminar "${project.name}"? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              if (project.id != null) {
                final result =
                    await sl<ProjectRepository>().deleteProject(project.id!);
                if (!context.mounted) return;
                result.fold(
                  (failure) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.errorDeletingProject),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.projectDeletedSuccess),
                      backgroundColor: Colors.green,
                    ),
                  ),
                );
              }
            },
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
