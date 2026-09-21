import 'package:flutter/material.dart';
import 'package:kronos/features/config_timer/domain/entities/timer_setup.dart';

class ConfigTimerController extends ChangeNotifier {
  final TimerSetup _setup = TimerSetup();

  double get minutes => _setup.minutes;
  double get seconds => _setup.seconds;

  void updateMinutes(double value) {
    _setup.minutes = value;
    notifyListeners();
  }

  void updateSeconds(double value) {
    _setup.seconds = value;
    notifyListeners();
  }
}
