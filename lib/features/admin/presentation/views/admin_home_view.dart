import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
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
                padding: const EdgeInsets.fromLTRB(24, 16, 12, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ADMIN PANEL',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.6,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(() => Text(
                            controller.name.value.isEmpty
                                ? ' '
                                : controller.name.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          )),
                        ],
                      ),
                    ),
                    Obx(() => IconButton(
                      tooltip: 'Sign out',
                      onPressed: controller.isSigningOut.value
                          ? null
                          : controller.confirmSignOut,
                      icon: const Icon(Icons.logout_rounded,
                          color: AppColors.error),
                    )),
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
              return ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text('Manage Content', style: AppTextStyles.heading(28)),
                  const SizedBox(height: 8),
                  const Text(
                    'Create courses, upload images and manage lessons.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  _ActionTile(
                    icon: Icons.menu_book_rounded,
                    title: 'Courses',
                    subtitle: 'Create and edit courses and their lessons',
                    onTap: controller.openCourses,
                  ),
                  const SizedBox(height: 14),
                  Obx(() => _ActionTile(
                    icon: Icons.support_agent_rounded,
                    title: 'Support Queries',
                    subtitle: 'Review and resolve messages from users',
                    badge: controller.pendingCount.value,
                    onTap: controller.openSupport,
                  )),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int badge;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              if (badge > 0)
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$badge',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.hint),
            ],
          ),
        ),
      ),
    );
  }
}