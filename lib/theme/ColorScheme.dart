import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(ColorScheme? lightColorScheme) {
    ColorScheme scheme =
        lightColorScheme ?? ColorScheme.fromSeed(seedColor: Colors.purple);
    return (ThemeData(
      colorScheme: scheme,
    ));
  }

  static ThemeData darkTheme(ColorScheme? darkColorScheme) {
    ColorScheme scheme = darkColorScheme ??
        ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        );
    return (ThemeData(
      colorScheme: scheme,
    ));
  }
}
