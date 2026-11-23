// Repositorio para manejar la configuracion de la app, como el tema, el idioma, etc. La configuración se guarda en SharedPreferences, y se carga al iniciar la app.
import 'package:kronos/features/config/domain/entities/time_ranges.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepository {
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';
  static const String _minuteRangeKey = 'minuteRange';
  static const String _secondRangeKey = 'secondRange';
  static const String _minuteMinKey = 'minuteMin';
  static const String _minuteMaxKey = 'minuteMax';
  static const String _secondMinKey = 'secondMin';
  static const String _secondMaxKey = 'secondMax';

  Future<TimeRanges> getTimeRanges() async {
    final prefs = await SharedPreferences.getInstance();
    const defaults = TimeRanges();
    return TimeRanges(
      minuteMin: prefs.getInt(_minuteMinKey) ?? defaults.minuteMin,
      minuteMax: prefs.getInt(_minuteMaxKey) ?? defaults.minuteMax,
      secondMin: prefs.getInt(_secondMinKey) ?? defaults.secondMin,
      secondMax: prefs.getInt(_secondMaxKey) ?? defaults.secondMax,
    );
  }

  Future<void> saveTimeRanges(TimeRanges ranges) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_minuteMinKey, ranges.minuteMin);
    await prefs.setInt(_minuteMaxKey, ranges.minuteMax);
    await prefs.setInt(_secondMinKey, ranges.secondMin);
    await prefs.setInt(_secondMaxKey, ranges.secondMax);
  }

  Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  Future<String?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }

  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey);
  }

  Future<void> saveMinuteRange(int minuteRange) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_minuteRangeKey, minuteRange);
  }

  Future<int?> getMinuteRange() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_minuteRangeKey);
  }

  Future<void> saveSecondRange(int secondRange) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_secondRangeKey, secondRange);
  }

  Future<int?> getSecondRange() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_secondRangeKey);
  }
}
