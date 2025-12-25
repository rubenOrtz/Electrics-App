import 'package:dartz/dartz.dart';
import 'package:electrician_app/core/error/failures.dart';
import 'package:electrician_app/features/projects/data/datasources/project_local_data_source.dart';
import 'package:electrician_app/features/projects/data/models/project_model.dart';
import 'package:electrician_app/features/projects/data/repositories/project_repository_impl.dart';
import 'package:electrician_app/features/projects/domain/entities/project.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProjectLocalDataSource extends Mock
    implements ProjectLocalDataSource {}

class FakeProjectModel extends Fake implements ProjectModel {}

void main() {
  group('ProjectRepositoryImpl', () {
    late MockProjectLocalDataSource mockDataSource;
    late ProjectRepositoryImpl repository;

    setUp(() {
      mockDataSource = MockProjectLocalDataSource();
      repository = ProjectRepositoryImpl(mockDataSource);
      registerFallbackValue(FakeProjectModel());
      registerFallbackValue(ProjectModel());
    });

    group('getProjects', () {
      test(
          'should return list of projects when call to data source is successful',
          () async {
        // Arrange
        final models = [
          ProjectModel()
            ..name = 'Test Project'
            ..id = 1
            ..createdAt = DateTime.now()
            ..updatedAt = DateTime.now()
        ];
        when(() => mockDataSource.getProjects())
            .thenAnswer((_) async => models);

        // Act
        final result = await repository.getProjects();

        // Assert
        verify(() => mockDataSource.getProjects());

        result.fold(
          (failure) {
            fail('Should have been Right, but was Left: ${failure.message}');
          },
          (projects) {
            expect(projects.length, 1);
            expect(projects.first.name, 'Test Project');
          },
        );
      });

      test('should return CacheFailure when call to data source fails',
          () async {
        // Arrange
        when(() => mockDataSource.getProjects())
            .thenThrow(CacheFailure('DB Error'));

        // Act
        final result = await repository.getProjects();

        // Assert
        verify(() => mockDataSource.getProjects());
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, contains('DB Error'));
          },
          (projects) => fail('Should have been Left'),
        );
      });
    });

    group('saveProject', () {
      final tProject = Project(
        name: 'New Project',
        client: 'Client',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      test('should return project ID when save is successful', () async {
        // Arrange
        when(() => mockDataSource.saveProject(any()))
            .thenAnswer((_) async => 123);

        // Act
        final result = await repository.saveProject(tProject);

        // Assert
        verify(() => mockDataSource.saveProject(any()));
        expect(result, const Right(123));
      });

      test('should return CacheFailure when save fails', () async {
        // Arrange
        when(() => mockDataSource.saveProject(any()))
            .thenThrow(CacheFailure('Save Error'));

        // Act
        final result = await repository.saveProject(tProject);

        // Assert
        verify(() => mockDataSource.saveProject(any()));
        expect(result.isLeft(), true);
      });
    });
  });
}
