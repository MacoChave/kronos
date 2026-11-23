import 'package:flutter/material.dart';
import 'package:kronos/features/config/domain/entities/time_ranges.dart';
import 'package:kronos/features/config_timer/domain/entities/timer_setup.dart';

class ConfigTimerController extends ChangeNotifier {
  final TimerSetup _setup = TimerSetup();

  double get minutes => _setup.minutes;
  double get seconds => _setup.seconds;

  /// Ajusta los valores actuales para que queden dentro de los rangos.
  void applyRanges(TimeRanges ranges) {
    _setup.minutes = _setup.minutes
        .clamp(ranges.minuteMin.toDouble(), ranges.minuteMax.toDouble())
        .toDouble();
    _setup.seconds = _setup.seconds
        .clamp(ranges.secondMin.toDouble(), ranges.secondMax.toDouble())
        .toDouble();
    notifyListeners();
  }

  void updateMinutes(double value) {
    _setup.minutes = value;
    notifyListeners();
  }

  void updateSeconds(double value) {
    _setup.seconds = value;
    notifyListeners();
  }
}
