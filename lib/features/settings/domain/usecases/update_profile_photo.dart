import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_profile_repository.dart';

/// Use case for updating the profile photo
class UpdateProfilePhoto {
  final UserProfileRepository repository;

  UpdateProfilePhoto(this.repository);

  Future<Either<Failure, void>> call(List<int> photoBytes) {
    return repository.updateProfilePhoto(photoBytes);
  }
}
