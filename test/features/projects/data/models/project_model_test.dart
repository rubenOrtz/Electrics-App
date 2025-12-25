import 'package:flutter_test/flutter_test.dart';
import 'package:electrician_app/features/projects/data/models/project_model.dart';
import 'package:isar/isar.dart';

void main() {
  group('ProjectModel', () {
    test('can be instantiated and fields set', () {
      final model = ProjectModel()
        ..name = 'Test Project'
        ..client = 'Client A'
        ..createdAt = DateTime(2023, 1, 1)
        ..updatedAt = DateTime(2023, 1, 2)
        ..supplyVoltage = '230V';

      expect(model.name, 'Test Project');
      expect(model.client, 'Client A');
      expect(model.supplyVoltage, '230V');
      // id is autoIncrement (null or default until saved usually, but Isar handles it)
      // We just check current defaults
      expect(model.id, Isar.autoIncrement);
    });
  });
}
