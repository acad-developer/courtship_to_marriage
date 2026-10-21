import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/primary_button.dart';
import 'otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  InkWell(
                    onTap: Get.back,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF3F4F6)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16),
                    ),
                  ),
                  const Spacer(),
                  const AppLogo(size: 40),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 40),
              Text('Verify Your Phone\nNumber',
                  style: AppTextStyles.heading(30)),
              const SizedBox(height: 14),
              const Text('Enter the 6-digit verification code sent to',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(controller.maskedPhone,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: Get.back,
                    child: const Text('Edit Number',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Pinput(
                  length: AppConstants.otpLength,
                  controller: controller.otpController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: defaultTheme,
                  focusedPinTheme: defaultTheme.copyWith(
                    decoration: defaultTheme.decoration!.copyWith(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                  ),
                  onCompleted: (_) => controller.verify(),
                ),
              ),
              const SizedBox(height: 28),
              Center(
                child: Obx(() {
                  if (controller.canResend) {
                    return Column(
                      children: [
                        const Text("Didn't receive the code?",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                        TextButton(
                          onPressed: controller.resend,
                          child: const Text('Resend Code',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      const Text("Didn't receive the code?",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                      const SizedBox(height: 10),
                      Text(
                        controller.isResending.value
                            ? 'Sending...'
                            : 'Resend code in ${controller.timerText}',
                        style: const TextStyle(
                            color: AppColors.hint,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 28),
              Obx(() => PrimaryButton(
                label: 'Verify & Continue',
                isLoading: controller.isVerifying.value,
                onPressed: controller.verify,
              )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}