import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:electrician_app/config/routes/routes.dart';
import 'package:electrician_app/config/theme/app_themes.dart';

import 'package:electrician_app/config/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electrician_app/features/projects/presentation/bloc/project_cubit.dart';
import 'package:electrician_app/features/settings/presentation/bloc/settings_cubit.dart';

import 'package:electrician_app/features/projects/domain/repositories/project_repository.dart';
import 'package:electrician_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:electrician_app/features/settings/domain/entities/app_preferences.dart';
import 'package:electrician_app/features/settings/presentation/bloc/user_profile_cubit.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.dart';
import 'features/components/domain/repositories/component_repository.dart';
import 'core/presentation/bloc/app_state_cubit.dart';
import 'core/navigation/navigation.dart';
import 'features/onboarding/presentation/bloc/onboarding_cubit.dart';

// * Review WIKI/main.md to understand the logic by a diagram.

/// Entry point of the Electrics-App application.
/// Preserves native splash screen until all critical services are initialized.
Future<void> main() async {
  // Ensure Flutter framework is initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash screen until we explicitly remove it
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialization state tracking
  bool _isInitializing = true;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Critical services that must be initialized before app starts
  late SharedPreferences _prefs;
  late AppStateCubit _appStateCubit;

  @override
  void initState() {
    super.initState();

    // Defer initialization until after first frame is rendered
    // This ensures the widget tree is fully mounted and ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  /// Initializes all critical services required for app startup.
  ///
  /// This method orchestrates the following initialization sequence:
  /// 1. Dependency injection container (GetIt)
  /// 2. Isar database with all schemas
  /// 3. Component seed data (if not already loaded)
  /// 4. SharedPreferences
  /// 5. AppStateCubit (determines onboarding or dashboard route)

  Future<void> _initializeApp() async {
    try {
      setState(() {
        _isInitializing = true;
        _hasError = false;
      });

      // Step 1: Initialize dependency injection container
      await initializeDependencies();

      // Step 2: Verify and load component seed data
      final componentRepo = sl<ComponentRepository>();
      final hasSeed = await componentRepo.hasSeedData();
      if (!hasSeed) {
        await componentRepo.loadSeedData();
      }

      // Step 3: Initialize SharedPreferences
      _prefs = await SharedPreferences.getInstance();

      // Step 4: Create and initialize AppStateCubit
      // This determines if user needs onboarding or goes to dashboard
      _appStateCubit = AppStateCubit(_prefs);
      await _appStateCubit.checkAppStatus();

      // Mark initialization as complete
      setState(() {
        _isInitialized = true;
        _isInitializing = false;
      });

      // Small delay ensures smooth visual transition from splash to app
      // This prevents jarring instant transitions that can feel abrupt
      await Future.delayed(const Duration(milliseconds: 300));

      // Remove native splash screen - app is ready to be displayed
      FlutterNativeSplash.remove();
    } catch (e, stackTrace) {
      debugPrint('═══════════════════════════════════════════════════════');
      debugPrint('❌ CRITICAL: App initialization failed');
      debugPrint('Error: $e');
      debugPrint('Stack trace:\n$stackTrace');
      debugPrint('═══════════════════════════════════════════════════════');

      setState(() {
        _hasError = true;
        _errorMessage = _formatErrorMessage(e);
        _isInitializing = false;
      });

      // Remove splash to show error UI to user
      FlutterNativeSplash.remove();
    }
  }

  /// Formats error messages to be user-friendly while preserving technical details.
  String _formatErrorMessage(Object error) {
    if (error.toString().contains('Isar')) {
      return 'Error al inicializar la base de datos.\n\n$error';
    } else if (error.toString().contains('SharedPreferences')) {
      return 'Error al cargar preferencias de usuario.\n\n$error';
    } else if (error.toString().contains('ComponentRepository')) {
      return 'Error al cargar componentes eléctricos.\n\n$error';
    }
    return 'Error inesperado durante la inicialización.\n\n$error';
  }

  @override
  void dispose() {
    _appStateCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing || !_isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3.0,
                ),
                const SizedBox(height: 24),
                Text(
                  'Inicializando...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_hasError) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 72,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Error de Inicialización',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                          _errorMessage = '';
                        });
                        _initializeApp();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Success state: Render the full app with all providers
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _appStateCubit),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
            create: (context) => ProjectCubit(sl<ProjectRepository>())),
        BlocProvider(
            create: (context) => SettingsCubit(
                  sl<SettingsRepository>(),
                  themeCubit: context.read<ThemeCubit>(),
                )..loadSettings()),
        BlocProvider(
            create: (context) => sl<UserProfileCubit>()..loadProfile()),
        BlocProvider(create: (context) => sl<OnboardingCubit>()),
      ],
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final isDynamicAvailable =
                  lightDynamic != null || darkDynamic != null;

              // Update dynamic color availability without causing rebuild loops
              if (state.isDynamicColorAvailable != isDynamicAvailable) {
                Future.microtask(() {
                  context.read<ThemeCubit>().updateDynamicColorAvailability(
                        isDynamicAvailable,
                        lightScheme: lightDynamic,
                        darkScheme: darkDynamic,
                      );
                });
              }

              return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (settingsContext, settingsState) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler:
                          TextScaler.linear(settingsState.textSize.scaleFactor),
                    ),
                    child: MaterialApp(
                      navigatorKey: NavigationService.navigatorKey,
                      navigatorObservers: [appRouteObserver],
                      debugShowCheckedModeBanner: false,
                      theme: _getTheme(state),
                      darkTheme: _getDarkTheme(state),
                      themeMode: _getThemeMode(state.mode),
                      onGenerateRoute: AppRoutes.onGenerateRoutes,
                      onGenerateInitialRoutes: (initialRoute) {
                        final appState = context.read<AppStateCubit>().state;
                        if (appState.status == AppStatus.onboardingRequired) {
                          return [
                            AppRoutes.onGenerateRoutes(
                              const RouteSettings(name: AppRoutes.onboarding),
                            )
                          ];
                        }
                        return [
                          AppRoutes.onGenerateRoutes(
                            const RouteSettings(name: AppRoutes.dashboard),
                          )
                        ];
                      },
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [
                        Locale('es'),
                        Locale('en'),
                      ],
                      locale: Locale(settingsState.locale),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  /// Determines the light/default theme based on current theme mode
  ThemeData _getTheme(ThemeState state) {
    switch (state.mode) {
      case AppThemeMode.light:
        return theme();
      case AppThemeMode.dark:
        return darkTheme();
      case AppThemeMode.highContrastLight:
        return highContrastLightTheme();
      case AppThemeMode.highContrastDark:
        return highContrastDarkTheme();
      case AppThemeMode.system:
        return theme();
      case AppThemeMode.dynamic:
        // Use dynamic light theme if available, otherwise fallback to regular light
        return state.dynamicLightScheme != null
            ? dynamicLightTheme(state.dynamicLightScheme!)
            : theme();
    }
  }

  /// Determines the dark theme based on current theme mode
  ThemeData _getDarkTheme(ThemeState state) {
    switch (state.mode) {
      case AppThemeMode.light:
        return theme(); // Not used, but provide fallback
      case AppThemeMode.dark:
        return darkTheme();
      case AppThemeMode.highContrastLight:
        return highContrastLightTheme();
      case AppThemeMode.highContrastDark:
        return highContrastDarkTheme();
      case AppThemeMode.system:
        return darkTheme();
      case AppThemeMode.dynamic:
        return state.dynamicDarkScheme != null
            ? dynamicDarkTheme(state.dynamicDarkScheme!)
            : darkTheme();
    }
  }

  /// Determines the theme mode to tell MaterialApp how to switch themes
  ThemeMode _getThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
      case AppThemeMode.highContrastLight:
        return ThemeMode.light;
      case AppThemeMode.dark:
      case AppThemeMode.highContrastDark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      case AppThemeMode.dynamic:
        return ThemeMode.system;
    }
  }
}
