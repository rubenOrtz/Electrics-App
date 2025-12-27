import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/health_bloc.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/installation_health.dart';
import '../../domain/entities/field_measurement.dart';
import '../../../diagram/presentation/screens/single_line_diagram_page.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../widgets/manual_entry_form.dart';
import '../widgets/component_detail_sheet.dart';
import '../../../diagram/presentation/bloc/diagram_cubit.dart';
import '../../../../config/theme/app_themes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../projects/presentation/bloc/project_cubit.dart';
import '../widgets/components_list_sheet.dart';
import 'package:electrician_app/core/presentation/widgets/coming_soon_dialog.dart';

class HealthDashboardPage extends StatelessWidget {
  final String projectId;
  final String title;

  const HealthDashboardPage(
      {super.key, required this.projectId, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthBloc, HealthState>(
      builder: (context, state) {
        if (state is HealthLoading) {
          return _buildLoadingState(context);
        }

        if (state is HealthLoaded) {
          return _buildDashboard(context, state);
        }

        return _buildEmptyState(context);
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No hay datos de salud disponibles',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, HealthLoaded state) {
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;

    // Use DiagramTheme for background consistent with Diagram Page
    final bgApp = diagramTheme.canvasBg;
    final bgCard = diagramTheme.nodeBg;
    final accentBlue = diagramTheme.accentColor;
    final textPrimary = diagramTheme.textColor;
    final textSecondary = diagramTheme.textColor.withValues(alpha: 0.7);
    final borderColor = diagramTheme.nodeBorder;

    final l10n = AppLocalizations.of(context)!;
    final projectNameState =
        context.select((ProjectCubit p) => p.state.projectName);
    final projectName =
        projectNameState.isEmpty ? l10n.projectElectric : projectNameState;

    final projectRef = context.select((ProjectCubit p) => p.state.reference);
    final subtitle =
        (projectRef?.isNotEmpty == true) ? projectRef! : l10n.fieldMeasurements;

    final health = state.health;
    final score = health.score.toDouble();
    final criticalErrors = health.criticalCount;
    final warnings = health.warningCount;

    return Container(
      color: bgApp,
      child: CustomScrollView(
        slivers: [
          // Active Inspection Card (at top, no header)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor.withValues(alpha: 0.5)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: accentBlue.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.radio_button_checked,
                                    color: accentBlue, size: 14),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    l10n.analyzingActively.toUpperCase(),
                                    style: TextStyle(
                                      color: accentBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            projectName,
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: textPrimary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: borderColor.withValues(alpha: 0.5)),
                      ),
                      child: Icon(Icons.account_tree_outlined,
                          color: textPrimary.withValues(alpha: 0.4), size: 36),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Action Buttons
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      label: l10n.scanEquipment,
                      icon: Icons.qr_code_scanner,
                      isPrimary: true,
                      onTap: () {
                        showComingSoon(context,
                            featureName: l10n.scanEquipment);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      label: l10n.manualEntry,
                      icon: Icons.edit_note,
                      isPrimary: false,
                      onTap: () => _openManualEntry(context),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Security and Compliance Status
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.complianceStatus,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildStatusCard(
                            context: context,
                            title: l10n.security.toUpperCase(),
                            value: health.securityLevel.name.toUpperCase(),
                            subtitle: l10n.protectionsOk,
                            icon: Icons.shield_outlined,
                            color: _getSecurityColor(health.securityLevel),
                            bgCard: bgCard,
                            textPrimary: textPrimary,
                            textSecondary: textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatusCard(
                            context: context,
                            title: l10n.regulationsRebt.toUpperCase(),
                            value:
                                '${warnings + criticalErrors} ${l10n.warnings}',
                            subtitle: l10n.reviewSections,
                            icon: Icons.warning_amber_outlined,
                            color: criticalErrors > 0
                                ? Colors.redAccent
                                : Colors.amberAccent,
                            bgCard: bgCard,
                            textPrimary: textPrimary,
                            textSecondary: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Installation Health Score
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: _buildHealthScoreCard(
                  context,
                  l10n.healthScore,
                  '${score.toInt()}',
                  _getScoreColor(score),
                  bgCard,
                  textPrimary,
                  textSecondary,
                  state.components.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 28)),

          // Component Status
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.components,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showComponentsList(context, state),
                    child: Text(
                      l10n.viewAll.toUpperCase(),
                      style: TextStyle(
                        color: accentBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 170, // Increased from 130 to support large text
              child: state.components.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noComponentsInDiagram,
                        style: TextStyle(color: textSecondary),
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.components.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final component = state.components[index];
                        final measurements =
                            state.measurements[component.id] ?? [];

                        return _buildComponentCard(
                          component: component,
                          measurements: measurements,
                          bgCard: bgCard,
                          textPrimary: textPrimary,
                          textSecondary: textSecondary,
                          onTap: () => _showComponentDetail(
                            context,
                            component,
                            measurements,
                          ),
                        );
                      },
                    ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 28)),

          // Results and Advice Section Header
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.resultsAndTips,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showComingSoon(context, featureName: l10n.exportReport);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.download, color: accentBlue, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          l10n.exportReport,
                          style: TextStyle(
                            color: accentBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          // Insights List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final insight = state.insights[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _buildInsightCard(
                        context, insight, bgCard, textPrimary),
                  );
                },
                childCount: state.insights.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

// Method _buildQuickAction removed as it is replaced by _buildActionButton

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary ? diagramTheme.accentColor : diagramTheme.nodeBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPrimary
                ? Colors.transparent
                : diagramTheme.accentColor.withValues(alpha: 0.5),
            width: isPrimary ? 0 : 2,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: diagramTheme.accentColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : diagramTheme.textColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isPrimary ? Colors.white : diagramTheme.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgCard,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context)
              .extension<DiagramTheme>()!
              .nodeBorder
              .withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScoreCard(BuildContext context, String title, String value,
      Color color, Color bgCard, Color textPrimary, Color textSecondary,
      [int componentCount = 0]) {
    final percentage = (double.tryParse(value) ?? 0) / 100;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context)
              .extension<DiagramTheme>()!
              .nodeBorder
              .withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.calculatedOnComponents(componentCount),
            style: TextStyle(
              color: textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 8,
                    backgroundColor: textPrimary.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                '$value/100',
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
      BuildContext context, Insight insight, Color bgCard, Color textPrimary) {
    final color = _getInsightColor(insight.type);
    final iconData = _getInsightIcon(insight.type);
    final badge = _getInsightBadge(insight.type);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context)
                .extension<DiagramTheme>()!
                .nodeBorder
                .withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(iconData, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            insight.title,
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      insight.node.id.substring(0, 8),
                      style: TextStyle(
                        color: textPrimary.withValues(alpha: 0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            insight.description,
            style: TextStyle(
              color: textPrimary.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.arrow_forward, color: color, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  insight.suggestion,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSecurityColor(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.critical:
        return Colors.redAccent;
      case SecurityLevel.low:
        return Colors.orangeAccent;
      case SecurityLevel.medium:
        return Colors.amberAccent;
      case SecurityLevel.high:
        return Colors.lightGreenAccent;
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return Colors.greenAccent;
    if (score >= 75) return Colors.lightGreenAccent;
    if (score >= 50) return Colors.amberAccent;
    if (score >= 25) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  Color _getInsightColor(InsightType type) {
    switch (type) {
      case InsightType.critical:
        return Colors.redAccent;
      case InsightType.warning:
        return Colors.orangeAccent;
      case InsightType.success:
        return Colors.greenAccent;
      case InsightType.info:
        return Colors.blueAccent;
    }
  }

  IconData _getInsightIcon(InsightType type) {
    switch (type) {
      case InsightType.critical:
        return Icons.dangerous_outlined;
      case InsightType.warning:
        return Icons.construction_outlined;
      case InsightType.success:
        return Icons.check_circle_outline;
      case InsightType.info:
        return Icons.info_outline;
    }
  }

  String _getInsightBadge(InsightType type) {
    switch (type) {
      case InsightType.critical:
        return 'CRÍTICO';
      case InsightType.warning:
        return 'NORMATIVA';
      case InsightType.success:
        return 'CORRECTO';
      case InsightType.info:
        return 'INFO';
    }
  }

  void _openManualEntry(BuildContext context) {
    final diagramCubit = context.read<DiagramCubit>();
    final currentRoot = diagramCubit.state.root;

    if (currentRoot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay diagrama activo')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SingleLineDiagramPage(
          projectId: projectId,
          title: title,
          selectMode: SelectMode.measurement,
          onNodeSelected: (selectedNode) {
            Navigator.of(context).pop();
            _showManualEntryForm(context, selectedNode);
          },
        ),
      ),
    );
  }

  void _showManualEntryForm(BuildContext context, dynamic selectedNode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => ManualEntryForm(
          node: selectedNode,
          onSave: (measurement) {
            context.read<HealthBloc>().add(
                  AddFieldMeasurement(selectedNode.id, measurement),
                );
          },
        ),
      ),
    );
  }

  void _showComponentsList(BuildContext context, HealthLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ComponentsListSheet(
        components: state.components,
        measurements: state.measurements,
        onComponentTap: (component, measurements) {
          Navigator.pop(context);
          _showComponentDetail(context, component, measurements);
        },
      ),
    );
  }

  Widget _buildComponentCard({
    required ElectricalNode component,
    required List<FieldMeasurement> measurements,
    required Color bgCard,
    required Color textPrimary,
    required Color textSecondary,
    required VoidCallback onTap,
  }) {
// Determinar icono según tipo
    final icon = component.map(
      source: (_) => Icons.power,
      panel: (_) => Icons.dashboard,
      protection: (_) => Icons.shield,
      load: (_) => Icons.lightbulb,
    );

// Determinar subtítulo según tipo
    final subtitle = component.map(
      source: (_) => 'Acometida',
      panel: (_) => 'Cuadro',
      protection: (p) => p.protectionType.name,
      load: (_) => 'Circuito',
    );

// Determinar estado basado en mediciones
    final hasMeasurements = measurements.isNotEmpty;
    final status = hasMeasurements
        ? '${measurements.length} mediciones'
        : 'Sin mediciones';
    final statusColor = hasMeasurements ? Colors.green : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: textPrimary.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
                ),
                const Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              component.name,
              style: TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2, // Allow 2 lines
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: textSecondary,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showComponentDetail(
    BuildContext context,
    ElectricalNode component,
    List<FieldMeasurement> measurements,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => ComponentDetailSheet(
          node: component,
          measurements: measurements,
        ),
      ),
    );
  }
}
