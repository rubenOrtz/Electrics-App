import 'package:freezed_annotation/freezed_annotation.dart';

part 'electrical_state.freezed.dart';
part 'electrical_state.g.dart';

/// Represents the calculated electrical state of a node.
/// These values are derived from load flow or voltage drop calculations.
@freezed
class ElectricalState with _$ElectricalState {
  const factory ElectricalState({
    /// Voltage drop in percentage relative to the source voltage.
    @Default(0.0) double voltageDropPercent,

    /// Short circuit current at this point in Amperes (kA typically, but storing as double for precision).
    @Default(0.0) double shortCircuitCurrentAmps,

    /// Active power flowing through this node in Watts (W).
    @Default(0.0) double activePowerWatts,

    /// Reactive power flowing through this node in VARs.
    @Default(0.0) double reactivePowerVars,

    /// Current flowing through this node in Amperes (A).
    @Default(0.0) double currentAmps,

    /// Voltage level at this node in Volts (V).
    @Default(0.0) double voltageVolts,
  }) = _ElectricalState;

  factory ElectricalState.fromJson(Map<String, dynamic> json) =>
      _$ElectricalStateFromJson(json);
}
