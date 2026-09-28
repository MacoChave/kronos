import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kronos/features/timer/data/service/audio_service.dart';
import 'package:kronos/features/timer/data/service/vibration_service.dart';
import 'package:kronos/features/timer/domain/entities/timer_config.dart';

class TimerController extends ChangeNotifier {
  final TimerConfig config;
  final VibrationService _vibrationService = VibrationService();
  final AudioService _audioService = AudioService();

  late int remainingSeconds;
  Timer? _timer;

  TimerController({required this.config}) {
    _audioService.preload();
    resetTimer();
  }

  void resetTimer() {
    _timer?.cancel();
    _vibrationService.cancel();
    _audioService.stop();
    remainingSeconds = config.totalSeconds;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    if (remainingSeconds <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        _handleTimeEffects(remainingSeconds);
        notifyListeners();

        if (remainingSeconds == 0) {
          _timer?.cancel();
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  void _handleTimeEffects(int seconds) {
    if (seconds >= 6 && seconds <= 10) {
      // Vibra fuerte a cada segundo del 10 al 6to segundo
      _vibrationService.vibrateStrong();
    } else if (seconds >= 1 && seconds <= 5) {
      // Reproduce archivo de sonido del 5 al 1er segundo
      _audioService.playCountdownTick();
    } else if (seconds == 0) {
      // Reproduce otro archivo de sonido cuando se acaba el tiempo
      _audioService.playTimeUp();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _vibrationService.cancel();
    _audioService.stop();
    super.dispose();
  }
}
