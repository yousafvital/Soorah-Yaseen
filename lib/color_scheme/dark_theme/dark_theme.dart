import 'package:flutter/material.dart';

class DarkTheme {
  static var kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 5, 187, 238));

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    cardTheme: const CardTheme().copyWith(
      color: kDarkColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: kDarkColorScheme.primaryContainer,
    //     foregroundColor: kDarkColorScheme.onPrimaryContainer,
    //   ),
    // ),
  );
}
