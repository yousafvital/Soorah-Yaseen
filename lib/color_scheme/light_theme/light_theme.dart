import 'package:flutter/material.dart';

class LightTheme {
  static var kColorScheme =
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 225, 199, 2));

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.primaryContainer,
      foregroundColor: kColorScheme.onPrimaryFixed,
    ),
    // cardTheme: const CardTheme().copyWith(
    //   color: kColorScheme.secondaryContainer,
    //   margin: const EdgeInsets.symmetric(
    //     horizontal: 16,
    //     vertical: 8,
    //   ),
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: kColorScheme.primaryContainer,
    //   ),
    // ),
    // textTheme: ThemeData().textTheme.copyWith(
    //       titleLarge: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: kColorScheme.onSecondaryContainer,
    //         fontSize: 16,
    //       ),
    //     ),
  );
}
