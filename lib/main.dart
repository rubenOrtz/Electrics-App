import 'package:flutter/material.dart';
import 'package:electrician_app/config/routes/routes.dart';
import 'package:electrician_app/config/theme/app_themes.dart';
import 'package:electrician_app/features/jobs/presentation/pages/home/jobs_home.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const JobsHome());
  }
}
