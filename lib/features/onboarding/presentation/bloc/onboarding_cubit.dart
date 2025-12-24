import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/domain/entities/user_profile.dart';
import '../../../settings/domain/repositories/user_profile_repository.dart';

// ============================================================================
// ONBOARDING STATE (Simplified)
// ============================================================================

class OnboardingState extends Equatable {
  final int currentStep;
  final int totalSteps;
  final bool isLoading;
  final String? error;

  // Collected data
  final String? personalName;
  final String? personalEmail;
  final String? personalPhone;
  final String? personalDni;
  final String? engineerId;
  final ProfessionalType professionalType;

  // Company data (optional)
  final String? companyCif;
  final String? companyName;
  final String? companyAddress;

  const OnboardingState({
    this.currentStep = 0,
    this.totalSteps = 4,
    this.isLoading = false,
    this.error,
    this.personalName,
    this.personalEmail,
    this.personalPhone,
    this.personalDni,
    this.engineerId,
    this.professionalType = ProfessionalType.freelancer,
    this.companyCif,
    this.companyName,
    this.companyAddress,
  });

  OnboardingState copyWith({
    int? currentStep,
    int? totalSteps,
    bool? isLoading,
    String? error,
    String? personalName,
    String? personalEmail,
    String? personalPhone,
    String? personalDni,
    String? engineerId,
    ProfessionalType? professionalType,
    String? companyCif,
    String? companyName,
    String? companyAddress,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      personalName: personalName ?? this.personalName,
      personalEmail: personalEmail ?? this.personalEmail,
      personalPhone: personalPhone ?? this.personalPhone,
      personalDni: personalDni ?? this.personalDni,
      engineerId: engineerId ?? this.engineerId,
      professionalType: professionalType ?? this.professionalType,
      companyCif: companyCif ?? this.companyCif,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
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
        isLoading,
        error,
        personalName,
        personalEmail,
        personalPhone,
        personalDni,
        engineerId,
        professionalType,
        companyCif,
        companyName,
        companyAddress,
      ];
}

// ============================================================================
// ONBOARDING CUBIT (Simplified - Direct repository access)
// ============================================================================

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserProfileRepository userProfileRepository;

  OnboardingCubit({
    required this.userProfileRepository,
  }) : super(const OnboardingState());

  void nextStep() {
    if (state.currentStep < state.totalSteps - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
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

  void updateProfessionalType(ProfessionalType type) {
    final totalSteps = type == ProfessionalType.company ? 5 : 4;
    emit(state.copyWith(
      professionalType: type,
      totalSteps: totalSteps,
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

  Future<bool> completeOnboarding() async {
    emit(state.copyWith(isLoading: true));

    try {
      final profile = UserProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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

      final result = await userProfileRepository.saveUserProfile(profile);

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
}
