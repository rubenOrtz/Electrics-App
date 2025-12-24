import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/save_user_profile.dart';
import '../../domain/usecases/update_profile_photo.dart';
import '../../domain/usecases/update_company_logo.dart';

// ============================================================================
// USER PROFILE STATE
// ============================================================================

class UserProfileState extends Equatable {
  final UserProfile? profile;
  final bool isLoading;
  final bool isEditing;
  final String? error;

  const UserProfileState({
    this.profile,
    this.isLoading = false,
    this.isEditing = false,
    this.error,
  });

  UserProfileState copyWith({
    UserProfile? profile,
    bool? isLoading,
    bool? isEditing,
    String? error,
  }) {
    return UserProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      error: error ?? this.error,
    );
  }

  /// Convenience getter for professional type
  ProfessionalType get professionalType =>
      profile?.professionalType ?? ProfessionalType.freelancer;

  /// Check if profile has complete personal info
  bool get hasCompletePersonalInfo => profile?.hasCompletePersonalInfo ?? false;

  /// Check if profile has complete company info
  bool get hasCompleteCompanyInfo => profile?.hasCompleteCompanyInfo ?? true;

  @override
  List<Object?> get props => [profile, isLoading, isEditing, error];
}

// ============================================================================
// USER PROFILE CUBIT
// ============================================================================

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfile getUserProfile;
  final SaveUserProfile saveUserProfile;
  final UpdateProfilePhoto updateProfilePhoto;
  final UpdateCompanyLogo updateCompanyLogo;

  UserProfileCubit({
    required this.getUserProfile,
    required this.saveUserProfile,
    required this.updateProfilePhoto,
    required this.updateCompanyLogo,
  }) : super(const UserProfileState());

  /// Loads the user profile from storage
  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await getUserProfile();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (profile) => emit(state.copyWith(
        profile: profile,
        isLoading: false,
        error: null,
      )),
    );
  }

  /// Updates the entire user profile
  Future<void> updateProfile(UserProfile profile) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await saveUserProfile(profile);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (_) => emit(state.copyWith(
        profile: profile,
        isLoading: false,
        isEditing: false,
        error: null,
      )),
    );
  }

  /// Updates only the profile photo
  Future<void> uploadPhoto(List<int> photoBytes) async {
    if (state.profile == null) return;

    emit(state.copyWith(isLoading: true, error: null));

    final result = await updateProfilePhoto(photoBytes);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (_) {
        final updatedProfile = state.profile!.copyWith(
          personalPhotoBytes: photoBytes,
        );
        emit(state.copyWith(
          profile: updatedProfile,
          isLoading: false,
          error: null,
        ));
      },
    );
  }

  /// Updates only the company logo
  Future<void> uploadLogo(List<int> logoBytes) async {
    if (state.profile == null) return;

    emit(state.copyWith(isLoading: true, error: null));

    final result = await updateCompanyLogo(logoBytes);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (_) {
        final updatedProfile = state.profile!.copyWith(
          companyLogoBytes: logoBytes,
        );
        emit(state.copyWith(
          profile: updatedProfile,
          isLoading: false,
          error: null,
        ));
      },
    );
  }

  /// Toggles the professional type between freelancer and company
  Future<void> toggleProfessionalType() async {
    if (state.profile == null) return;

    final newType =
        state.profile!.professionalType == ProfessionalType.freelancer
            ? ProfessionalType.company
            : ProfessionalType.freelancer;

    final updatedProfile = state.profile!.copyWith(
      professionalType: newType,
    );

    await updateProfile(updatedProfile);
  }

  /// Enables editing mode
  void startEditing() {
    emit(state.copyWith(isEditing: true, error: null));
  }

  /// Cancels editing mode
  void cancelEditing() {
    emit(state.copyWith(isEditing: false, error: null));
  }

  /// Clears any error message
  void clearError() {
    emit(state.copyWith(error: null));
  }
}
