import 'package:dartz/dartz.dart';
import 'package:electrician_app/features/projects/domain/entities/project.dart';
import 'package:electrician_app/features/projects/domain/repositories/project_repository.dart';
import 'package:electrician_app/features/projects/presentation/bloc/project_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

class FakeProject extends Fake implements Project {}

void main() {
  group('ProjectCubit', () {
    late MockProjectRepository mockRepo;
    late ProjectCubit cubit;

    setUp(() {
      mockRepo = MockProjectRepository();
      cubit = ProjectCubit(mockRepo);
      registerFallbackValue(FakeProject());
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const ProjectState());
    });

    test('updateProjectName emits new state', () async {
      // Act
      cubit.updateProjectName('New Name');

      // Assert
      expect(cubit.state.projectName, 'New Name');
    });

    test('saveProject emits success when repository returns valid ID',
        () async {
      // Arrange
      when(() => mockRepo.saveProject(any()))
          .thenAnswer((_) async => const Right(123));
      cubit.updateProjectName('Valid Name'); // Set initial state

      // Assert later
      expectLater(
        cubit.stream,
        emitsInOrder([
          // Note: updateProjectName emits a state first, but we are listening AFTER that call usually if using expectLater on stream.
          // However, here we call saveProject AFTER setting up listener? No.
          // With expectLater(stream), we subscribe immediately.
          // Let's rely on checking the emitted states from saveProject call.
          const ProjectState(
              projectName: 'Valid Name',
              isSaving: true,
              errorMessage: null,
              saveSuccess: false),
          const ProjectState(
              projectName: 'Valid Name',
              isSaving: false,
              saveSuccess: true,
              projectId: 123),
        ]),
      );

      // Act
      await cubit.saveProject();
    });
  });
}
