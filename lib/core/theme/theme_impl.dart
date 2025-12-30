import 'package:flutter/material.dart';
import 'package:new_apta_grading/core/theme/themes.dart';

class AppTheme {
  static final defaultTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: cWhite,
    appBarTheme: AppBarTheme(
      backgroundColor: cWhite,
      surfaceTintColor: cTransparent,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: cBlue),
  );
}
