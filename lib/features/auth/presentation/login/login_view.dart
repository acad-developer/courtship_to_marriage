import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/primary_button.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 56),
              const Center(child: AppLogo(size: 84)),
              const SizedBox(height: 28),
              Center(
                child: Text(
                  'Welcome to\n${AppConstants.appName}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading(30),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Enter your phone number to continue learning',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 64),
              const Text('PHONE NUMBER', style: AppTextStyles.label),
              const SizedBox(height: 8),
              _PhoneField(controller: controller),
              Obx(() {
                final error = controller.phoneError.value;
                if (error == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Text(error,
                      style: const TextStyle(
                          color: AppColors.error, fontSize: 12)),
                );
              }),
              const SizedBox(height: 24),
              Obx(() => PrimaryButton(
                label: 'CONTINUE',
                isLoading: controller.isLoading.value,
                onPressed: controller.sendOtp,
              )),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "We'll send you a verification code via SMS to confirm "
                      'your number. Carrier rates may apply.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.hint),
                ),
              ),
              const SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                    child: const Text('PRIVACY POLICY',
                        style: TextStyle(fontSize: 10, color: AppColors.hint)),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.terms),
                    child: const Text('TERMS OF SERVICE',
                        style: TextStyle(fontSize: 10, color: AppColors.hint)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final LoginController controller;
  const _PhoneField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasError = controller.phoneError.value != null;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border:
          Border.all(color: hasError ? AppColors.error : AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CountryCodePicker(
              onChanged: controller.onCountryChanged,
              initialSelection: AppConstants.defaultCountryIso, // India
              favorite: const ['IN'],
              showDropDownButton: true,
              flagWidth: 26,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              textStyle: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Container(width: 1, height: 28, color: AppColors.border),
            Expanded(
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                onChanged: (_) => controller.phoneError.value = null,
                onSubmitted: (_) => controller.sendOtp(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  hintText: '00000 00000',
                  hintStyle: TextStyle(color: AppColors.hint),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}