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
          color: context.silk.background,
          borderRadius: BorderRadius.circular(24),
          // Neumorfismo elevado: sombras externas; al presionar se hunde
          // (sin sombra externa, con sombra interna sutil).
          boxShadow: _pressed
              ? []
              : [
                  BoxShadow(
                    color: context.silk.shadowDark,
                    offset: Offset(8, 8),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: context.silk.shadowLight,
                    offset: Offset(-8, -8),
                    blurRadius: 16,
                  ),
                ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
