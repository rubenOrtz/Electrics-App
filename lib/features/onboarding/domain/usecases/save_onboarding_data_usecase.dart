import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../settings/domain/entities/user_profile.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/onboarding_preferences.dart';

class SaveOnboardingDataUseCase {
  final SettingsRepository _settingsRepo;

  SaveOnboardingDataUseCase(this._settingsRepo);

  Future<Either<Failure, void>> call({
    required UserProfile profile,
    required OnboardingPreferences preferences,
  }) async {
    return await _settingsRepo.saveOnboardingDataTransaction(
      profile: profile,
      preferences: preferences,
    );
  }
}
