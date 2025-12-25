import 'package:electrician_app/features/diagram/domain/entities/electrical_enums.dart';
import 'package:electrician_app/features/diagram/domain/services/electrical_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ElectricalCalculator.calculateIz', () {
    test('Standard Lookup: PVC Copper B1 1.5mm2 (30C, 1 circuit)', () {
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 1.5,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        method: InstallationMethod.b1,
        factors: const CorrectionFactors(
          ambientTemperature: 30.0,
          numberOfCircuits: 1,
        ),
      );
      // Table B.52.2 says 17.5 A for B1 2x PVC Cu 1.5
      expect(iz, 17.5);
    });

    test('Standard Lookup: XLPE Copper D 25mm2 (20C, 1 circuit) - Buried', () {
      // Table D for XLPE Copper 25mm2 is 121 A (Ground 20C)
      // Temp correction ground 20C is 1.0.
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 25.0,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.xlpe,
        method: InstallationMethod.d,
        factors: const CorrectionFactors(
          ambientTemperature: 20.0,
          numberOfCircuits: 1,
          soilResistivity: 2.5,
        ),
      );
      expect(iz, 121.0);
    });

    test('Interpolation: PVC Copper B1 5.0mm2 (30C, 1 circuit)', () {
      // 4mm2 -> 32 A
      // 6mm2 -> 41 A
      // 5mm2 is mid-way. Expected: 32 + (41-32)/2 = 36.5 A
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 5.0,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        method: InstallationMethod.b1,
        factors: const CorrectionFactors(),
      );
      expect(iz, 36.5);
    });

    test('Temperature Correction: PVC Air 40C', () {
      // PVC Air 40C factor is 0.87 (Table B.52.14)
      // Base: B1 1.5mm2 -> 17.5 A
      // Expected: 17.5 * 0.87 = 15.225
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 1.5,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        method: InstallationMethod.b1,
        factors: const CorrectionFactors(
          ambientTemperature: 40.0,
        ),
      );
      expect(iz, closeTo(15.225, 0.001));
    });

    test('Temperature Correction: XLPE Ground 15C', () {
      // XLPE Ground 15C factor is 1.04 (Table B.52.15)
      // Base: D 25mm2 -> 121 A
      // Expected: 121 * 1.04 = 125.84
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 25.0,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.xlpe,
        method: InstallationMethod.d,
        factors: const CorrectionFactors(
          ambientTemperature: 15.0,
        ),
      );
      expect(iz, closeTo(125.84, 0.001));
    });

    test('Grouping Correction: 3 Circuits (Method C)', () {
      // Factor for 3 circuits in Method C is 0.79 (Table C.52.3)
      // Base: C 1.5mm2 PVC Cu -> 19.5 A (Table B.52.2 C)
      // Expected: 19.5 * 0.79 = 15.405
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 1.5,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        method: InstallationMethod.c,
        factors: const CorrectionFactors(
          numberOfCircuits: 3,
        ),
      );
      expect(iz, closeTo(15.405, 0.001));
    });

    test('Outside Range: Section 0.5mm2 returns 0.0', () {
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: 0.5,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        method: InstallationMethod.b1,
        factors: const CorrectionFactors(),
      );
      expect(iz, 0.0);
    });
  });
}
