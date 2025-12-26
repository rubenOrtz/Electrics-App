import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/domain/entities/app_preferences.dart';
import '../../../settings/domain/entities/app_theme_mode.dart';
import '../../../settings/domain/entities/user_profile.dart';
import '../../domain/entities/onboarding_preferences.dart';
import '../../domain/usecases/save_onboarding_data_usecase.dart';

// ============================================================================
// ONBOARDING STEP CONFIGURATION
// ============================================================================

enum OnboardingStepConfig {
  personalInfo,
  professionalType,
  companyInfo,
  preferences,
  welcome,
}

// ============================================================================
// ONBOARDING STATE
// ============================================================================

class OnboardingState extends Equatable {
  final int currentStep;
  final int totalSteps;
  final List<OnboardingStepConfig> stepConfigs;
  final bool isLoading;
  final bool isSaving;
  final String? error;
  final DateTime? lastSavedAt;

  // Personal Info
  final String? personalName;
  final String? personalEmail;
  final String? personalPhone;
  final String? personalDni;
  final String? engineerId;
  final ProfessionalType professionalType;

  // Company Info
  final String? companyCif;
  final String? companyName;
  final String? companyAddress;

  // Preferences
  final String locale;
  final AppThemeMode themePreference;
  final TextSizePreference textSizePreference;
  final bool notificationsEnabled;

  const OnboardingState({
    this.currentStep = 0,
    this.totalSteps = 4,
    this.stepConfigs = const [
      OnboardingStepConfig.personalInfo,
      OnboardingStepConfig.professionalType,
      OnboardingStepConfig.preferences,
      OnboardingStepConfig.welcome,
    ],
    this.isLoading = false,
    this.isSaving = false,
    this.error,
    this.lastSavedAt,
    this.personalName,
    this.personalEmail,
    this.personalPhone,
    this.personalDni,
    this.engineerId,
    this.professionalType = ProfessionalType.freelancer,
    this.companyCif,
    this.companyName,
    this.companyAddress,
    this.locale = 'es',
    this.themePreference = AppThemeMode.dark,
    this.textSizePreference = TextSizePreference.medium,
    this.notificationsEnabled = true,
  });

  /// Factory for initial state
  factory OnboardingState.initial() {
    return const OnboardingState();
  }

