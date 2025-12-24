import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/diagram_repository.dart';
import '../../domain/entities/electrical_node.dart';
import '../../domain/entities/cable_definition.dart';
import '../../domain/entities/protection_definition.dart';
import '../data_sources/cable_presets_data_source.dart';
import '../data_sources/protection_presets_data_source.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/electrical_node_dto.dart';

class DiagramRepositoryImpl implements DiagramRepository {
  final CablePresetsDataSource _cableDataSource;
  final ProtectionPresetsDataSource _protectionDataSource;

  DiagramRepositoryImpl({
    required CablePresetsDataSource cablePresetsDataSource,
    required ProtectionPresetsDataSource protectionPresetsDataSource,
  })  : _cableDataSource = cablePresetsDataSource,
        _protectionDataSource = protectionPresetsDataSource;

  @override
  List<CableDefinition> getAvailableCables() {
    return _cableDataSource.getCables();
  }

  @override
  List<ProtectionDefinition> getAvailableProtections() {
    return _protectionDataSource.getProtections();
  }

  @override
  Future<Either<Failure, ElectricalNode>> saveDiagram(
      ElectricalNode root) async {
    try {
      final dto = root.toDto();
      final jsonMap = dto.toJson();
      final jsonString = jsonEncode(jsonMap);

      final dir = await getApplicationDocumentsDirectory();
      final diagramsDir = Directory('${dir.path}/diagrams');
      if (!await diagramsDir.exists()) {
        await diagramsDir.create(recursive: true);
      }

      final file = File('${diagramsDir.path}/${root.id}.json');
      await file.writeAsString(jsonString);

      return Right(root);
    } catch (e) {
      return Left(CacheFailure("Failed to save diagram: $e"));
    }
  }

  @override
  Future<Either<Failure, ElectricalNode>> loadDiagram(String diagramId) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/diagrams/$diagramId.json');

      if (!await file.exists()) {
        return const Left(CacheFailure("Diagram not found"));
      }

      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString);
      final dto = ElectricalNodeDto.fromJson(jsonMap);
      return Right(dto.toDomain());
    } catch (e) {
      return Left(CacheFailure("Failed to load diagram: $e"));
    }
  }

  @override
  Future<Either<Failure, List<ElectricalNode>>> getSavedDiagrams() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final diagramsDir = Directory('${dir.path}/diagrams');
      if (!await diagramsDir.exists()) {
        return const Right([]);
      }

      final List<ElectricalNode> diagrams = [];
      await for (final file in diagramsDir.list()) {
        if (file is File && file.path.endsWith('.json')) {
          try {
            final jsonString = await file.readAsString();
            final jsonMap = jsonDecode(jsonString);
            final dto = ElectricalNodeDto.fromJson(jsonMap);
            diagrams.add(dto.toDomain());
          } catch (e) {
            // Skip invalid diagram files
          }
        }
      }
      return Right(diagrams);
    } catch (e) {
      return Left(CacheFailure("Failed to list diagrams: $e"));
    }
  }
}
