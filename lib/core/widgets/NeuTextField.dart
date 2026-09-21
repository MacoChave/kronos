// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';

class NeuTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;

  const NeuTextField({
    super.key,
    this.label,
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              label!,
              style: SilkText.body.copyWith(
                fontWeight: FontWeight.bold,
                color: SilkTheme.theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: SilkDecor.input(radius: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            style: SilkText.body.copyWith(
              color: SilkTheme.theme.colorScheme.onSurfaceVariant,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: SilkText.body.copyWith(
                color: SilkTheme.theme.colorScheme.onSurfaceVariant,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
