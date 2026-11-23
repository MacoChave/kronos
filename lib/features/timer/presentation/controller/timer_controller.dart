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
    resetTimer(playSound: false);
  }

  /// [playSound] es false en el arranque inicial (sin doble bip).
  void resetTimer({bool playSound = true}) {
    _timer?.cancel();
    _vibrationService.cancel();
    _audioService.stop();
    if (playSound) _audioService.playDoubleBeep();
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
    // Doble bip al llegar a 1:00 y a 0:30
    if (seconds == 60 || seconds == 30) {
      _audioService.playDoubleBeep();
    }

    // Vibración fuerte desde el segundo 30 hasta el 1, a intensidad máxima
    if (seconds >= 1 && seconds <= 30) {
      _vibrationService.vibrateWithIntensity(1.0);
    }

    // Bip a volumen máximo desde el segundo 20 hasta el 1
    if (seconds >= 1 && seconds <= 20) {
      _audioService.playBeep(1.0);
    }

    // Doble bip al terminarse el tiempo
    if (seconds == 0) {
      _audioService.playDoubleBeep();
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
