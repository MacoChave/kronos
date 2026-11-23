/// Rangos configurables de minutos y segundos para el selector de tiempo.
class TimeRanges {
  final int minuteMin;
  final int minuteMax;
  final int secondMin;
  final int secondMax;

  const TimeRanges({
    this.minuteMin = 1,
    this.minuteMax = 10,
    this.secondMin = 0,
    this.secondMax = 59,
  });

  /// El mínimo debe ser menor que el máximo y dentro de los límites
  /// (minutos 0–99, segundos 0–59).
  bool get isValid =>
      minuteMin >= 0 &&
      minuteMax <= 99 &&
      minuteMin < minuteMax &&
      secondMin >= 0 &&
      secondMax <= 59 &&
      secondMin < secondMax;

  TimeRanges copyWith({
    int? minuteMin,
    int? minuteMax,
    int? secondMin,
    int? secondMax,
  }) {
    return TimeRanges(
      minuteMin: minuteMin ?? this.minuteMin,
      minuteMax: minuteMax ?? this.minuteMax,
      secondMin: secondMin ?? this.secondMin,
      secondMax: secondMax ?? this.secondMax,
    );
  }
}
