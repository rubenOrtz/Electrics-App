import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:electrician_app/core/presentation/widgets/beta_feature_banner.dart';

class RegulationsPage extends StatelessWidget {
  const RegulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(AppLocalizations.of(context)!.regulationsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: kPrimaryColor),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Beta Banner
            const BetaFeatureBanner(),

            // Search
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: AppLocalizations.of(context)!
                          .searchRegulationsPlaceholder,
                      suffixIcon: const Icon(Icons.mic, color: kPrimaryColor),
                      filled: true,
                      fillColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : kSurfaceDark,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildChip(
                            context,
                            'REBT',
                            kPrimaryColor.withValues(alpha: 0.1),
                            kPrimaryColor),
                        const SizedBox(width: 8),
                        _buildChip(context, 'ITC-BT-18', Colors.grey.shade200,
                            Colors.grey.shade700),
                        const SizedBox(width: 8),
                        _buildChip(context, 'Guía VDE', Colors.grey.shade200,
                            Colors.grey.shade700),
                        const SizedBox(width: 8),
                        _buildChip(context, l10n.selfConsumption,
                            Colors.grey.shade200, Colors.grey.shade700),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Updates
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.recentUpdates,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold))),
            ),

            SizedBox(
              height: 140,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildUpdateCard(
                      context,
                      'ITC-BT-52: Vehículo Eléctrico',
                      'Nuevos esquemas de conexión...',
                      l10n.modification,
                      Colors.amber),
                  const SizedBox(width: 12),
                  _buildUpdateCard(
                      context,
                      'Guía Técnica de Aplicación',
                      'Actualización completa de la guía...',
                      'Nueva Guía',
                      Colors.green),
                  const SizedBox(width: 12),
                  _buildUpdateCard(
                      context,
                      'Consulta Pública REBT',
                      'Abierto el plazo de alegaciones...',
                      l10n.draft,
                      Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.categories,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 4 / 3,
              children: [
                _buildCategoryCard(
                    context,
                    AppLocalizations.of(context)!.lowVoltage,
                    'REBT e ITCs',
                    Icons.bolt,
                    Colors.blueGrey),
                _buildCategoryCard(
                    context,
                    AppLocalizations.of(context)!.highVoltage,
                    'RAT y Líneas',
                    Icons.electrical_services,
                    Colors.deepPurple),
                _buildCategoryCard(
                    context,
                    AppLocalizations.of(context)!.safety,
                    'PRL y Protocolos',
                    Icons.health_and_safety,
                    Colors.green),
                _buildCategoryCard(
                    context,
                    AppLocalizations.of(context)!.technicalGuides,
                    l10n.interpretation,
                    Icons.menu_book,
                    Colors.orange),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: bg == kPrimaryColor.withValues(alpha: 0.1)
            ? Border.all(color: kPrimaryColor.withValues(alpha: 0.2))
            : null,
      ),
      child: Text(label,
          style: TextStyle(
              color: text, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildUpdateCard(BuildContext context, String title, String desc,
      String badge, Color color) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withValues(alpha: 0.2))),
                child: Text(badge,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color)),
              ),
              Text('Hace 2d', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(desc,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String subtitle,
      IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8), // Placeholder for image
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.6), color]),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Text(subtitle,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
