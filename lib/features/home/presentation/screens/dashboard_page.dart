import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import '../../../projects/presentation/screens/projects_page.dart';
import '../../../settings/presentation/screens/settings_page.dart';
import '../../../calculator/presentation/screens/calculations_page.dart';
import 'home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../projects/presentation/bloc/project_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onNavigateToTab: (index) {
        setState(() {
          _currentIndex = index;
        });
      }), // Home with feature cards
      const CalculationsPage(), // Calculations
      const ProjectsPage(), // Projects
      const SettingsPage(), // Settings
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.color
              ?.withValues(alpha: 0.6),
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.navHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calculate_outlined),
              activeIcon: const Icon(Icons.calculate),
              label: AppLocalizations.of(context)!.navCalculations,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.folder_open_outlined),
              activeIcon: const Icon(Icons.folder),
              label: AppLocalizations.of(context)!.navProjects,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              label: 'Ajustes',
            ),
          ],
        ),
      ),
      floatingActionButton: _currentIndex == 2
          ? FloatingActionButton(
              // Show only on Projects tab
              onPressed: () {
                context.read<ProjectCubit>().createNewProject();
                Navigator.pushNamed(context, '/projects/config');
              },
              backgroundColor: kPrimaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
