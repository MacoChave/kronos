import 'package:flutter/material.dart';
import 'package:kronos/features/config/data/repositories/config_repository.dart';
import 'package:kronos/features/config/domain/entities/time_ranges.dart';
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
  final ConfigRepository _repository = ConfigRepository();
  TimeRanges _ranges = const TimeRanges();

  @override
  void initState() {
    super.initState();
    _loadRanges();
    _checkUpdate();
  }

  Future<void> _loadRanges() async {
    final ranges = await _repository.getTimeRanges();
    if (!mounted) return;
    setState(() => _ranges = ranges);
    _controller.applyRanges(ranges);
  }

  Future<void> _openConfig() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ConfigPage()));
    // Al volver, aplica los rangos que se hayan cambiado.
    _loadRanges();
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
        title: Text('Configurar Tiempo'),
        backgroundColor: context.silk.background,
        elevation: context.silk.raised[0].blurRadius,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: context.silk.primary,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: context.silk.primary),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title & Subtitle
              Container(
                margin: const EdgeInsets.only(bottom: 48),
                child: Column(
                  children: [
                    Text(
                      'Configurar Tiempo',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: context.silk.onSurface,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ajusta la duración de cada turno',
                      style: TextStyle(
                        fontSize: 18,
                        color: context.silk.onSurface,
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
                              key: ValueKey(
                                  'min-${_ranges.minuteMin}-${_ranges.minuteMax}'),
                              timePicker: _controller.minutes,
                              label: "Minutos",
                              min: "${_ranges.minuteMin}",
                              max: "${_ranges.minuteMax}",
                              onChanged: (value) =>
                                  _controller.updateMinutes(value)),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: NeuTimePicker(
                              key: ValueKey(
                                  'sec-${_ranges.secondMin}-${_ranges.secondMax}'),
                              timePicker: _controller.seconds,
                              label: "Segundos",
                              min: "${_ranges.secondMin}",
                              max: "${_ranges.secondMax}",
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

              // Espacio considerable entre los dos botones
              const SizedBox(height: 40),

              // Config button
              NeuButton(
                  label: 'Configuración',
                  icon: Icons.settings,
                  onTap: _openConfig),
            ]),
      ),
    );
  }
}
