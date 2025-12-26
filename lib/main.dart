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

import 'injection_container.dart';
import 'core/presentation/bloc/app_state_cubit.dart';
import 'core/navigation/navigation.dart';
import 'features/onboarding/presentation/bloc/onboarding_cubit.dart';

/// Entry point of the Electrics-App application.
/// Preserves native splash screen until all critical services are initialized.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash screen until initialization completes
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // Initialize DI container (Isar, repositories, use cases, etc.)
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AppStateCubit from DI - will auto-initialize on creation
        BlocProvider(
          create: (context) => sl<AppStateCubit>()..initializeApp(),
        ),
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
      child: BlocBuilder<AppStateCubit, AppState>(
        builder: (context, appState) {
          // Handle initialization states
          if (appState.status == AppStatus.initializing) {
            return _buildLoadingApp(context);
          }

          if (appState.status == AppStatus.initializationFailed) {
            return _buildErrorApp(context, appState.error);
          }

          // App ready - render full app
          return _buildFullApp(context, appState);
        },
      ),
    );
  }

  /// Loading state UI - shown during initialization
  Widget _buildLoadingApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es'), Locale('en')],
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
                AppLocalizations.of(context)?.initializing ??
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

  /// Error state UI - shown when initialization fails
  Widget _buildErrorApp(BuildContext context, String? error) {
    // Remove splash to show error UI
    FlutterNativeSplash.remove();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es'), Locale('en')],
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
                  Text(
                    AppLocalizations.of(context)?.initializationError ??
                        'Error de Inicialización',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    error ??
                        AppLocalizations.of(context)?.unknownError ??
                        'Error inesperado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<AppStateCubit>().retryInitialization(),
                    icon: const Icon(Icons.refresh),
                    label: Text(
                        AppLocalizations.of(context)?.retry ?? 'Reintentar'),
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

  /// Full app UI - shown when initialization succeeds
  Widget _buildFullApp(BuildContext context, AppState appState) {
    // Remove splash once full app is ready
    FlutterNativeSplash.remove();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final isDynamicAvailable =
                lightDynamic != null || darkDynamic != null;

            // Update dynamic color availability without causing rebuild loops
            if (themeState.isDynamicColorAvailable != isDynamicAvailable) {
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
                    theme: _getTheme(themeState),
                    darkTheme: _getDarkTheme(themeState),
                    themeMode: _getThemeMode(themeState.mode),
                    onGenerateRoute: AppRoutes.onGenerateRoutes,
                    onGenerateInitialRoutes: (initialRoute) {
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
        return state.dynamicLightScheme != null
            ? dynamicLightTheme(state.dynamicLightScheme!)
            : theme();
    }
  }

  /// Determines the dark theme based on current theme mode
  ThemeData _getDarkTheme(ThemeState state) {
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
