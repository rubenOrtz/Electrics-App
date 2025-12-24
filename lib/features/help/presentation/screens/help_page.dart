import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import 'package:electrician_app/l10n/app_localizations.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helpTitle),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: AppLocalizations.of(context)!.searchHelpPlaceholder,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),

            // Auto-help
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.selfHelpResources,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                      child: _buildHelpCard(
                          context,
                          AppLocalizations.of(context)!.faq,
                          'Lo más consultado',
                          Icons.quiz,
                          Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildHelpCard(
                          context,
                          AppLocalizations.of(context)!.userGuides,
                          'Manuales técnicos',
                          Icons.menu_book,
                          Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade100)),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.smart_display,
                            color: Colors.purple, size: 28)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Video Tutoriales',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Aprende paso a paso',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Check
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.contactSupport,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade100)),
                child: Column(
                  children: [
                    _buildContactItem(
                        context,
                        AppLocalizations.of(context)!.liveChat,
                        'Disponible ahora',
                        Icons.chat,
                        Colors.green),
                    const Divider(height: 1),
                    _buildContactItem(
                        context,
                        AppLocalizations.of(context)!.sendEmail,
                        'Respuesta en < 24h',
                        Icons.mail,
                        kPrimaryColor),
                    const Divider(height: 1),
                    _buildContactItem(
                        context,
                        AppLocalizations.of(context)!.callSupport,
                        'L-V: 08:00 - 18:00',
                        Icons.call,
                        Colors.orange),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Text('ElectroCalc Pro • v2.4.1',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            const Text('ID: 8A9-F22-X10',
                style: TextStyle(color: Colors.grey, fontSize: 10)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard(BuildContext context, String title, String subtitle,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color, size: 28)),
          const SizedBox(height: 12),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, String title, String subtitle,
      IconData icon, Color color) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: Colors.white)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle,
          style: TextStyle(
              color:
                  subtitle.contains('Disponible') ? Colors.green : Colors.grey,
              fontSize: 12,
              fontWeight: subtitle.contains('Disponible')
                  ? FontWeight.bold
                  : FontWeight.normal)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
