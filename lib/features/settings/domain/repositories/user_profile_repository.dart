import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';

/// Repository interface for user profile operations
abstract class UserProfileRepository {
  /// Retrieves the current user profile
  /// Returns the profile or a Failure if it doesn't exist or there's an error
  Future<Either<Failure, UserProfile>> getUserProfile();

  /// Saves or updates the user profile
  Future<Either<Failure, void>> saveUserProfile(UserProfile profile);

  /// Updates only the personal photo
  Future<Either<Failure, void>> updateProfilePhoto(List<int> photoBytes);

  /// Updates only the company logo
  Future<Either<Failure, void>> updateCompanyLogo(List<int> logoBytes);

  /// Deletes the user profile (for testing purposes)
  Future<Either<Failure, void>> deleteUserProfile();
}
