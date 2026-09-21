import 'package:flutter/material.dart';
import 'package:kronos/features/config_timer/presentation/pages/config_timer_page.dart';
import 'package:kronos/core/config/flavor_config.dart';

import 'core/theme/silk_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.instance = FlavorConfig(
      flavor: Flavor.prod,
      updateUrl:
          'https://www.dropbox.com/scl/fi/n34jzql253w6q13zkyy5i/version.json?rlkey=kiqn9211uspggh79adm0n7nmq&st=n76fi3kx&dl=0');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronos',
      debugShowCheckedModeBanner: false,
      theme: SilkTheme.theme,
      home: const ConfigTimerPage(),
    );
  }
}
