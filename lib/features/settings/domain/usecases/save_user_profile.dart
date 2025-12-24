import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_profile_repository.dart';
import '../entities/user_profile.dart';

/// Use case for saving or updating the user's profile
class SaveUserProfile {
  final UserProfileRepository repository;

  SaveUserProfile(this.repository);

  Future<Either<Failure, void>> call(UserProfile profile) {
    return repository.saveUserProfile(profile);
  }
}
