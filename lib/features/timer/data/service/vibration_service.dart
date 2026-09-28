import 'package:vibration/vibration.dart';

class VibrationService {
  Future<void> vibrateStrong() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != true) return;

    final hasAmplitude = await Vibration.hasAmplitudeControl();
    if (hasAmplitude == true) {
      Vibration.vibrate(duration: 500, amplitude: 255);
    } else {
      Vibration.vibrate(duration: 500);
    }
  }

  void vibrateBasedOnTime(int remainingSeconds) {
    // Vibra fuerte cada segundo del 10 al 6to segundo
    if (remainingSeconds >= 6 && remainingSeconds <= 10) {
      vibrateStrong();
    }
  }

  void cancel() {
    Vibration.cancel();
  }
}
