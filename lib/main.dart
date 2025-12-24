import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  // Initialize seed data if database is empty
  final componentRepo = sl<ComponentRepository>();
  final hasSeed = await componentRepo.hasSeedData();
  if (!hasSeed) {
    await componentRepo.loadSeedData();
  }

  // Get SharedPreferences for AppStateCubit
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppStateCubit _appStateCubit;

  @override
  void initState() {
    super.initState();
    _appStateCubit = AppStateCubit(widget.prefs);
    _appStateCubit.checkAppStatus();
  }

  @override
  void dispose() {
    _appStateCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
