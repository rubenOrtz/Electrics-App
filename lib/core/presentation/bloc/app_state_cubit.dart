import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ============================================================================
// APP STATE
// ============================================================================

enum AppStatus {
  initial,
  onboardingRequired,
  authenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final bool isLoading;
  final String? error;

  const AppState({
    this.status = AppStatus.initial,
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

  final SharedPreferences _prefs;

  AppStateCubit(this._prefs) : super(const AppState());

  /// Check app initialization state and determine initial route
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
      emit(state.copyWith(status: AppStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Reset onboarding status (for testing/debugging)
  Future<void> resetOnboarding() async {
    try {
      await _prefs.remove(_onboardingCompletedKey);
      emit(state.copyWith(status: AppStatus.onboardingRequired));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
