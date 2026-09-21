class TimerConfig {
  final int minutes;
  final int seconds;

  TimerConfig({
    required this.minutes,
    required this.seconds,
  });

  // Calcula el total de segundos a partir de los minutos y segundos
  int get totalSeconds => (minutes * 60) + seconds;
}
