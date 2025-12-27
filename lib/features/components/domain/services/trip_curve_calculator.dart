import 'dart:math' as math;

/// Trip curve calculator based on IEC 60898 standard for circuit breakers
// ignore_for_file: non_constant_identifier_names
class TripCurveCalculator {
  /// Calculate trip curve boundaries for a protection device
  /// Returns list of (current multiple, time in seconds) points
  static TripCurveData calculateCurve({
    required String curveType,
    required double ratedCurrent,
  }) {
    switch (curveType.toUpperCase()) {
      case 'B':
        return _calculateCurveB(ratedCurrent);
      case 'C':
        return _calculateCurveC(ratedCurrent);
      case 'D':
        return _calculateCurveD(ratedCurrent);
      case 'K':
        return _calculateCurveK(ratedCurrent);
      case 'Z':
        return _calculateCurveZ(ratedCurrent);
      default:
        return _calculateCurveC(ratedCurrent); // Default to C
    }
  }

  /// Curve B: Fast for residential (3-5x In magnetic trip)
  static TripCurveData _calculateCurveB(double In) {
    return TripCurveData(
      curveType: 'B',
      ratedCurrent: In,
      minPoints: [
        // Thermal zone (below magnetic trip)
        CurvePoint(1.13, 3600), // 1.13 x In: 1 hour no trip
        CurvePoint(1.45, 60), // 1.45 x In: 1 minute min trip
        // Magnetic trip zone start
        CurvePoint(3.0, 0.1), // 3 x In: magnetic min
        CurvePoint(5.0, 0.01), // 5 x In:fast trip
      ],
      maxPoints: [
        CurvePoint(1.13, 7200), // 1.13 x In: 2 hours max
        CurvePoint(1.45, 120), // 1.45 x In: 2 minutes max trip
        CurvePoint(3.0, 5.0), // 3 x In: magnetic max delay
        CurvePoint(5.0, 0.1), // 5 x In: instant
      ],
      magneticTripMin: 3.0,
      magneticTripMax: 5.0,
    );
  }

  /// Curve C: Standard for general use (5-10x In magnetic trip)
  static TripCurveData _calculateCurveC(double In) {
    return TripCurveData(
      curveType: 'C',
      ratedCurrent: In,
      minPoints: [
        CurvePoint(1.13, 3600),
        CurvePoint(1.45, 60),
        CurvePoint(5.0, 0.1),
        CurvePoint(10.0, 0.01),
      ],
      maxPoints: [
        CurvePoint(1.13, 7200),
        CurvePoint(1.45, 120),
        CurvePoint(5.0, 5.0),
        CurvePoint(10.0, 0.1),
      ],
      magneticTripMin: 5.0,
      magneticTripMax: 10.0,
    );
  }

  /// Curve D: For motors/transformers (10-20x In magnetic trip)
  static TripCurveData _calculateCurveD(double In) {
    return TripCurveData(
      curveType: 'D',
      ratedCurrent: In,
      minPoints: [
        CurvePoint(1.13, 3600),
        CurvePoint(1.45, 60),
        CurvePoint(10.0, 0.1),
        CurvePoint(20.0, 0.01),
      ],
      maxPoints: [
        CurvePoint(1.13, 7200),
        CurvePoint(1.45, 120),
        CurvePoint(10.0, 5.0),
        CurvePoint(20.0, 0.1),
      ],
      magneticTripMin: 10.0,
      magneticTripMax: 20.0,
    );
  }

  /// Curve K: For motor protection (8-14x In)
  static TripCurveData _calculateCurveK(double In) {
    return TripCurveData(
      curveType: 'K',
      ratedCurrent: In,
      minPoints: [
        CurvePoint(1.05, 3600),
        CurvePoint(1.2, 60),
        CurvePoint(8.0, 0.1),
        CurvePoint(14.0, 0.01),
      ],
      maxPoints: [
        CurvePoint(1.05, 7200),
        CurvePoint(1.2, 120),
        CurvePoint(8.0, 5.0),
        CurvePoint(14.0, 0.1),
      ],
      magneticTripMin: 8.0,
      magneticTripMax: 14.0,
    );
  }

  /// Curve Z: Sensitive for electronics (2-3x In)
  static TripCurveData _calculateCurveZ(double In) {
    return TripCurveData(
      curveType: 'Z',
      ratedCurrent: In,
      minPoints: [
        CurvePoint(1.13, 3600),
        CurvePoint(1.45, 60),
        CurvePoint(2.0, 0.1),
        CurvePoint(3.0, 0.01),
      ],
      maxPoints: [
        CurvePoint(1.13, 7200),
        CurvePoint(1.45, 120),
        CurvePoint(2.0, 5.0),
        CurvePoint(3.0, 0.1),
      ],
      magneticTripMin: 2.0,
      magneticTripMax: 3.0,
    );
  }

  /// Interpolate points for smooth curve rendering
  static List<CurvePoint> interpolate(List<CurvePoint> points,
      {int targetPoints = 50}) {
    if (points.length < 2) return points;

    final result = <CurvePoint>[];

    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      // Logarithmic interpolation
      final logI1 = math.log(p1.currentMultiple);
      final logI2 = math.log(p2.currentMultiple);
      final logT1 = math.log(p1.timeSeconds);
      final logT2 = math.log(p2.timeSeconds);

      final segmentPoints = (targetPoints / (points.length - 1)).round();

      for (var j = 0; j < segmentPoints; j++) {
        final t = j / segmentPoints;
        final logI = logI1 + (logI2 - logI1) * t;
        final logT = logT1 + (logT2 - logT1) * t;

        result.add(CurvePoint(math.exp(logI), math.exp(logT)));
      }
    }

    result.add(points.last);
    return result;
  }
}

/// Data class for trip curve information
class TripCurveData {
  final String curveType;
  final double ratedCurrent;
  final List<CurvePoint> minPoints;
  final List<CurvePoint> maxPoints;
  final double magneticTripMin;
  final double magneticTripMax;

  TripCurveData({
    required this.curveType,
    required this.ratedCurrent,
    required this.minPoints,
    required this.maxPoints,
    required this.magneticTripMin,
    required this.magneticTripMax,
  });

  /// Get interpolated min curve for rendering
  List<CurvePoint> getInterpolatedMin({int points = 100}) {
    return TripCurveCalculator.interpolate(minPoints, targetPoints: points);
  }

  /// Get interpolated max curve for rendering
  List<CurvePoint> getInterpolatedMax({int points = 100}) {
    return TripCurveCalculator.interpolate(maxPoints, targetPoints: points);
  }
}

/// Single point on a trip curve (current multiple, time)
class CurvePoint {
  final double currentMultiple; // Multiple of In (e.g., 5.0 = 5 x In)
  final double timeSeconds; // Trip time in seconds

  CurvePoint(this.currentMultiple, this.timeSeconds);

  @override
  String toString() =>
      'CurvePoint(${currentMultiple.toStringAsFixed(1)}xIn, ${timeSeconds.toStringAsFixed(3)}s)';
}
