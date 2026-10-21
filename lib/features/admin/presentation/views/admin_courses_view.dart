import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/admin_courses_controller.dart';
import '../widgets/admin_course_card.dart';
import '../widgets/admin_header.dart';

class AdminCoursesView extends GetView<AdminCoursesController> {
  const AdminCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openCreate,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Course',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          const AdminHeader(title: 'Courses'),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              final error = controller.errorMessage.value;
              if (error != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(error,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColors.textSecondary)),
                        TextButton(
                          onPressed: controller.retry,
                          child: const Text('Retry',
                              style: TextStyle(color: AppColors.primary)),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (controller.courses.isEmpty) return const _EmptyState();

              final list = controller.courses;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final course = list[i];
                  return AdminCourseCard(
                    course: course,
                    onTap: () => controller.openEdit(course),
                    onAction: (a) => controller.onMenuAction(course, a),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryLight),
              child: const Icon(Icons.menu_book_rounded,
                  size: 36, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text('No courses yet', style: AppTextStyles.heading(24)),
            const SizedBox(height: 8),
            const Text(
              'Tap "New Course" to create your first course.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}