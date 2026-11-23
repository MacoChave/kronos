import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';
import 'package:kronos/core/theme/theme_controller.dart';
import 'package:kronos/core/widgets/NeuButton.dart';
import 'package:kronos/core/widgets/NeuCard.dart';
import 'package:kronos/core/widgets/NeuTextField.dart';
import 'package:kronos/core/widgets/NeuToggleButton.dart';
import 'package:kronos/features/config/data/repositories/config_repository.dart';
import 'package:kronos/features/config/domain/entities/time_ranges.dart';
import 'package:kronos/features/app_update/data/services/update_service.dart';
import 'package:kronos/features/app_update/presentation/widgets/update_dialog.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final ConfigRepository _repository = ConfigRepository();
  TimeRanges _ranges = const TimeRanges();
  bool _loaded = false;
  String? _error;
  String _appVersion = '';
  bool _checkingUpdate = false;

  @override
  void initState() {
    super.initState();
    _load();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final version = await UpdateService.currentVersion();
    if (!mounted) return;
    setState(() => _appVersion = version);
  }

  /// Consulta la última versión y, si es más nueva, abre el diálogo de descarga.
  Future<void> _downloadNewVersion() async {
    setState(() => _checkingUpdate = true);
    final latest = await UpdateService.checkForUpdates();
    if (!mounted) return;
    setState(() => _checkingUpdate = false);

    if (latest != null) {
      UpdateDialog.show(context, latest);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Ya tienes la última versión o no se pudo verificar.'),
      ));
    }
  }

  Future<void> _load() async {
    final ranges = await _repository.getTimeRanges();
    if (!mounted) return;
    setState(() {
      _ranges = ranges;
      _loaded = true;
    });
  }

  /// Valida y guarda los rangos. Si no son válidos, no se guardan.
  void _update(TimeRanges candidate) {
    if (!candidate.isValid) {
      setState(() => _error =
          'Revisa los límites: el mínimo debe ser menor que el máximo.');
      return;
    }
    setState(() {
      _ranges = candidate;
      _error = null;
    });
    _repository.saveTimeRanges(candidate);
  }

  void _onNumber(String value, TimeRanges Function(int) apply) {
    final number = int.tryParse(value.trim());
    if (number == null) {
      setState(() => _error = 'Ingresa un número válido.');
      return;
    }
    _update(apply(number));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuración'),
          backgroundColor: context.silk.background,
          elevation: context.silk.raised[0].blurRadius,
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: context.silk.primary,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: context.silk.primary),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Límites del tiempo',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: context.silk.onError),
                        ),
                      ],
                      SizedBox(height: 16),
                      NeuCard(
                          width: double.infinity,
                          height: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(children: [
                              Text(
                                'Minutos',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: context.silk.onSurfaceVariant,
                                    fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 8),

                              // Rango inferior de minutos
                              NeuTextField(
                                key: ValueKey('minMin-$_loaded'),
                                label: 'Mínimo',
                                hintText: 'Mínimo',
                                keyboardType: TextInputType.number,
                                initialValue: '${_ranges.minuteMin}',
                                onChanged: (value) => _onNumber(
                                    value,
                                    (n) => _ranges.copyWith(minuteMin: n)),
                              ),

                              SizedBox(height: 16),

                              // Rango superior de minutos
                              NeuTextField(
                                key: ValueKey('minMax-$_loaded'),
                                label: 'Máximo',
                                hintText: 'Máximo',
                                keyboardType: TextInputType.number,
                                initialValue: '${_ranges.minuteMax}',
                                onChanged: (value) => _onNumber(
                                    value,
                                    (n) => _ranges.copyWith(minuteMax: n)),
                              ),
                            ]),
                          )),
                      SizedBox(height: 16),
                      NeuCard(
                          width: double.infinity,
                          height: 350,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(children: [
                                Text(
                                  'Segundos',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: context.silk.onSurfaceVariant,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height: 8),

                                // Rango inferior de segundos
                                NeuTextField(
                                  key: ValueKey('secMin-$_loaded'),
                                  label: 'Mínimo',
                                  hintText: 'Mínimo',
                                  keyboardType: TextInputType.number,
                                  initialValue: '${_ranges.secondMin}',
                                  onChanged: (value) => _onNumber(
                                      value,
                                      (n) => _ranges.copyWith(secondMin: n)),
                                ),

                                SizedBox(height: 16),

                                // Rango superior de segundos
                                NeuTextField(
                                  key: ValueKey('secMax-$_loaded'),
                                  label: 'Máximo',
                                  hintText: 'Máximo',
                                  keyboardType: TextInputType.number,
                                  initialValue: '${_ranges.secondMax}',
                                  onChanged: (value) => _onNumber(
                                      value,
                                      (n) => _ranges.copyWith(secondMax: n)),
                                ),
                              ]))),
                      SizedBox(height: 16),
                      Text(
                        'Personalización',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      NeuCard(
                          width: double.infinity,
                          height: 350,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(children: [
                                Text(
                                  'Tema visual',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: context.silk.onSurfaceVariant,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                ValueListenableBuilder<ThemeMode>(
                                  valueListenable: ThemeController.mode,
                                  builder: (context, mode, _) => Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 24,
                                    runSpacing: 24,
                                    children: [
                                      NeuToggleButton(
                                          label: 'Claro',
                                          value: mode == ThemeMode.light,
                                          onChanged: (_) => ThemeController
                                              .setMode(ThemeMode.light),
                                          icon: Icons.light_mode),
                                      NeuToggleButton(
                                          label: 'Oscuro',
                                          value: mode == ThemeMode.dark,
                                          onChanged: (_) => ThemeController
                                              .setMode(ThemeMode.dark),
                                          icon: Icons.dark_mode),
                                      NeuToggleButton(
                                          label: 'Sistema',
                                          value: mode == ThemeMode.system,
                                          onChanged: (_) => ThemeController
                                              .setMode(ThemeMode.system),
                                          icon: Icons.settings),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Color de acento (pendiente de implementar)
                                /*
                                Text(
                                  'Color de acento',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: context.silk.onSurfaceVariant,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                */
                              ]))),
                      SizedBox(height: 16),
                      // Versión instalada
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: context.silk.input(radius: 20),
                        child: Text(
                          'Versión ${_appVersion.isEmpty ? '...' : _appVersion}',
                          style: context.silk.body.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.silk.onSurfaceVariant),
                        ),
                      ),
                      SizedBox(height: 16),
                      _checkingUpdate
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            )
                          : NeuButton(
                              label: 'Descargar nueva versión',
                              icon: Icons.download_rounded,
                              onTap: _downloadNewVersion),
                      SizedBox(height: 16),
                      NeuButton(
                          label: "Guardar cambios",
                          onTap: () => Navigator.pop(context))
                    ],
                  )),
            ],
          ),
        ));
  }
}
