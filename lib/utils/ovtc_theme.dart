import 'package:flutter/material.dart';

abstract class OVTCTheme {
  static const Color primaryColor = Colors.blueGrey;
  static const Color secondaryColor = Colors.yellowAccent;

  static const ColorScheme colorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: secondaryColor,
    background: Color(0xFFFFFFFF),
    error: Color(0xFFB00020),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onError: Color(0xFFFFFFFF),
  );

  static ColorScheme colorSchemeDark = const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: primaryColor,
    secondary: secondaryColor,
  );
}
