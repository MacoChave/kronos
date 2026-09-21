// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';

class NeuButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const NeuButton(
      {super.key, required this.label, this.icon, required this.onTap});

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: SilkColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _pressed
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: SilkColors.primary),
              const SizedBox(width: 12),
            ],
            Text(widget.label,
                style: const TextStyle(
                    color: SilkColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
