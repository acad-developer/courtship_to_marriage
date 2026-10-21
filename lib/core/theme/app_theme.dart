import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading(double size, {Color color = AppColors.textPrimary}) =>
      TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.2,
      );

  static const label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: Colors.white,
    ),
  );
}