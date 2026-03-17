import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
  scaffoldBackgroundColor: AppColors.background,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: AppSpacing.lg, fontWeight:FontWeight.bold),
    bodyMedium: TextStyle(fontSize: AppSpacing.md)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg)
    )
  ));
}

class AppColors {
  static const primary = Color(0xff5e73cb);
  static const background = Color(0xffffffff);
  static const textPrimary = Color(0xff1a1a1a);
}

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}