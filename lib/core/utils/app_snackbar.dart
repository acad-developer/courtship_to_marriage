import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class AppSnackbar {
  AppSnackbar._();

  static void error(String message) => _show(message, AppColors.error);
  static void success(String message) => _show(message, AppColors.dark);

  static void _show(String message, Color color) {
    Get.rawSnackbar(
      message: message,
      backgroundColor: color,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}