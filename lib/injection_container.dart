import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';

import 'core/database/isar_service.dart';
import 'features/projects/data/models/project_model.dart';
import 'package:electrician_app/features/projects/domain/repositories/project_repository.dart';
import 'package:electrician_app/features/projects/data/repositories/project_repository_impl.dart';

import 'features/projects/data/datasources/project_local_data_source.dart';

import 'features/settings/data/models/app_settings_model.dart';

import 'features/settings/data/models/user_profile_model.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/user_profile_repository.dart';
import 'features/settings/data/repositories/user_profile_repository_impl.dart';
import 'features/settings/domain/usecases/get_user_profile.dart';
import 'features/settings/domain/usecases/save_user_profile.dart';
import 'features/settings/domain/usecases/update_profile_photo.dart';
import 'features/settings/domain/usecases/update_company_logo.dart';
import 'features/settings/presentation/bloc/user_profile_cubit.dart';

import 'features/components/data/models/component_model.dart';
import 'features/components/domain/repositories/component_repository.dart';
import 'features/components/data/datasources/component_local_data_source.dart';
import 'features/components/presentation/bloc/component_library_cubit.dart';
import 'features/health/presentation/bloc/health_bloc.dart';

import 'features/diagram/data/data_sources/cable_presets_data_source.dart';
import 'features/diagram/data/data_sources/protection_presets_data_source.dart';
import 'features/diagram/domain/repositories/diagram_repository.dart';
import 'features/diagram/data/repositories/diagram_repository_impl.dart';
import 'features/diagram/domain/use_cases/calculate_diagram.dart';
import 'features/diagram/domain/use_cases/validate_diagram.dart';
import 'features/diagram/domain/use_cases/add_child_node.dart';
import 'features/diagram/domain/use_cases/update_node.dart';
import 'features/diagram/presentation/bloc/diagram_cubit.dart';
import 'features/budget/domain/repositories/price_repository.dart';
import 'features/budget/data/repositories/mock_price_repository.dart';
import 'features/budget/domain/services/pricing_engine.dart';
import 'features/budget/domain/services/material_aggregator_service.dart';
import 'features/budget/presentation/cubit/budget_cubit.dart';
import 'features/onboarding/presentation/bloc/onboarding_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Isar Service - Clean Architecture compliant
  final isarService = IsarService();
  await isarService.initialize([
    ProjectModelSchema,
    AppSettingsModelSchema,
    UserProfileModelSchema,
    ComponentModelSchema,
  ]);
  sl.registerSingleton<IsarService>(isarService);

  // Register Isar instance for legacy code
  final isar = isarService.instance;
  if (isar != null) {
    sl.registerSingleton<Isar>(isar);
  }

  // Repositories
  sl.registerSingleton<ProjectLocalDataSource>(
      ProjectLocalDataSourceImpl(sl()));
  sl.registerSingleton<ProjectRepository>(ProjectRepositoryImpl(sl()));
  sl.registerSingleton<SettingsRepository>(SettingsRepositoryImpl(sl()));
  sl.registerSingleton<UserProfileRepository>(UserProfileRepositoryImpl(sl()));

  // Component Feature - DataSource already implements repository interface
  sl.registerSingleton<ComponentRepository>(ComponentLocalDataSource(sl()));

  // Settings Feature Use Cases
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => SaveUserProfile(sl()));
  sl.registerLazySingleton(() => UpdateProfilePhoto(sl()));
  sl.registerLazySingleton(() => UpdateCompanyLogo(sl()));

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Diagram Feature
  // Data Sources
  sl.registerLazySingleton<CablePresetsDataSource>(
      () => CablePresetsDataSourceImpl());
  sl.registerLazySingleton<ProtectionPresetsDataSource>(
      () => ProtectionPresetsDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<DiagramRepository>(() => DiagramRepositoryImpl(
        cablePresetsDataSource: sl(),
        protectionPresetsDataSource: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => CalculateDiagramUseCase());
  sl.registerLazySingleton(() => ValidateDiagramUseCase());
  sl.registerLazySingleton(() => AddChildNodeUseCase());
  sl.registerLazySingleton(() => UpdateNodeUseCase());

  // Blocs
  sl.registerFactory(() => DiagramCubit(
        calculateDiagramUseCase: sl(),
        validateDiagramUseCase: sl(),
        addChildNodeUseCase: sl(),
        updateNodeUseCase: sl(),
      ));

  sl.registerFactory(() => ComponentLibraryCubit(sl()));

  // Settings Feature Cubits
  sl.registerFactory(() => UserProfileCubit(
        getUserProfile: sl(),
        saveUserProfile: sl(),
        updateProfilePhoto: sl(),
        updateCompanyLogo: sl(),
      ));

  // Health Feature
  sl.registerFactory(() => HealthBloc(diagramCubit: sl()));

  // Budget Feature
  sl.registerSingleton<PriceRepository>(MockPriceRepository());
  sl.registerLazySingleton<MaterialAggregatorService>(
      () => MaterialAggregatorService(componentRepository: sl()));
  sl.registerLazySingleton<PricingEngine>(
      () => PricingEngine(sl(), aggregator: sl()));
  sl.registerFactory(() => BudgetCubit(sl()));

  // Onboarding Feature
  sl.registerFactory(() => OnboardingCubit(userProfileRepository: sl()));
}
