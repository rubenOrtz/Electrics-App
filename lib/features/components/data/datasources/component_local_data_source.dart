import 'package:isar/isar.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/component_template.dart';
import '../../domain/repositories/component_repository.dart' as domain;
import '../models/component_model.dart';

class ComponentLocalDataSource implements domain.ComponentRepository {
  final Isar isar;

  ComponentLocalDataSource(this.isar);

  @override
  Future<Either<String, List<ComponentTemplate>>> getAll(
      {int offset = 0, int limit = 20}) async {
    try {
      final models = await isar.componentModels
          .where()
          .offset(offset)
          .limit(limit)
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left('Failed to fetch components: $e');
    }
  }

  @override
  Future<Either<String, List<ComponentTemplate>>> getByType(
      domain.ComponentType type,
      {int offset = 0,
      int limit = 20}) async {
    try {
      final modelType = _mapDomainTypeToModelType(type);
      final models = await isar.componentModels
          .filter()
          .typeEqualTo(modelType)
          .offset(offset)
          .limit(limit)
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left('Failed to fetch components by type: $e');
    }
  }

  @override
  Future<Either<String, ComponentTemplate>> getById(String id) async {
    try {
      final model = await isar.componentModels
          .filter()
          .componentIdEqualTo(id)
          .findFirst();
      if (model == null) {
        return const Left('Component not found');
      }
      return Right(model.toDomain());
    } catch (e) {
      return Left('Failed to fetch component: $e');
    }
  }

  @override
  Future<Either<String, List<ComponentTemplate>>> search(String query,
      {int offset = 0, int limit = 20}) async {
    try {
      final models = await isar.componentModels
          .filter()
          .nameContains(query, caseSensitive: false)
          .or()
          .manufacturerContains(query, caseSensitive: false)
          .offset(offset)
          .limit(limit)
          .findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left('Failed to search components: $e');
    }
  }

  @override
  Future<Either<String, List<ComponentTemplate>>> getFavorites() async {
    try {
      final models =
          await isar.componentModels.filter().isFavoriteEqualTo(true).findAll();
      return Right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return Left('Failed to fetch favorites: $e');
    }
  }

  @override
  Future<Either<String, void>> save(ComponentTemplate component) async {
    try {
      await isar.writeTxn(() async {
        final existing = await isar.componentModels
            .filter()
            .componentIdEqualTo(component.id)
            .findFirst();

        final model = ComponentModelMapper.fromDomain(component);

        if (existing != null) {
          model
            ..id = existing.id
            ..createdAt = existing.createdAt
            ..updatedAt = DateTime.now();
        }

        await isar.componentModels.put(model);
      });
      return const Right(null);
    } catch (e) {
      return Left('Failed to save component: $e');
    }
  }

  @override
  Future<Either<String, void>> delete(String id) async {
    try {
      await isar.writeTxn(() async {
        final model = await isar.componentModels
            .filter()
            .componentIdEqualTo(id)
            .findFirst();
        if (model != null) {
          await isar.componentModels.delete(model.id);
        }
      });
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete component: $e');
    }
  }

