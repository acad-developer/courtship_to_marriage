import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 48),
                const AppLogo(size: 64),
                const SizedBox(height: 24),
                Text('Complete Your Profile',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading(30)),
                const SizedBox(height: 12),
                const Text(
                  'Tell us a little about yourself to personalize your experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 40),
                AppTextField(
                  label: 'Full Name *',
                  hint: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                  controller: controller.nameController,
                  validator: Validators.fullName,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 32),
                Obx(() => PrimaryButton(
                  label: 'CONTINUE TO APP',
                  isLoading: controller.isSaving.value,
                  onPressed: controller.save,
                )),
                const SizedBox(height: 24),
                const Text(
                  'Your data is protected and will only be used to personalize '
                      'your curriculum. We never share your profile with third parties.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.hint),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}