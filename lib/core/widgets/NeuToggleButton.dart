// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';

class NeuToggleButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NeuToggleButton(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: SilkColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: value
              ? []
              : [
                  const BoxShadow(
                    color: SilkColors.shadowDark,
                    offset: Offset(4, 4),
                    blurRadius: 12,
                  ),
                  const BoxShadow(
                    color: SilkColors.shadowDark,
                    offset: Offset(-4, -4),
                    blurRadius: 12,
                  ),
                ],
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  color: value ? SilkColors.primary : SilkColors.onSurface),
              const SizedBox(height: 8),
            ],
            if (label != null)
              Text(label!,
                  style: TextStyle(
                    color: SilkColors.onSurface,
                  )),
          ],
        ),
      ),
    );
  }
}
