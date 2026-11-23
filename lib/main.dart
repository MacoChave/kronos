import 'package:flutter/material.dart';
import 'package:kronos/features/config_timer/presentation/pages/config_timer_page.dart';
import 'package:kronos/core/config/flavor_config.dart';
import 'package:kronos/core/theme/theme_controller.dart';

import 'core/theme/silk_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.instance = FlavorConfig(
      flavor: Flavor.prod,
      updateUrl:
          'https://www.dropbox.com/scl/fi/n34jzql253w6q13zkyy5i/version.json?rlkey=kiqn9211uspggh79adm0n7nmq&st=n76fi3kx&dl=0');
  await ThemeController.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, mode, _) => MaterialApp(
        title: 'Chronos',
        debugShowCheckedModeBanner: false,
        theme: SilkTheme.light,
        darkTheme: SilkTheme.dark,
        themeMode: mode,
        // Paleta activa según el brillo efectivo del tema (claro u oscuro).
        builder: (context, child) => SilkScope(
          palette: Theme.of(context).brightness == Brightness.dark
              ? SilkPalette.dark
              : SilkPalette.light,
          child: child!,
        ),
        home: const ConfigTimerPage(),
      ),
    );
  }
}