  OnboardingState copyWith({
    int? currentStep,
    int? totalSteps,
    List<OnboardingStepConfig>? stepConfigs,
    bool? isLoading,
    bool? isSaving,
    String? error,
    DateTime? lastSavedAt,
    String? personalName,
    String? personalEmail,
    String? personalPhone,
    String? personalDni,
    String? engineerId,
    ProfessionalType? professionalType,
    String? companyCif,
    String? companyName,
    String? companyAddress,
    String? locale,
    AppThemeMode? themePreference,
    TextSizePreference? textSizePreference,
    bool? notificationsEnabled,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      stepConfigs: stepConfigs ?? this.stepConfigs,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error,
      lastSavedAt: lastSavedAt ?? this.lastSavedAt,
      personalName: personalName ?? this.personalName,
      personalEmail: personalEmail ?? this.personalEmail,
      personalPhone: personalPhone ?? this.personalPhone,
      personalDni: personalDni ?? this.personalDni,
      engineerId: engineerId ?? this.engineerId,
      professionalType: professionalType ?? this.professionalType,
      companyCif: companyCif ?? this.companyCif,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      locale: locale ?? this.locale,
      themePreference: themePreference ?? this.themePreference,
      textSizePreference: textSizePreference ?? this.textSizePreference,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  bool get isPersonalInfoComplete {
    return personalName?.isNotEmpty == true &&
        personalEmail?.isNotEmpty == true &&
        personalPhone?.isNotEmpty == true &&
        personalDni?.isNotEmpty == true &&
        engineerId?.isNotEmpty == true;
  }

  bool get isCompanyInfoComplete {
    if (professionalType == ProfessionalType.freelancer) return true;
    return companyCif?.isNotEmpty == true &&
        companyName?.isNotEmpty == true &&
        companyAddress?.isNotEmpty == true;
  }

  @override
  List<Object?> get props => [
        currentStep,
        totalSteps,
        stepConfigs,
        isLoading,
        isSaving,
        error,
        lastSavedAt,
        personalName,
        personalEmail,
        personalPhone,
        personalDni,
        engineerId,
        professionalType,
        companyCif,
        companyName,
        companyAddress,
        locale,
        themePreference,
        textSizePreference,
        notificationsEnabled,
      ];
}

// ============================================================================
// ONBOARDING CUBIT
// ============================================================================

class OnboardingCubit extends Cubit<OnboardingState> {
  final SaveOnboardingDataUseCase _saveDataUseCase;

  OnboardingCubit({
    required SaveOnboardingDataUseCase saveDataUseCase,
  })  : _saveDataUseCase = saveDataUseCase,
        super(OnboardingState.initial());

  List<OnboardingStepConfig> _calculateSteps(ProfessionalType type) {
    final steps = [
      OnboardingStepConfig.personalInfo,
      OnboardingStepConfig.professionalType,
    ];

    if (type == ProfessionalType.company) {
      steps.add(OnboardingStepConfig.companyInfo);
    }

    steps.addAll([
      OnboardingStepConfig.preferences,
      OnboardingStepConfig.welcome,
    ]);

    return steps;
  }

  void nextStep() {
    if (state.currentStep < state.totalSteps - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
      // Trigger partial save here if implemented
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void setCurrentStep(int index) {
    if (index >= 0 && index < state.totalSteps) {
      emit(state.copyWith(currentStep: index));
    }
  }

  void updatePersonalInfo({
    String? name,
    String? email,
    String? phone,
    String? dni,
    String? engineerId,
  }) {
    emit(state.copyWith(
      personalName: name,
      personalEmail: email,
      personalPhone: phone,
      personalDni: dni,
      engineerId: engineerId,
    ));
  }

  void updateCompanyInfo({
    String? cif,
    String? name,
    String? address,
  }) {
    emit(state.copyWith(
      companyCif: cif,
      companyName: name,
      companyAddress: address,
    ));
  }

  void updateProfessionalType(ProfessionalType type) {
    final newSteps = _calculateSteps(type);
    final currentIndex = state.currentStep;

    final cleanedState = type == ProfessionalType.freelancer
        ? state.copyWith(
            companyCif: null,
            companyName: null,
            companyAddress: null,
          )
        : state;

    if (currentIndex >= newSteps.length) {
      final safeIndex = newSteps.length - 1;
      emit(cleanedState.copyWith(
        currentStep: safeIndex,
        professionalType: type,
        stepConfigs: newSteps,
        totalSteps: newSteps.length,
      ));
    } else {
      emit(cleanedState.copyWith(
        professionalType: type,
        stepConfigs: newSteps,
        totalSteps: newSteps.length,
      ));
    }
  }

  void updatePreferences({
    String? locale,
    AppThemeMode? themeMode,
    TextSizePreference? textSize,
    bool? notificationsEnabled,
  }) {
    emit(state.copyWith(
      locale: locale,
      themePreference: themeMode,
      textSizePreference: textSize,
      notificationsEnabled: notificationsEnabled,
    ));
  }

  Future<bool> completeOnboarding() async {
    emit(state.copyWith(isLoading: true));

    try {
      final profile = _buildUserProfile();
      final preferences = _buildOnboardingPreferences();

      final result = await _saveDataUseCase(
        profile: profile,
        preferences: preferences,
      );

      return result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
          ));
          return false;
        },
        (_) {
          emit(state.copyWith(isLoading: false));
          return true;
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return false;
    }
  }

  UserProfile _buildUserProfile() {
    return UserProfile(
      id: '1',
      personalName: state.personalName ?? '',
      personalEmail: state.personalEmail ?? '',
      personalPhone: state.personalPhone ?? '',
      personalDni: state.personalDni ?? '',
      engineerId: state.engineerId ?? '',
      professionalType: state.professionalType,
      companyCif: state.companyCif,
      companyName: state.companyName,
      companyAddress: state.companyAddress,
      companyEmail: null,
      companyPhone: null,
    );
  }

  OnboardingPreferences _buildOnboardingPreferences() {
    return OnboardingPreferences(
      locale: state.locale,
      themeMode: state.themePreference,
      textSize: state.textSizePreference,
      notificationsEnabled: state.notificationsEnabled,
    );
  }
}
