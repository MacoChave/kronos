import 'package:flutter/material.dart';
import 'package:kronos/features/config/data/repositories/config_repository.dart';

/// Tema visual activo (Claro / Oscuro / Sistema), guardado en SharedPreferences.
class ThemeController {
  ThemeController._();

  static final ValueNotifier<ThemeMode> mode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static final ConfigRepository _repository = ConfigRepository();

  static Future<void> load() async {
    try {
      mode.value = _fromName(await _repository.getTheme());
    } catch (_) {
      mode.value = ThemeMode.light;
    }
  }

  static Future<void> setMode(ThemeMode newMode) async {
    mode.value = newMode;
    try {
      await _repository.saveTheme(_toName(newMode));
    } catch (_) {
      // Si no se puede guardar, el cambio se aplica igualmente en esta sesión.
    }
  }

  static ThemeMode _fromName(String? name) => switch (name) {
        'Oscuro' => ThemeMode.dark,
        'Sistema' => ThemeMode.system,
        _ => ThemeMode.light,
      };

  static String _toName(ThemeMode m) => switch (m) {
        ThemeMode.dark => 'Oscuro',
        ThemeMode.system => 'Sistema',
        ThemeMode.light => 'Claro',
      };
}
