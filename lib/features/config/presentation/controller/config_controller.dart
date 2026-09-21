import 'package:flutter/material.dart';
import 'package:kronos/features/config/data/repositories/config_repository.dart';

class ConfigController extends ChangeNotifier {
  final ConfigRepository _configRepository;

  ConfigController(this._configRepository);

  String? _theme;
  String? _language;
  int? _minuteRange;
  int? _secondRange;

  String? get theme => _theme;
  String? get language => _language;
  int? get minuteRange => _minuteRange;
  int? get secondRange => _secondRange;

  Future<void> loadConfig() async {
    _theme = await _configRepository.getTheme();
    _language = await _configRepository.getLanguage();
    _minuteRange = await _configRepository.getMinuteRange();
    _secondRange = await _configRepository.getSecondRange();
    notifyListeners();
  }

  Future<void> updateTheme(String theme) async {
    await _configRepository.saveTheme(theme);
    _theme = theme;
    notifyListeners();
  }

  Future<void> updateLanguage(String language) async {
    await _configRepository.saveLanguage(language);
    _language = language;
    notifyListeners();
  }

  Future<void> updateMinuteRange(int minuteRange) async {
    await _configRepository.saveMinuteRange(minuteRange);
    _minuteRange = minuteRange;
    notifyListeners();
  }

  Future<void> updateSecondRange(int secondRange) async {
    await _configRepository.saveSecondRange(secondRange);
    _secondRange = secondRange;
    notifyListeners();
  }
}
