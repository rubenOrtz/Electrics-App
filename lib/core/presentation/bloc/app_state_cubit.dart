import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:electrician_app/core/domain/usecases/initialize_app_usecase.dart';

// ============================================================================
// APP STATE
// ============================================================================

enum AppStatus {
  initializing, // App is starting up, loading resources
  initializationFailed, // Startup failed with error
  initial,
  onboardingRequired,
  authenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final bool isLoading;
  final String? error;

  const AppState({
    this.status = AppStatus.initializing, // Start in initializing state
    this.isLoading = false,
    this.error,
  });

  AppState copyWith({
    AppStatus? status,
    bool? isLoading,
    String? error,
  }) {
    return AppState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, isLoading, error];
}

// ============================================================================
// APP STATE CUBIT
// ============================================================================

class AppStateCubit extends Cubit<AppState> {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  final InitializeAppUseCase _initializeAppUseCase;
  final SharedPreferences _prefs;

  AppStateCubit({
    required InitializeAppUseCase initializeAppUseCase,
    required SharedPreferences prefs,
  })  : _initializeAppUseCase = initializeAppUseCase,
        _prefs = prefs,
        super(const AppState(status: AppStatus.initializing));

  /// Initialize the application
  ///
  /// Delegates to InitializeAppUseCase for all initialization logic
  /// This keeps the Cubit focused on state management only
  Future<void> initializeApp() async {
    emit(state.copyWith(status: AppStatus.initializing, isLoading: true));

    final result = await _initializeAppUseCase();

    if (result.isSuccess) {
      if (result.shouldShowOnboarding) {
        emit(state.copyWith(
          status: AppStatus.onboardingRequired,
          isLoading: false,
          error: null,
        ));
      } else {
        emit(state.copyWith(
          status: AppStatus.authenticated,
          isLoading: false,
          error: null,
        ));
      }
    } else {
      emit(state.copyWith(
        status: AppStatus.initializationFailed,
        isLoading: false,
        error: result.error,
      ));
    }
  }

  /// Retry initialization after failure
  Future<void> retryInitialization() async {
    await initializeApp();
  }

  /// Check app initialization state and determine initial route
  /// @deprecated Use initializeApp() instead - this method is kept for compatibility
  Future<void> checkAppStatus() async {
    emit(state.copyWith(isLoading: true));

    try {
      final hasCompletedOnboarding =
          _prefs.getBool(_onboardingCompletedKey) ?? false;

      if (!hasCompletedOnboarding) {
        emit(state.copyWith(
          status: AppStatus.onboardingRequired,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          status: AppStatus.authenticated,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    try {
      await _prefs.setBool(_onboardingCompletedKey, true);
      emit(state.copyWith(status: AppStatus.authenticated, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Reset onboarding status (for testing/debugging)
  Future<void> resetOnboarding() async {
    try {
      await _prefs.remove(_onboardingCompletedKey);
      emit(state.copyWith(status: AppStatus.onboardingRequired, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
