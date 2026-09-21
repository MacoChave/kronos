// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── COLORES ────────────────────────────────────────────────────────────────
class SilkColors {
  SilkColors._();

  static const background = Color(0xFFE8EAF0); // "clay" surface
  static const primary = Color(0xFF6366F1); // indigo — interactivos
  static const tertiary = Color(0xFF7C3AED); // violet — acentos

  // Sombras neumórficas
  static const shadowDark = Color(0x14000000); // rgba(0,0,0,0.08)
  static const shadowLight = Color(0x99FFFFFF); // rgba(255,255,255,0.6)

  // Sombras inset (pressed)
  static const insetDark = Color(0x0F000000); // rgba(0,0,0,0.06)
  static const insetLight = Color(0x80FFFFFF); // rgba(255,255,255,0.5)

  // Texto
  static const onSurface = Color(0xFF3D4151); // texto principal
  static const onSurfaceVariant = Color(0xFF7B8197);

  static const onError = Color(0xFFE53935); // rojo para alerta
  static const onWarning = Color(0xFFFFA000); // amarillo para advertencia
}

// ─── SOMBRAS ────────────────────────────────────────────────────────────────
class SilkShadows {
  SilkShadows._();

  /// Elemento elevado / raised
  static const raised = [
    BoxShadow(
      color: SilkColors.shadowDark,
      offset: Offset(6, 6),
      blurRadius: 12,
    ),
    BoxShadow(
      color: SilkColors.shadowLight,
      offset: Offset(-6, -6),
      blurRadius: 12,
    ),
  ];

  /// Elemento presionado / inset
  static const pressed = [
    BoxShadow(
      color: SilkColors.insetDark,
      offset: Offset(4, 4),
      blurRadius: 8,
    ),
    BoxShadow(
      color: SilkColors.insetLight,
      offset: Offset(-4, -4),
      blurRadius: 8,
    ),
  ];
}

// ─── DECORACIONES ───────────────────────────────────────────────────────────
class SilkDecor {
  SilkDecor._();

  /// Tarjeta / card raised
  static BoxDecoration card({double radius = 20}) => BoxDecoration(
        color: SilkColors.background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: SilkShadows.raised,
      );

  /// Input inset (carved)
  static BoxDecoration input({double radius = 14}) => BoxDecoration(
        color: SilkColors.background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: SilkShadows.pressed,
      );

  /// Botón raised (estado normal)
  static BoxDecoration buttonRaised({double radius = 16}) => BoxDecoration(
        color: SilkColors.background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: SilkShadows.raised,
      );

  /// Botón pressed (estado al tocar)
  static BoxDecoration buttonPressed({double radius = 16}) => BoxDecoration(
        color: SilkColors.background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: SilkShadows.pressed,
      );
}

// ─── TIPOGRAFÍA ─────────────────────────────────────────────────────────────
class SilkText {
  SilkText._();

  // Plus Jakarta Sans requiere el paquete google_fonts
  // Agrega a pubspec.yaml: google_fonts: ^6.2.1

  static final heading = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w600, // semibold
    color: SilkColors.onSurface,
  );

  static final body = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w500, // medium
    color: SilkColors.onSurface,
  );

  static final caption = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: SilkColors.onSurfaceVariant,
  );

  static final button = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: SilkColors.primary,
  );
}

// ─── TEMA FLUTTER ────────────────────────────────────────────────────────────
class SilkTheme {
  SilkTheme._();

  static ThemeData get theme => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: SilkColors.background,
        colorScheme: ColorScheme.light(
          primary: SilkColors.primary,
          tertiary: SilkColors.tertiary,
          surface: SilkColors.background,
        ),
      );
}
