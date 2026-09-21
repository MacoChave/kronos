import 'package:flutter/material.dart';
import 'package:kronos/features/config/presentation/pages/config_page.dart';
import 'package:kronos/features/config_timer/presentation/controller/config_timer_controller.dart';

import '../../../../core/widgets/NeuButton.dart';
import '../../../../core/widgets/NeuTimePicker.dart';
import '../../../app_update/data/services/update_service.dart';
import '../../../timer/presentation/pages/timer_page.dart';
import '../../../../core/theme/silk_theme.dart';
import '../../../app_update/presentation/widgets/update_dialog.dart';

class ConfigTimerPage extends StatefulWidget {
  const ConfigTimerPage({super.key});

  @override
  State<ConfigTimerPage> createState() => _ConfigTimerPageState();
}

class _ConfigTimerPageState extends State<ConfigTimerPage> {
  final ConfigTimerController _controller = ConfigTimerController();

  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  Future<void> _checkUpdate() async {
    final info = await UpdateService.checkForUpdates();

    if (info != null && mounted) {
      UpdateDialog.show(context, info);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Tiempo'),
        backgroundColor: SilkColors.background,
        elevation: SilkShadows.raised[0].blurRadius,
        centerTitle: true,
        titleTextStyle: SilkTheme.theme.textTheme.headlineMedium?.copyWith(
          color: SilkColors.primary,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: SilkColors.primary),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title & Subtitle
              Container(
                margin: const EdgeInsets.only(bottom: 48),
                child: const Column(
                  children: [
                    Text(
                      'Configurar Tiempo',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: SilkColors.onSurface,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ajusta la duración de cada turno',
                      style: TextStyle(
                        fontSize: 18,
                        color: SilkColors.onSurface,
                      ),
                    )
                  ],
                ),
              ),

              ListenableBuilder(
                  listenable: _controller,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: NeuTimePicker(
                              timePicker: _controller.minutes,
                              label: "Minutos",
                              min: "1",
                              max: "10",
                              onChanged: (value) =>
                                  _controller.updateMinutes(value)),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: NeuTimePicker(
                              timePicker: _controller.seconds,
                              label: "Segundos",
                              min: "0",
                              max: "59",
                              onChanged: (value) =>
                                  _controller.updateSeconds(value)),
                        ),
                      ],
                    );
                  }),

              const SizedBox(height: 48),

              // Start game button
              NeuButton(
                  label: 'Iniciar Juego',
                  icon: Icons.play_arrow,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TimerPage(
                              minutos: _controller.minutes,
                              segundos: _controller.seconds)))),

              // Config button
              NeuButton(
                  label: 'Configuración',
                  icon: Icons.settings,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ConfigPage()))),
            ]),
      ),
    );
  }
}
