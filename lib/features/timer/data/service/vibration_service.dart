import 'package:vibration/vibration.dart';

class VibrationService {
  Future<void> vibrateBasedOnTime(int remainingSeconds) async {
    if (!await Vibration.hasVibrator()) return;
    if (!await Vibration.hasAmplitudeControl()) return;
    if (!await Vibration.hasCustomVibrationsSupport()) return;

    if (remainingSeconds <= 5) {
      Vibration.vibrate(duration: 500, amplitude: 255); // Vibración fuerte
    } else if (remainingSeconds <= 10) {
      Vibration.vibrate(duration: 500, amplitude: 191); // Vibración media
    } else if (remainingSeconds <= 15) {
      Vibration.vibrate(duration: 500, amplitude: 128); // Vibración suave
    }
  }
}
