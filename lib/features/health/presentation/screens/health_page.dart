import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/health_score_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/manual_entry_form.dart';
import '../../domain/entities/installation_health.dart';
import '../../domain/entities/insight.dart';
import '../../../diagram/domain/entities/electrical_node.dart';

/// Dashboard principal de "Salud" que muestra el estado de la instalación
class HealthPage extends StatelessWidget {
  final ElectricalNode? root;
  final InstallationHealth? health;
  final List<Insight>? insights;

  const HealthPage({
    super.key,
    this.root,
    this.health,
    this.insights,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Mock data si no hay health calculated yet
    final displayHealth = health ??
        const InstallationHealth(
          score: 0,
          criticalCount: 0,
          warningCount: 0,
          verificationFailures: 0,
          securityLevel: SecurityLevel.medium,
          complianceStatus: ComplianceStatus.pass,
          lastCalculated: null,
        );

    final displayInsights = insights ?? [];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.maintenanceTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {}, // History Todo
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {}, // Settings Todo
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header con ubicación
              _buildHeader(context, theme, l10n),
              const SizedBox(height: 20),

              // Quick Actions Grid
              _buildQuickActions(context, theme, l10n),
              const SizedBox(height: 20),

              // Security & Compliance Badges
              _buildStatusBadges(displayHealth, theme, l10n),
              const SizedBox(height: 20),

              // Health Score Card
              HealthScoreCard(health: displayHealth),
              const SizedBox(height: 24),

              // Section: Resultados y Consejos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.resultsAndTips,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${displayInsights.length} ${l10n.insightsCount}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Insights List
              if (displayInsights.isEmpty)
                _buildEmptyState(theme, l10n)
              else
                ...displayInsights.map((insight) => InsightCard(
                      insight: insight,
                      onNodeTap: () {},
                    )),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, ThemeData theme, AppLocalizations l10n) {
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.flash_on,
                              color: theme.primaryColor, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            l10n.activeInspection.toUpperCase(),
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.projectPlaceholder,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.locationPlaceholder,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Mini mapa placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/map_placeholder.png'), // Need asset or mock
                  fit: BoxFit.cover,
                  opacity: 0.5,
                )),
            child: Center(
              child: Icon(
                Icons.location_on,
                color: theme.primaryColor,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
      BuildContext context, ThemeData theme, AppLocalizations l10n) {
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.qr_code_scanner,
            label: l10n.scanEquipment,
            color: theme.primaryColor,
            textColor: Colors.white,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('⚡ ${l10n.scanFeatureComingSoon}'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: theme.primaryColor,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.edit_note,
            label: l10n.manualEntry,
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            textColor: isDark ? Colors.white : const Color(0xFF1E293B),
            onTap: () {
              if (root != null) {
                showDialog(
                  context: context,
                  builder: (ctx) => ManualEntryForm(
                    node: root!,
                    onSave: (measurement) {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('✅ ${l10n.measurementSaved}'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadges(
      InstallationHealth health, ThemeData theme, AppLocalizations l10n) {
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Row(
      children: [
        Expanded(
          child: _StatusBadge(
            label: l10n.security,
            value: _getSecurityText(health.securityLevel, l10n),
            icon: Icons.shield,
            color: _getSecurityColor(health.securityLevel),
            backgroundColor: cardBg,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatusBadge(
            label: l10n.regulationsRebt,
            value: health.warningCount > 0
                ? '${health.warningCount} ${l10n.warnings}'
                : l10n.compliant,
            icon: Icons.gavel,
            color: health.warningCount > 0 ? Colors.orange : Colors.green,
            backgroundColor: cardBg,
          ),
        ),
        if (health.verificationFailures > 0) ...[
          const SizedBox(width: 12),
          Expanded(
            child: _StatusBadge(
              label: l10n.verifications,
              value: '${health.verificationFailures} ${l10n.failures}',
              icon: Icons.science,
              color: Colors.redAccent,
              backgroundColor: cardBg,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: Colors.green.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noProblemsDetected,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _getSecurityText(SecurityLevel level, AppLocalizations l10n) {
    switch (level) {
      case SecurityLevel.critical:
        return l10n.securityCritical;
      case SecurityLevel.low:
        return l10n.securityLow;
      case SecurityLevel.medium:
        return l10n.securityMedium;
      case SecurityLevel.high:
        return l10n.securityHigh;
    }
  }

  Color _getSecurityColor(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.critical:
        return Colors.redAccent;
      case SecurityLevel.low:
        return Colors.orange;
      case SecurityLevel.medium:
        return Colors.blue;
      case SecurityLevel.high:
        return Colors.green;
    }
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 32),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _StatusBadge({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Icon(icon, color: color, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
