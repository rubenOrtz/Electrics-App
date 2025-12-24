import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:electrician_app/features/diagram/data/repositories/diagram_repository_impl.dart';
import 'package:electrician_app/features/diagram/data/data_sources/cable_presets_data_source.dart';
import 'package:electrician_app/features/diagram/data/data_sources/protection_presets_data_source.dart';
import 'package:electrician_app/features/diagram/domain/entities/cable_definition.dart';
import 'package:electrician_app/features/diagram/domain/entities/protection_definition.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_enums.dart';

class MockCablePresetsDataSource extends Mock
    implements CablePresetsDataSource {}

class MockProtectionPresetsDataSource extends Mock
    implements ProtectionPresetsDataSource {}

void main() {
  late DiagramRepositoryImpl repository;
  late MockCablePresetsDataSource mockCableDataSource;
  late MockProtectionPresetsDataSource mockProtectionDataSource;

  setUp(() {
    mockCableDataSource = MockCablePresetsDataSource();
    mockProtectionDataSource = MockProtectionPresetsDataSource();
    repository = DiagramRepositoryImpl(
      cablePresetsDataSource: mockCableDataSource,
      protectionPresetsDataSource: mockProtectionDataSource,
    );
  });

  group('DiagramRepositoryImpl', () {
    test('getAvailableCables should return data from data source', () {
      // Arrange
      final cables = [
        const CableDefinition(
          id: 'c1',
          name: 'Cable 1',
          description: 'Desc',
          material: ConductorMaterial.copper,
          insulation: CableInsulation.pvc, // Was InsulationType
          maxTemp: 70,
          isFlexible: true,
        ),
      ];
      when(() => mockCableDataSource.getCables()).thenReturn(cables);

      // Act
      final result = repository.getAvailableCables();

      // Assert
      expect(result, cables);
      verify(() => mockCableDataSource.getCables()).called(1);
    });

    test('getAvailableProtections should return data from data source', () {
      // Arrange
      final protections = [
        const ProtectionDefinition(
            id: 'p1',
            name: 'Prot 1',
            type: ProtectionType.circuitBreaker,
            ratingAmps: 10,
            curve: 'C',
            sensitivityMa: 30,
            breakingCapacityKa: 6,
            poles: 2),
      ];
      when(() => mockProtectionDataSource.getProtections())
          .thenReturn(protections);

      // Act
      final result = repository.getAvailableProtections();

      // Assert
      expect(result, protections);
      verify(() => mockProtectionDataSource.getProtections()).called(1);
    });
  });
}
