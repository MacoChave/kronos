import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static const String countdownSound = 'countdown.mp3';
  static const String timeUpSound = 'time_up.mp3';

  Future<void> preload() async {
    try {
      await FlameAudio.audioCache.loadAll([countdownSound, timeUpSound]);
    } catch (e) {
      if (kDebugMode) {
        print('Error preloading audio files: $e');
      }
    }
  }

  Future<void> playCountdownTick() async {
    try {
      await FlameAudio.play(countdownSound);
    } catch (e) {
      if (kDebugMode) {
        print('Error playing countdown sound: $e');
      }
    }
  }

  Future<void> playTimeUp() async {
    try {
      await FlameAudio.play(timeUpSound);
    } catch (e) {
      if (kDebugMode) {
        print('Error playing time up sound: $e');
      }
    }
  }

  void stop() {
    try {
      // Stop background or currently playing sounds if applicable
      FlameAudio.bgm.stop();
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping audio: $e');
      }
    }
  }
}
