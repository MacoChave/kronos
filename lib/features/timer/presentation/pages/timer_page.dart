import 'package:flutter/material.dart';
import 'package:kronos/core/widgets/NeuButton.dart';
import 'package:kronos/core/widgets/NeuButtonCard.dart';
import 'package:kronos/features/timer/domain/entities/timer_config.dart';
import 'package:kronos/features/timer/presentation/controller/timer_controller.dart';

import '../../../../core/theme/silk_theme.dart';

class TimerPage extends StatefulWidget {
  final double minutos;
  final double segundos;

  const TimerPage({super.key, required this.minutos, required this.segundos});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late TimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TimerController(
        config: TimerConfig(
      minutes: widget.minutos.toInt(),
      seconds: widget.segundos.toInt(),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
        centerTitle: true,
        elevation: SilkShadows.raised[0].blurRadius,
        backgroundColor: SilkColors.background,
        titleTextStyle: SilkTheme.theme.textTheme.headlineMedium?.copyWith(
          color: SilkColors.primary,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: SilkColors.primary),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                int displayMinutes = _controller.remainingSeconds ~/ 60;
                int displaySeconds = _controller.remainingSeconds % 60;
                Color statusColor =
                    _getColorForTime(displayMinutes, displaySeconds);

                return NeuButtonCard(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.6,
                  onTap: () => _controller.resetTimer(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(displayMinutes.toString().padLeft(2, '0'),
                            style: SilkTheme.theme.textTheme.headlineLarge
                                ?.copyWith(
                              fontSize: screenWidth * 0.2,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            )),
                        const SizedBox(width: 24),
                        Text(':',
                            style: SilkTheme.theme.textTheme.headlineLarge
                                ?.copyWith(
                              fontSize: screenWidth * 0.2,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            )),
                        const SizedBox(width: 24),
                        Text(displaySeconds.toString().padLeft(2, '0'),
                            style: SilkTheme.theme.textTheme.headlineLarge
                                ?.copyWith(
                              fontSize: screenWidth * 0.2,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            )),
                      ]),
                );
              }),
          const SizedBox(height: 64),
          NeuButton(
              label: 'Regresar',
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context)),
        ],
      )),
    );
  }

  Color _getColorForTime(int displayMinutes, int displaySeconds) {
    if (displayMinutes == 0 && displaySeconds <= 10) {
      return SilkColors.onError;
    } else if (displayMinutes == 0 && displaySeconds <= 30) {
      return SilkColors.onWarning;
    } else {
      return SilkColors.onSurface;
    }
  }
}
