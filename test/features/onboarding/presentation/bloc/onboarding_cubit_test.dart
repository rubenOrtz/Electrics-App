import 'package:dartz/dartz.dart';
import 'package:electrician_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:electrician_app/features/settings/domain/repositories/user_profile_repository.dart';
import 'package:electrician_app/features/settings/domain/entities/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

class FakeUserProfile extends Fake implements UserProfile {}

void main() {
  group('OnboardingCubit', () {
    late MockUserProfileRepository mockRepo;
    late OnboardingCubit cubit;

    setUp(() {
      mockRepo = MockUserProfileRepository();
      cubit = OnboardingCubit(userProfileRepository: mockRepo);
      registerFallbackValue(FakeUserProfile());
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const OnboardingState());
    });

    test('nextStep increments step', () {
      cubit.nextStep();
      expect(cubit.state.currentStep, 1);
    });

    test('previousStep decrements step', () {
      cubit.nextStep(); // 1
      cubit.previousStep(); // 0
      expect(cubit.state.currentStep, 0);
    });

    test('updatePersonalInfo updates state', () {
      cubit.updatePersonalInfo(name: 'John', email: 'test@test.com');
      expect(cubit.state.personalName, 'John');
      expect(cubit.state.personalEmail, 'test@test.com');
    });

    test('completeOnboarding calls repository', () async {
      // Arrange
      when(() => mockRepo.saveUserProfile(any()))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await cubit.completeOnboarding();

      // Assert
      expect(result, true);
      verify(() => mockRepo.saveUserProfile(any())).called(1);
    });
  });
}
