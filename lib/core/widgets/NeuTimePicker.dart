// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';

import 'NeuCard.dart';

class NeuTimePicker extends StatefulWidget {
  final double timePicker;
  final String label;
  final String min;
  final String max;

  const NeuTimePicker(
      {super.key,
      required this.timePicker,
      required this.label,
      required this.min,
      required this.max,
      required this.onChanged});

  final Function(double value) onChanged;

  @override
  State<NeuTimePicker> createState() => _NeuTimePickerState();
}

class _NeuTimePickerState extends State<NeuTimePicker> {
  late double _currentValue = widget.timePicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: SilkColors.onSurface,
                  letterSpacing: 1.2),
            ),
            Text(
              '${_currentValue.toInt()}',
              style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: SilkColors.primary,
                  height: 1.0),
            ),
          ],
        ),
        const SizedBox(height: 24),
        NeuCard(
          width: double.infinity,
          height: 80,
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 14.0,
              activeTrackColor: SilkColors.primary,
              inactiveTrackColor: SilkColors.background,
              overlayColor: SilkColors.primary.withValues(alpha: 0.2),
              trackShape: const RoundedRectSliderTrackShape(),
              thumbShape: const CustomSliderThumbCircle(
                thumbRadius: 20.0,
                innerColor: SilkColors.primary,
              ),
            ),
            child: Slider(
              value: _currentValue,
              min: double.parse(widget.min),
              max: double.parse(widget.max),
              divisions: (int.parse(widget.max) - int.parse(widget.min)),
              onChanged: (newValue) {
                setState(() {
                  _currentValue = newValue;
                  widget.onChanged(newValue);
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${widget.min} ${widget.label.toUpperCase().substring(0, 3)}",
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: SilkColors.onSurfaceVariant),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "${widget.max} ${widget.label.toUpperCase().substring(0, 3)}",
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: SilkColors.onSurfaceVariant),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final Color innerColor;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    required this.innerColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Sombra suave exterior
    final Path shadowPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: thumbRadius));
    canvas.drawShadow(
        shadowPath, SilkColors.primary.withValues(alpha: 0.3), 6.0, true);

    // Circulo blanco exterior
    final Paint paintOuter = Paint()
      ..color = SilkColors.background
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, paintOuter);

    // Circulo pequeño interior de color primario
    final Paint paintInner = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius * 0.25, paintInner);
  }
}
