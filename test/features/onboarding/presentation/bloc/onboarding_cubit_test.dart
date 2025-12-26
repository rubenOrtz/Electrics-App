import 'package:dartz/dartz.dart';
import 'package:electrician_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:electrician_app/features/settings/domain/entities/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:electrician_app/features/onboarding/domain/usecases/save_onboarding_data_usecase.dart';

class MockSaveOnboardingDataUseCase extends Mock
    implements SaveOnboardingDataUseCase {}

class FakeUserProfile extends Fake implements UserProfile {}

void main() {
  group('OnboardingCubit', () {
    late MockSaveOnboardingDataUseCase mockSaveDataUseCase;
    late OnboardingCubit cubit;

    setUp(() {
      mockSaveDataUseCase = MockSaveOnboardingDataUseCase();
      cubit = OnboardingCubit(saveDataUseCase: mockSaveDataUseCase);
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

    test('completeOnboarding calls usecase', () async {
      // Arrange
      when(() => mockSaveDataUseCase(
            profile: any(named: 'profile'),
            preferences: any(named: 'preferences'),
          )).thenAnswer((_) async => const Right(true));

      // Act
      final result = await cubit.completeOnboarding();

      // Assert
      expect(result, true);
      verify(() => mockSaveDataUseCase(
            profile: any(named: 'profile'),
            preferences: any(named: 'preferences'),
          )).called(1);
    });
  });
}
