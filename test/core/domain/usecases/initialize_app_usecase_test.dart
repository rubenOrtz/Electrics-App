import 'package:dartz/dartz.dart';
import 'package:electrician_app/core/domain/entities/app_initialization_result.dart';
import 'package:electrician_app/core/domain/usecases/initialize_app_usecase.dart';
import 'package:electrician_app/features/components/domain/repositories/component_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockComponentRepository extends Mock implements ComponentRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('InitializeAppUseCase', () {
    late MockComponentRepository mockComponentRepository;
    late MockSharedPreferences mockSharedPreferences;
    late InitializeAppUseCase useCase;

    setUp(() {
      mockComponentRepository = MockComponentRepository();
      mockSharedPreferences = MockSharedPreferences();
      useCase = InitializeAppUseCase(
        componentRepository: mockComponentRepository,
        prefs: mockSharedPreferences,
      );
    });

    group('successful initialization', () {
      test(
          'should return success with shouldShowOnboarding=true when seed data exists and onboarding not completed',
          () async {
        // Arrange
        when(() => mockComponentRepository.hasSeedData())
            .thenAnswer((_) async => true);
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenReturn(false);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, true);
        expect(result.shouldShowOnboarding, true);
        expect(result.error, isNull);
        expect(result.stackTrace, isNull);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verify(() => mockSharedPreferences.getBool('onboarding_completed'))
            .called(1);
        verifyNever(() => mockComponentRepository.loadSeedData());
      });

      test(
          'should return success with shouldShowOnboarding=false when onboarding completed',
          () async {
        // Arrange
        when(() => mockComponentRepository.hasSeedData())
            .thenAnswer((_) async => true);
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenReturn(true);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, true);
        expect(result.shouldShowOnboarding, false);
        expect(result.error, isNull);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verify(() => mockSharedPreferences.getBool('onboarding_completed'))
            .called(1);
        verifyNever(() => mockComponentRepository.loadSeedData());
      });

      test(
          'should return success with shouldShowOnboarding=true when getBool returns null (first launch)',
          () async {
        // Arrange
        when(() => mockComponentRepository.hasSeedData())
            .thenAnswer((_) async => true);
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenReturn(null);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, true);
        expect(result.shouldShowOnboarding, true);
        expect(result.error, isNull);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verify(() => mockSharedPreferences.getBool('onboarding_completed'))
            .called(1);
      });

      test('should load seed data when it does not exist', () async {
        // Arrange
        when(() => mockComponentRepository.hasSeedData())
            .thenAnswer((_) async => false);
        when(() => mockComponentRepository.loadSeedData())
            .thenAnswer((_) async => const Right(null));
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenReturn(false);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, true);
        expect(result.shouldShowOnboarding, true);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verify(() => mockComponentRepository.loadSeedData()).called(1);
        verify(() => mockSharedPreferences.getBool('onboarding_completed'))
            .called(1);
      });
    });

    group('error scenarios', () {
      test('should return failure when hasSeedData throws exception', () async {
        // Arrange
        const errorMessage = 'Database error';
        when(() => mockComponentRepository.hasSeedData())
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, false);
        expect(result.shouldShowOnboarding, false);
        expect(result.error, contains(errorMessage));
        expect(result.stackTrace, isNotNull);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verifyNever(() => mockComponentRepository.loadSeedData());
        verifyNever(() => mockSharedPreferences.getBool(any()));
      });

      test('should return failure when loadSeedData throws exception',
          () async {
        // Arrange
        const errorMessage = 'Failed to load seed data';
        when(() => mockComponentRepository.hasSeedData())
            .thenAnswer((_) async => false);
        when(() => mockComponentRepository.loadSeedData())
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, false);
        expect(result.shouldShowOnboarding, false);
        expect(result.error, contains(errorMessage));
        expect(result.stackTrace, isNotNull);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verify(() => mockComponentRepository.loadSeedData()).called(1);
        verifyNever(() => mockSharedPreferences.getBool(any()));
      });

      test('should return failure when SharedPreferences throws exception',
          () async {
        // Arrange
        const errorMessage = 'SharedPreferences error';
        when(() => mockComponentRepository.hasSeedData())
            .thenAnswer((_) async => true);
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, false);
        expect(result.shouldShowOnboarding, false);
        expect(result.error, contains(errorMessage));
        expect(result.stackTrace, isNotNull);
        verify(() => mockComponentRepository.hasSeedData()).called(1);
        verify(() => mockSharedPreferences.getBool('onboarding_completed'))
            .called(1);
      });

      test('should handle generic errors gracefully', () async {
        // Arrange
        const errorMessage = 'Unknown error';
        when(() => mockComponentRepository.hasSeedData())
            .thenThrow(errorMessage);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result.isSuccess, false);
        expect(result.shouldShowOnboarding, false);
        expect(result.error, errorMessage);
        expect(result.stackTrace, isNotNull);
      });
    });

    group('initialization sequence', () {
      test('should follow correct execution order', () async {
        // Arrange
        final executionOrder = <String>[];
        when(() => mockComponentRepository.hasSeedData()).thenAnswer((_) async {
          executionOrder.add('hasSeedData');
          return false;
        });
        when(() => mockComponentRepository.loadSeedData()).thenAnswer((_) async {
          executionOrder.add('loadSeedData');
          return const Right(null);
        });
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenAnswer((_) {
          executionOrder.add('getBool');
          return false;
        });

        // Act
        await useCase.call();

        // Assert
        expect(executionOrder, ['hasSeedData', 'loadSeedData', 'getBool']);
      });

      test('should skip loadSeedData when seed data exists', () async {
        // Arrange
        final executionOrder = <String>[];
        when(() => mockComponentRepository.hasSeedData()).thenAnswer((_) async {
          executionOrder.add('hasSeedData');
          return true;
        });
        when(() => mockSharedPreferences.getBool('onboarding_completed'))
            .thenAnswer((_) {
          executionOrder.add('getBool');
          return false;
        });

        // Act
        await useCase.call();

        // Assert
        expect(executionOrder, ['hasSeedData', 'getBool']);
        verifyNever(() => mockComponentRepository.loadSeedData());
      });
    });
  });
}
