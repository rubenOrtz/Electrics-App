import 'package:flutter/material.dart';
import '../../features/home/presentation/screens/dashboard_page.dart';
import '../../features/regulations/presentation/screens/regulations_page.dart';
import '../../features/help/presentation/screens/help_page.dart';
import '../../features/projects/presentation/screens/general_config_page.dart';
import '../../features/calculator/presentation/screens/charging_station_page.dart';
import '../../features/calculator/presentation/screens/voltage_drop_page.dart';
import '../../features/documents/presentation/screens/document_generation_page.dart';
import '../../features/calculator/presentation/screens/calculations_page.dart';
import '../../features/diagram/presentation/screens/single_line_diagram_page.dart';
import '../../features/settings/presentation/screens/settings_page.dart';
import '../../features/components/presentation/screens/component_library_page.dart';
import '../../features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/components/presentation/bloc/component_library_cubit.dart';

import '../../features/budget/presentation/screens/budget_page.dart';
import '../../features/budget/presentation/cubit/budget_cubit.dart';
import '../../features/diagram/domain/entities/electrical_node.dart';
import '../../injection_container.dart';

/// Optimized routes using cached builders and PageRouteBuilder
class AppRoutes {
  // Route names
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';
  static const String projects = '/projects';
  static const String regulations = '/regulations';
  static const String help = '/help';
  static const String projectConfig = '/projects/config';
  static const String calculator = '/calculator';
  static const String calculatorCharging = '/calculator/charging';
  static const String calculatorVoltageDrop = '/calculator/voltage-drop';
  static const String documentsGenerate = '/documents/generate';
  static const String diagramSingleLine = '/diagram/single-line';
  static const String library = '/library';
  static const String budget = '/budget';

  /// Cached route builders for better performance
  static final Map<String, WidgetBuilder> _routes = {
    dashboard: (_) => const DashboardPage(),
    settings: (_) => const SettingsPage(),
    projects: (_) => const DashboardPage(),
    regulations: (_) => const RegulationsPage(),
    help: (_) => const HelpPage(),
    projectConfig: (_) => const GeneralConfigPage(),
    calculator: (_) => const CalculationsPage(),
    calculatorCharging: (_) => const ChargingStationPage(),
    calculatorVoltageDrop: (_) => const VoltageDropPage(),
    documentsGenerate: (_) => const DocumentGenerationPage(),
    onboarding: (_) => const OnboardingPage(),
  };

  static Route onGenerateRoutes(RouteSettings settings) {
    // Handle routes with arguments
    switch (settings.name) {
      case diagramSingleLine:
        final projectId = settings.arguments is String
            ? settings.arguments as String
            : settings.arguments?.toString() ?? '';
        if (projectId.isEmpty) {
          return _createRoute(const DashboardPage());
        }
        return _createRoute(SingleLineDiagramPage(
          projectId: projectId,
          title: 'Diagrama Unifilar',
        ));

      case library:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _createRoute(BlocProvider(
          create: (_) => sl<ComponentLibraryCubit>(),
          child: ComponentLibraryPage(
            isPicker: args['isPicker'] ?? false,
            filterType: args['filterType'],
          ),
        ));

      case budget:
        final root = settings.arguments;
        if (root == null) {
          return _createRoute(const DashboardPage());
        }
        return _createRoute(BlocProvider(
          create: (_) => sl<BudgetCubit>()..loadBudget(root as ElectricalNode),
          child: const BudgetPage(),
        ));

      default:
        // Use cached route if available
        final builder = _routes[settings.name];
        if (builder != null) {
          return _createRoute(
            Builder(builder: (context) => builder(context)),
          );
        }
        // Fallback to dashboard
        return _createRoute(const DashboardPage());
    }
  }

  /// Creates optimized route with custom transitions
  static Route _createRoute(Widget page, {RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
