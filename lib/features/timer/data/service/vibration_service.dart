import 'package:vibration/vibration.dart';

class VibrationService {
  /// Vibra con [intensity] entre 0.0 (suave) y 1.0 (máxima): aumenta
  /// tanto la amplitud como la duración del pulso.
  Future<void> vibrateWithIntensity(double intensity) async {
    final level = intensity.clamp(0.0, 1.0);
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != true) return;

    final duration = (80 + 420 * level).round(); // 80 ms -> 500 ms
    final hasAmplitude = await Vibration.hasAmplitudeControl();
    if (hasAmplitude == true) {
      final amplitude = (40 + 215 * level).round(); // 40 -> 255
      Vibration.vibrate(duration: duration, amplitude: amplitude);
    } else {
      Vibration.vibrate(duration: duration);
    }
  }

  void cancel() {
    Vibration.cancel();
  }
}
