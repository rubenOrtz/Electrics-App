import 'package:electrician_app/features/calculator/domain/entities/conductor.dart';
import 'package:electrician_app/features/calculator/domain/usecases/electrical_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ElectricalMath (Single Phase Rules)', () {
    // CASO 1: Caída de Tensión (Usando Resistividad a 20ºC)
    // Documento: Rho Cu = 0.01724
    // Formula: e = (2 * rho * L * I) / S
    test('calculateVoltageDrop - Single Phase (Copper 20ºC)', () {
      // Datos: 100m, 10A, 4mm2, Cobre, 230V
      // Cálculo: (2 * 0.01724 * 100 * 10) / 4
      //        = 34.48 / 4
      //        = 8.62 V

      final result = ElectricalMath.calculateVoltageDrop(
        length: 100,
        current: 10,
        section: 4,
        material: ConductorMaterial.copper,
        // La aislación no afecta la resistividad a 20ºC, pero se pasa por compatibilidad
        insulation: ConductorInsulation.pvc,
        system: VoltageSystem.singlePhase,
      );

      expect(result, closeTo(8.62, 0.01));
    });

    // CASO 2: Caída de Tensión Aluminio
    // Documento: Rho Al = 0.02826
    test('calculateVoltageDrop - Single Phase (Aluminum 20ºC)', () {
      // Datos: 100m, 10A, 6mm2, Aluminio
      // Cálculo: (2 * 0.02826 * 100 * 10) / 6
      //        = 56.52 / 6
      //        = 9.42 V

      final result = ElectricalMath.calculateVoltageDrop(
        length: 100,
        current: 10,
        section: 6,
        material: ConductorMaterial.aluminum,
        insulation: ConductorInsulation.xlpe,
        system: VoltageSystem.singlePhase,
      );

      expect(result, closeTo(9.42, 0.01));
    });

    // CASO 3: Corriente Monofásica (Ley de Ohm/Watt básica)
    // Formula: I = P / (V * cosPhi)
    test('calculateCurrent - Single Phase', () {
      // 5kW (5000W), 230V, cosPhi 0.9
      // I = 5000 / (230 * 0.9)
      // I = 5000 / 207
      // I = 24.154 A

      final result = ElectricalMath.calculateCurrent(
        powerWatts: 5000,
        voltage: 230,
        system: VoltageSystem.singlePhase, // Forzamos monofásica
        powerFactor: 0.9,
      );

      expect(result, closeTo(24.15, 0.01));
    });

    // CASO 4: El "Bug" de la Carga 2 corregido
    // Verificar que si el cosPhi es 1.0 da el valor resistivo puro
    test('calculateCurrent - Resistive Load (Heating)', () {
      // 1kW, 230V, cosPhi 1.0
      // I = 1000 / 230 = 4.347 A

      final result = ElectricalMath.calculateCurrent(
        powerWatts: 1000,
        voltage: 230,
        system: VoltageSystem.singlePhase,
        powerFactor: 1.0,
      );

      expect(result, closeTo(4.35, 0.01));
    });
  });
}
