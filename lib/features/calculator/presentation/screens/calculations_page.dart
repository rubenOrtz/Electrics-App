import 'package:flutter/material.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/projects/presentation/bloc/project_cubit.dart';

import 'package:electrician_app/core/presentation/widgets/coming_soon_dialog.dart';

class CalculationsPage extends StatelessWidget {
  const CalculationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.calculationsTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildCategoryHeader(
                context, AppLocalizations.of(context)!.cableCalculations),
            const SizedBox(height: 12),
            _buildToolCard(
              context,
              AppLocalizations.of(context)!.voltageDrop,
              AppLocalizations.of(context)!.voltageDropDesc,
              Icons.bolt,
              Colors.orange,
              '/calculator/voltage-drop',
            ),
            _buildToolCard(
              context,
              AppLocalizations.of(context)!.ampacity,
              AppLocalizations.of(context)!.ampacityDesc,
              Icons.flash_on,
              Colors.orange,
              null,
            ),
            _buildToolCard(
              context,
              AppLocalizations.of(context)!.conduitSize,
              AppLocalizations.of(context)!.conduitSizeDesc,
              Icons.circle_outlined,
              Colors.blueGrey,
              null,
            ),
            const SizedBox(height: 24),
            _buildCategoryHeader(
                context, AppLocalizations.of(context)!.installations),
            const SizedBox(height: 12),
            _buildToolCard(
              context,
              AppLocalizations.of(context)!.chargingStation,
              AppLocalizations.of(context)!.chargingStationDesc,
              Icons.ev_station,
              Colors.green,
              '/calculator/charging',
            ),
            _buildToolCard(
              context,
              AppLocalizations.of(context)!.capacitorBank,
              AppLocalizations.of(context)!.capacitorBankDesc,
              Icons.battery_charging_full,
              Colors.purple,
              null,
            ),
            const SizedBox(height: 24),
            _buildCategoryHeader(context, AppLocalizations.of(context)!.costs),
            const SizedBox(height: 12),
            _buildToolCard(
              context,
              AppLocalizations.of(context)!.budgetEstimator,
              AppLocalizations.of(context)!.budgetEstimatorDesc,
              Icons.euro,
              Colors.teal,
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
    );
  }

  Widget _buildToolCard(BuildContext context, String title, String subtitle,
      IconData icon, Color color, String? route) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (route != null) {
            if (route == '/diagram/single-line') {
              context.read<ProjectCubit>().createNewProject();
            }
            Navigator.of(context).pushNamed(route);
          } else {
            showComingSoon(context, featureName: title);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withValues(alpha: 0.7),
                        )),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: theme.textTheme.bodyMedium?.color
                      ?.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}
