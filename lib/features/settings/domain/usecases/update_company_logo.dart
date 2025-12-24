import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_profile_repository.dart';

/// Use case for updating the company logo
class UpdateCompanyLogo {
  final UserProfileRepository repository;

  UpdateCompanyLogo(this.repository);

  Future<Either<Failure, void>> call(List<int> logoBytes) {
    return repository.updateCompanyLogo(logoBytes);
  }
}
