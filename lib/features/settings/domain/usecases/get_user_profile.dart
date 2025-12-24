import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_profile_repository.dart';
import '../entities/user_profile.dart';

/// Use case for retrieving the user's profile
class GetUserProfile {
  final UserProfileRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, UserProfile>> call() {
    return repository.getUserProfile();
  }
}