  @override
  Future<Either<String, void>> toggleFavorite(String id) async {
    try {
      await isar.writeTxn(() async {
        final model = await isar.componentModels
            .filter()
            .componentIdEqualTo(id)
            .findFirst();
        if (model != null) {
          model.isFavorite = !model.isFavorite;
          model.updatedAt = DateTime.now();
          await isar.componentModels.put(model);
        }
      });
      return const Right(null);
    } catch (e) {
      return Left('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<bool> hasSeedData() async {
    final count = await isar.componentModels.count();
    return count > 0;
  }

  @override
  Future<Either<String, void>> loadSeedData() async {
    try {
      await isar.writeTxn(() async {
        await isar.componentModels.clear();
      });

      final seedComponents = _getSeedComponents();

      await isar.writeTxn(() async {
        for (final component in seedComponents) {
          final model = ComponentModelMapper.fromDomain(component);
          await isar.componentModels.put(model);
        }
      });

      return const Right(null);
    } catch (e) {
      return Left('Failed to load seed data: $e');
    }
  }

  ComponentType _mapDomainTypeToModelType(domain.ComponentType type) {
    switch (type) {
      case domain.ComponentType.protection:
        return ComponentType.protection;
      case domain.ComponentType.cable:
        return ComponentType.cable;
      case domain.ComponentType.source:
        return ComponentType.source;
    }
  }

  List<ComponentTemplate> _getSeedComponents() {
    return [
      // --- SCHNEIDER ELECTRIC ---
      // Acti 9 iC60N (MCB)
      const ComponentTemplate.protection(
        id: 'sch-ic60n-10a-2p',
        name: 'Auto iC60N 2P 10A C',
        manufacturer: 'Schneider Electric',
        series: 'Acti 9',
        isFavorite: false,
        ratedCurrent: 10,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 18.50,
      ),
      const ComponentTemplate.protection(
        id: 'sch-ic60n-16a-2p',
        name: 'Auto iC60N 2P 16A C',
        manufacturer: 'Schneider Electric',
        series: 'Acti 9',
        isFavorite: true,
        ratedCurrent: 16,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 19.20,
      ),
      const ComponentTemplate.protection(
        id: 'sch-ic60n-20a-2p',
        name: 'Auto iC60N 2P 20A C',
        manufacturer: 'Schneider Electric',
        series: 'Acti 9',
        isFavorite: false,
        ratedCurrent: 20,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 21.00,
      ),
      const ComponentTemplate.protection(
        id: 'sch-ic60n-25a-2p',
        name: 'Auto iC60N 2P 25A C',
        manufacturer: 'Schneider Electric',
        series: 'Acti 9',
        isFavorite: false,
        ratedCurrent: 25,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 23.50,
      ),
      // Acti 9 iID (RCD)
      const ComponentTemplate.protection(
        id: 'sch-iid-40a-2p-30ma',
        name: 'Dif iID 2P 40A 30mA AC',
        manufacturer: 'Schneider Electric',
        series: 'Acti 9',
        isFavorite: true,
        ratedCurrent: 40,
        curveType: 'AC',
        breakingCapacity: 6, // Nominal
        poles: 2,
        deviceType: ProtectionDeviceType.differential,
        sensitivity: 30,
        price: 45.90,
      ),
      const ComponentTemplate.protection(
        id: 'sch-iid-40a-2p-300ma',
        name: 'Dif iID 2P 40A 300mA AC',
        manufacturer: 'Schneider Electric',
        series: 'Acti 9',
        isFavorite: false,
        ratedCurrent: 40,
        curveType: 'AC',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.differential,
        sensitivity: 300,
        price: 52.00,
      ),

      // --- SIMON ---
      // Simon 68
      const ComponentTemplate.protection(
        id: 'sim-68-10a-1pn',
        name: 'Auto Simon 68 1P+N 10A',
        manufacturer: 'Simon',
        series: 'Simon 68',
        isFavorite: false,
        ratedCurrent: 10,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 9.50,
      ),
      const ComponentTemplate.protection(
        id: 'sim-68-16a-1pn',
        name: 'Auto Simon 68 1P+N 16A',
        manufacturer: 'Simon',
        series: 'Simon 68',
        isFavorite: true,
        ratedCurrent: 16,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 9.80,
      ),
      const ComponentTemplate.protection(
        id: 'sim-68-rcd-40a-30ma',
        name: 'Dif Simon 68 2P 40A 30mA',
        manufacturer: 'Simon',
        series: 'Simon 68',
        isFavorite: false,
        ratedCurrent: 40,
        curveType: 'AC',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.differential,
        sensitivity: 30,
        price: 32.00,
      ),

      // --- SIEMENS ---
      // SENTRON
      const ComponentTemplate.protection(
        id: 'sie-sentron-16a-2p',
        name: 'Auto 5SL6 2P 16A C',
        manufacturer: 'Siemens',
        series: 'SENTRON',
        isFavorite: false,
        ratedCurrent: 16,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 16.50,
      ),
      const ComponentTemplate.protection(
        id: 'sie-sentron-32a-2p',
        name: 'Auto 5SL6 2P 32A C',
        manufacturer: 'Siemens',
        series: 'SENTRON',
        isFavorite: false,
        ratedCurrent: 32,
        curveType: 'C',
        breakingCapacity: 6,
        poles: 2,
        deviceType: ProtectionDeviceType.circuitBreaker,
        price: 24.00,
      ),

      // --- CABLES (PRYSMIAN / GENERAL CABLE) ---
      const ComponentTemplate.cable(
        id: 'cbl-h07vk-1.5',
        name: 'H07V-K 1.5mm² (L.H) Cu',
        manufacturer: 'Prysmian',
        series: 'Afumex',
        isFavorite: true,
        section: 1.5,
        material: CableMaterial.copper,
        insulationType: 'PVC',
        maxOperatingTemp: 70,
        installationMethod: 'B1',
        price: 0.35,
      ),
      const ComponentTemplate.cable(
        id: 'cbl-h07vk-2.5',
        name: 'H07V-K 2.5mm² (L.H) Cu',
        manufacturer: 'Prysmian',
        series: 'Afumex',
        isFavorite: true,
        section: 2.5,
        material: CableMaterial.copper,
        insulationType: 'PVC',
        maxOperatingTemp: 70,
        installationMethod: 'B1',
        price: 0.58,
      ),
      const ComponentTemplate.cable(
        id: 'cbl-h07vk-4',
        name: 'H07V-K 4mm² (L.H) Cu',
        manufacturer: 'Prysmian',
        series: 'Afumex',
        isFavorite: false,
        section: 4.0,
        material: CableMaterial.copper,
        insulationType: 'PVC',
        maxOperatingTemp: 70,
        installationMethod: 'B1',
        price: 0.95,
      ),
      const ComponentTemplate.cable(
        id: 'cbl-h07vk-6',
        name: 'H07V-K 6mm² (L.H) Cu',
        manufacturer: 'Prysmian',
        series: 'Afumex',
        isFavorite: false,
        section: 6.0,
        material: CableMaterial.copper,
        insulationType: 'PVC',
        maxOperatingTemp: 70,
        installationMethod: 'B1',
        price: 1.45,
      ),
      const ComponentTemplate.cable(
        id: 'cbl-rz1k-10',
        name: 'RZ1-K (AS) 10mm² Cu',
        manufacturer: 'General Cable',
        series: 'Exzhellent',
        isFavorite: false,
        section: 10.0,
        material: CableMaterial.copper,
        insulationType: 'XLPE',
        maxOperatingTemp: 90,
        installationMethod: 'E',
        price: 2.80,
      ),
      const ComponentTemplate.cable(
        id: 'cbl-rz1k-16',
        name: 'RZ1-K (AS) 16mm² Cu',
        manufacturer: 'General Cable',
        series: 'Exzhellent',
        isFavorite: false,
        section: 16.0,
        material: CableMaterial.copper,
        insulationType: 'XLPE',
        maxOperatingTemp: 90,
        installationMethod: 'E',
        price: 4.20,
      ),

      // [AI_INSERT_POINT]
    ];
  }
}
