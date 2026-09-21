import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kronos/features/timer/data/service/vibration_service.dart';
import 'package:kronos/features/timer/domain/entities/timer_config.dart';

class TimerController extends ChangeNotifier {
  final TimerConfig config;
  final VibrationService _vibrationService = VibrationService();

  late int remainingSeconds;
  Timer? _timer;

  TimerController({required this.config}) {
    resetTimer();
  }

  void resetTimer() {
    remainingSeconds = config.totalSeconds;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        _vibrationService.vibrateBasedOnTime(remainingSeconds);
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
