import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 20),
                    ),
                    Expanded(
                      child: Text('Edit Profile',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading(22)),
                    ),
                    const SizedBox(width: 48), // balances the back button
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: 'Full Name *',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline_rounded,
                        controller: controller.nameController,
                        validator: Validators.fullName,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        label: 'Email Address *',
                        hint: 'example@email.com',
                        icon: Icons.mail_outline_rounded,
                        controller: controller.emailController,
                        validator: Validators.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => controller.save(),
                      ),
                      const SizedBox(height: 24),
                      _PhoneReadOnly(phone: controller.phone),
                      const SizedBox(height: 40),
                      Obx(() => PrimaryButton(
                        label: 'SAVE CHANGES',
                        isLoading: controller.isSaving.value,
                        onPressed: controller.save,
                      )),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _PhoneReadOnly extends StatelessWidget {
  final RxString phone;
  const _PhoneReadOnly({required this.phone});

  static const _green = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('PHONE NUMBER', style: AppTextStyles.label),
            const Spacer(),
            const Icon(Icons.check_circle_rounded, size: 16, color: _green),
            const SizedBox(width: 4),
            const Text(
              'VERIFIED',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: _green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.phone_rounded, size: 20, color: AppColors.hint),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() => Text(
                  phone.value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                )),
              ),
              const Icon(Icons.lock_rounded, size: 18, color: AppColors.hint),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Phone number is verified and cannot be changed here. '
              'Contact support for assistance.',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            fontStyle: FontStyle.italic,
            color: AppColors.hint,
          ),
        ),
      ],
    );
  }
}