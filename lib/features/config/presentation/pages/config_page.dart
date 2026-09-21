import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';
import 'package:kronos/core/widgets/NeuButton.dart';
import 'package:kronos/core/widgets/NeuCard.dart';
import 'package:kronos/core/widgets/NeuTextField.dart';
import 'package:kronos/core/widgets/NeuToggleButton.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuración'),
          backgroundColor: SilkColors.background,
          elevation: SilkShadows.raised[0].blurRadius,
          centerTitle: true,
          titleTextStyle: SilkTheme.theme.textTheme.headlineMedium?.copyWith(
            color: SilkColors.primary,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: SilkColors.primary),
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
                      SizedBox(height: 16),
                      NeuCard(
                          width: double.infinity,
                          height: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(children: [
                              const Text(
                                'Minutos',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: SilkColors.onSurfaceVariant,
                                    fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 8),

                              // Input para rango inferior de minutos
                              NeuTextField(
                                label: 'Mínimo',
                                hintText: 'Mínimo',
                                keyboardType: TextInputType.number,
                                initialValue: '1',
                                onChanged: (value) {
                                  if (kDebugMode) {
                                    print('Nuevo valor: $value');
                                  }
                                },
                              ),

                              SizedBox(height: 16),

                              // Input para rango superior de minutos
                              NeuTextField(
                                label: 'Máximo',
                                hintText: 'Máximo',
                                keyboardType: TextInputType.number,
                                initialValue: '10',
                                onChanged: (value) {
                                  if (kDebugMode) {
                                    print('Nuevo valor: $value');
                                  }
                                },
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
                                const Text(
                                  'Segundos',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: SilkColors.onSurfaceVariant,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height: 8),

                                // Input para rango inferior de segundos
                                NeuTextField(
                                  label: 'Mínimo',
                                  hintText: 'Mínimo',
                                  keyboardType: TextInputType.number,
                                  initialValue: '0',
                                  onChanged: (value) {
                                    if (kDebugMode) {
                                      print('Nuevo valor: $value');
                                    }
                                  },
                                ),

                                SizedBox(height: 16),

                                // Input para rango superior de segundos
                                NeuTextField(
                                  label: 'Máximo',
                                  hintText: 'Máximo',
                                  keyboardType: TextInputType.number,
                                  initialValue: '59',
                                  onChanged: (value) {
                                    if (kDebugMode) {
                                      print('Nuevo valor: $value');
                                    }
                                  },
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
                                const Text(
                                  'Tema visual',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: SilkColors.onSurfaceVariant,
                                      fontWeight: FontWeight.bold),
                                ),
                                NeuToggleButton(
                                    label: 'Claro',
                                    value: true,
                                    onChanged: (newValue) {
                                      if (kDebugMode) {
                                        print('Modo claro: $newValue');
                                      }
                                    },
                                    icon: Icons.light_mode),
                                NeuToggleButton(
                                    label: 'Oscuro',
                                    value: false,
                                    onChanged: (newValue) {
                                      if (kDebugMode) {
                                        print('Modo oscuro: $newValue');
                                      }
                                    },
                                    icon: Icons.dark_mode),
                                NeuToggleButton(
                                    label: 'Sistema',
                                    value: false,
                                    onChanged: (newValue) {
                                      if (kDebugMode) {
                                        print('Modo sistema: $newValue');
                                      }
                                    },
                                    icon: Icons.settings),
                                SizedBox(height: 8),
                                const Text(
                                  'Color de acento',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: SilkColors.onSurfaceVariant,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                              ]))),
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
