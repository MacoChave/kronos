import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── PALETA (claro / oscuro) ────────────────────────────────────────────────
// Los colores dependen del tema activo. Los widgets los obtienen con
// `context.silk` (ver SilkScope), así se actualizan al cambiar el tema.
class SilkPalette {
  final bool isDark;
  final Color background; // "clay" surface
  final Color primary; // interactivos
  final Color tertiary; // acentos
  final Color shadowDark;
  final Color shadowLight;
  final Color insetDark;
  final Color insetLight;
  final Color onSurface; // texto principal
  final Color onSurfaceVariant;
  final Color onError;
  final Color onWarning;

  const SilkPalette._({
    required this.isDark,
    required this.background,
    required this.primary,
    required this.tertiary,
    required this.shadowDark,
    required this.shadowLight,
    required this.insetDark,
    required this.insetLight,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.onError,
    required this.onWarning,
  });

  static const light = SilkPalette._(
    isDark: false,
    background: Color(0xFFE8EAF0),
    primary: Color(0xFF6366F1),
    tertiary: Color(0xFF7C3AED),
    shadowDark: Color(0x14000000),
    shadowLight: Color(0x99FFFFFF),
    insetDark: Color(0x0F000000),
    insetLight: Color(0x80FFFFFF),
    onSurface: Color(0xFF3D4151),
    onSurfaceVariant: Color(0xFF7B8197),
    onError: Color(0xFFE53935),
    onWarning: Color(0xFFFFA000),
  );

  static const dark = SilkPalette._(
    isDark: true,
    background: Color(0xFF1F2130),
    primary: Color(0xFF818CF8),
    tertiary: Color(0xFFA78BFA),
    shadowDark: Color(0x80000000),
    shadowLight: Color(0x14FFFFFF),
    insetDark: Color(0x66000000),
    insetLight: Color(0x0FFFFFFF),
    onSurface: Color(0xFFE2E4EE),
    onSurfaceVariant: Color(0xFF9AA0B5),
    onError: Color(0xFFEF5350),
    onWarning: Color(0xFFFFB300),
  );

  // ─── SOMBRAS ──────────────────────────────────────────────────────────────
  /// Elemento elevado / raised
  List<BoxShadow> get raised => [
        BoxShadow(color: shadowDark, offset: const Offset(6, 6), blurRadius: 12),
        BoxShadow(color: shadowLight, offset: const Offset(-6, -6), blurRadius: 12),
      ];

  /// Elemento presionado / inset
  List<BoxShadow> get pressed => [
        BoxShadow(color: insetDark, offset: const Offset(4, 4), blurRadius: 8),
        BoxShadow(color: insetLight, offset: const Offset(-4, -4), blurRadius: 8),
      ];

  // ─── DECORACIONES ─────────────────────────────────────────────────────────
  BoxDecoration card({double radius = 20}) => BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: raised,
      );

  BoxDecoration input({double radius = 14}) => BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: pressed,
      );

  BoxDecoration buttonRaised({double radius = 16}) => BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: raised,
      );

  // ─── TIPOGRAFÍA ───────────────────────────────────────────────────────────
  // Plus Jakarta Sans requiere el paquete google_fonts
  TextStyle get heading => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: onSurface,
      );

  TextStyle get body => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: onSurface,
      );

  TextStyle get caption => GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: onSurfaceVariant,
      );

  TextStyle get button => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: primary,
      );
}

// ─── SCOPE: expone la paleta activa a todo el árbol ─────────────────────────
class SilkScope extends InheritedWidget {
  final SilkPalette palette;

  const SilkScope({super.key, required this.palette, required super.child});

  static SilkPalette of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SilkScope>()
          ?.palette ??
      SilkPalette.light;

  @override
  bool updateShouldNotify(SilkScope oldWidget) =>
      oldWidget.palette != palette;
}

extension SilkContext on BuildContext {
  SilkPalette get silk => SilkScope.of(this);
}

// ─── TEMA FLUTTER ────────────────────────────────────────────────────────────
class SilkTheme {
  SilkTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        scaffoldBackgroundColor: SilkPalette.light.background,
        colorScheme: ColorScheme.light(
          primary: SilkPalette.light.primary,
          tertiary: SilkPalette.light.tertiary,
          surface: SilkPalette.light.background,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: SilkPalette.dark.background,
        colorScheme: ColorScheme.dark(
          primary: SilkPalette.dark.primary,
          tertiary: SilkPalette.dark.tertiary,
          surface: SilkPalette.dark.background,
        ),
      );
}
