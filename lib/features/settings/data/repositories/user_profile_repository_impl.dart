import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../models/user_profile_model.dart';

/// Implementation of UserProfileRepository using Isar database
class UserProfileRepositoryImpl implements UserProfileRepository {
  final Isar isar;

  UserProfileRepositoryImpl(this.isar);

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final model = await isar.userProfileModels.get(1);

      if (model == null) {
        // Return a default empty profile if none exists
        return Right(_createDefaultProfile());
      }

      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get user profile: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(UserProfile profile) async {
    try {
      final model = UserProfileModel.fromEntity(profile);

      await isar.writeTxn(() async {
        await isar.userProfileModels.put(model);
      });

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save user profile: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfilePhoto(List<int> photoBytes) async {
    try {
      final model = await isar.userProfileModels.get(1);

      if (model == null) {
        return Left(CacheFailure('Profile not found'));
      }

      model.personalPhotoBytes = photoBytes;

      await isar.writeTxn(() async {
        await isar.userProfileModels.put(model);
      });

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to update profile photo: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCompanyLogo(List<int> logoBytes) async {
    try {
      final model = await isar.userProfileModels.get(1);

      if (model == null) {
        return Left(CacheFailure('Profile not found'));
      }

      model.companyLogoBytes = logoBytes;

      await isar.writeTxn(() async {
        await isar.userProfileModels.put(model);
      });

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to update company logo: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile() async {
    try {
      await isar.writeTxn(() async {
        await isar.userProfileModels.delete(1);
      });

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to delete user profile: $e'));
    }
  }

  /// Creates a default empty profile for first-time users
  UserProfile _createDefaultProfile() {
    return const UserProfile(
      id: '1',
      personalName: '',
      personalEmail: '',
      personalPhone: '',
      personalDni: '',
      engineerId: '',
      professionalType: ProfessionalType.freelancer,
    );
  }
}
