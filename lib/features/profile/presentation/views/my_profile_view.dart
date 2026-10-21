import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({super.key});

  static const _infoItems = [
    'Help & Support',
    'Contact Us',
    'About Us',
    'Privacy Policy',
    'Terms & Conditions',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('My Profile',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading(22)),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              children: [
                _UserCard(controller: controller),
                const SizedBox(height: 24),
                _InfoCard(items: _infoItems, onTap: controller.openInfoItem),
                const SizedBox(height: 28),
                _SignOutButton(controller: controller),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: controller.openDeleteAccount,
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Text(
                  controller.version.value,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.hint),
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

BoxDecoration _cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(32),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ],
);

class _UserCard extends StatelessWidget {
  final MyProfileController controller;
  const _UserCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: _cardDecoration(),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const SizedBox(
            height: 140,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        return Column(
          children: [
            if (controller.name.value.isNotEmpty)
              Text(
                controller.name.value,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading(28),
              ),
            if (controller.phone.value.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                controller.phone.value,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
            if (controller.email.value.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                controller.email.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15, color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: controller.openEditProfile,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'EDIT PROFILE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<String> items;
  final void Function(String title) onTap;
  const _InfoCard({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            InkWell(
              onTap: () => onTap(items[i]),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(items[i],
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.hint),
                  ],
                ),
              ),
            ),
            if (i != items.length - 1)
              const Divider(
                height: 1,
                indent: 28,
                endIndent: 28,
                color: AppColors.border,
              ),
          ],
        ],
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  final MyProfileController controller;
  const _SignOutButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final busy = controller.isSigningOut.value;
      return SizedBox(
        width: double.infinity,
        height: 60,
        child: OutlinedButton(
          onPressed: busy ? null : controller.confirmSignOut,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            backgroundColor: Colors.white,
            side: BorderSide(color: AppColors.error.withValues(alpha: 0.25)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
          ),
          child: busy
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
                strokeWidth: 2.5, color: AppColors.error),
          )
              : const Text(
            'SIGN OUT',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
        ),
      );
    });
  }
}