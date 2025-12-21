import 'package:flutter/material.dart';

import '../../features/jobs/presentation/pages/home/jobs_home.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const JobsHome());
        
      default:
        return _materialRoute(const JobsHome());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
