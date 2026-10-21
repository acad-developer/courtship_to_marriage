import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_logo.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),
              const AppLogo(size: 96),
              const SizedBox(height: 32),
              Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading(34),
              ),
              const SizedBox(height: 16),
              const Text(
                AppConstants.tagline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 4),
              Obx(() => controller.hasError.value
                  ? Column(
                children: [
                  const Text(
                    'Could not connect. Please check your internet.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: controller.start,
                    child: const Text('Retry',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              )
                  : const Column(
                children: [
                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      color: AppColors.primary,
                      backgroundColor: AppColors.border,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'INITIALIZING',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.6,
                      color: AppColors.hint,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}