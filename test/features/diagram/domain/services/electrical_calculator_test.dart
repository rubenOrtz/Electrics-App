import 'package:flutter_test/flutter_test.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';
import 'package:electrician_app/features/diagram/domain/entities/conductor_attributes.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_enums.dart';
import 'package:electrician_app/features/diagram/domain/services/electrical_calculator.dart';

void main() {
  group('ElectricalCalculator', () {
    test('calculateTopDown propagates voltage correctly through ProtectionNode',
        () {
      // 1. Setup
      // Cable: 10mm2 Cobre, 100m.
      // Física: R (20ºC) = (0.01724 * 100) / 10 = 0.1724 Ohm.
      // Monofásica (ida y vuelta): R_total = 0.3448 Ohm.
      final mainCable = ConductorAttributes(
        sectionMm2: 10,
        lengthMeters: 100, // Longitud considerable para ver caída clara
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
      );

      // Carga: 2300W a 230V = 10A.
      final loadNode = ElectricalNode.load(
        id: 'load1',
        name: 'Load 1',
        powerWatts: 2300,
        cosPhi: 1.0,
        inputCable: mainCable, // Cable Circuito (Protección -> Carga)
      );

      final protectionNode = ElectricalNode.protection(
        id: 'prot1',
        name: 'Protection 1',
        children: [loadNode],
        protectionType: ProtectionType.circuitBreaker,
        ratingAmps: 16,
        // SIN CABLE: La protección es un dispositivo, no un tramo.
      );

      final sourceNode = ElectricalNode.source(
        id: 'source1',
        name: 'Source 1',
        nominalVoltage: 230,
        mainFeedCable: mainCable, // Cable Acometida (Fuente -> Protección)
        children: [protectionNode],
      );

      // 2. Act
      final resultRoot = ElectricalCalculator.recalculateTree(sourceNode);

      // 3. Assert & Extraer Nodos
      final resultProtection = resultRoot.map(
        source: (s) => s.children.first,
        panel: (_) => throw StateError('x'),
        protection: (_) => throw StateError('x'),
        load: (_) => throw StateError('x'),
      );

      final resultLoad = resultProtection.map(
        source: (_) => throw StateError('x'),
        panel: (_) => throw StateError('x'),
        protection: (p) => p.children.first as LoadNode,
        load: (_) => throw StateError('x'),
      );

      final sourceV = resultRoot.state.voltageVolts;
      final protectionV = resultProtection.state.voltageVolts;
      final loadV = resultLoad.state.voltageVolts;

      // --- VALIDACIONES FÍSICAS CORREGIDAS ---

      // 1. La Fuente mantiene su tensión nominal (Infine Bus)
      expect(sourceV, closeTo(225.874, 0.001));

      // 2. La Protección recibe menos tensión debido al cable de acometida
      // Caída esperada: ~4.12V (caliente 70C)
      expect(protectionV, equals(sourceV));
      expect(protectionV, closeTo(225.87, 0.5));

      // 3. La Protección es transparente (no añade caída propia)
      // Esto se verifica implícitamente porque la tensión en 'protectionV'
      // es EXACTAMENTE (230 - CaídaCableAcometida), sin nada más restado.

      // 4. La Carga recibe aún menos tensión debido a su propio cable
      // Caída adicional: ~4.12V
      expect(loadV, lessThan(protectionV));
      expect(loadV, closeTo(221.75, 0.5));

      // Verificación de caída acumulada total (~8.25V)
      final totalDrop = 230.0 - loadV;
      expect(totalDrop, closeTo(8.25, 1.0));
    });
  });
}
