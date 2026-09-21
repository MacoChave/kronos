class ConfigSetup {
  final String theme;
  final String language;
  final Map<String, dynamic> userPreferences;
  final int minuteRange;
  final int secondRange;

  ConfigSetup({
    required this.theme,
    required this.language,
    required this.userPreferences,
    required this.minuteRange,
    required this.secondRange,
  });
}
