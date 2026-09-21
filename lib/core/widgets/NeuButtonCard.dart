// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';

class NeuButtonCard extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final VoidCallback onTap;

  const NeuButtonCard(
      {super.key,
      required this.child,
      required this.width,
      required this.height,
      required this.onTap});

  @override
  State<NeuButtonCard> createState() => _NeuButtonCardState();
}

class _NeuButtonCardState extends State<NeuButtonCard> {
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
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: SilkColors.background,
          borderRadius: BorderRadius.circular(24),
          boxShadow: _pressed
              ? []
              : const [
                  BoxShadow(
                    color: SilkColors.insetDark,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: SilkColors.insetLight,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
