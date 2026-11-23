import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static const String beepSound = 'beep.wav';
  static const String doubleBeepSound = 'double_beep.wav';

  Future<void> preload() async {
    try {
      await FlameAudio.audioCache.loadAll([
        beepSound,
        doubleBeepSound,
      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Error preloading audio files: $e');
      }
    }
  }

  /// Bip con volumen creciente: [volume] entre 0.0 y 1.0.
  Future<void> playBeep(double volume) async {
    try {
      await FlameAudio.play(beepSound, volume: volume.clamp(0.0, 1.0));
    } catch (e) {
      if (kDebugMode) {
        print('Error playing beep: $e');
      }
    }
  }

  /// Doble bip que indica el reinicio del contador.
  Future<void> playDoubleBeep() async {
    try {
      await FlameAudio.play(doubleBeepSound);
    } catch (e) {
      if (kDebugMode) {
        print('Error playing double beep: $e');
      }
    }
  }


  void stop() {
    try {
      FlameAudio.bgm.stop();
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping audio: $e');
      }
    }
  }
}
