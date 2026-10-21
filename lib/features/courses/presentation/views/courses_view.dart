import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../controllers/courses_controller.dart';
import '../widgets/course_list_card.dart';
import '../../../my_learning/presentation/controllers/purchase_status_controller.dart';

class CoursesView extends GetView<CoursesController> {
  final VoidCallback onBack;
  const CoursesView({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final purchases = Get.find<PurchaseStatusController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _Header(controller: controller, onBack: onBack),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Could not load courses.',
                          style: TextStyle(color: AppColors.textSecondary)),
                      TextButton(
                        onPressed: controller.load,
                        child: const Text('Retry',
                            style: TextStyle(color: AppColors.primary)),
                      ),
                    ],
                  ),
                );
              }

              final list = controller.visibleCourses;
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => Future.wait(
                    [controller.refreshList(), purchases.refresh()]),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  children: [
                    Text('Find the Right Course\nfor You',
                        style: AppTextStyles.heading(32)),
                    const SizedBox(height: 14),
                    const Text(
                      'Explore courses designed to help you build understanding '
                          'and prepare for a stronger relationship.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (list.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Center(
                          child: Text(
                            controller.courses.isEmpty
                                ? 'New courses are coming soon.'
                                : 'No courses found.',
                            style:
                            const TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    else
                      for (final course in list) ...[
                        CourseListCard(
                          course: course,
                          currency: controller.currency,
                          onTap: () => controller.openCourse(course),
                          isPurchased: purchases.isPurchased(course.id),
                        ),
                        const SizedBox(height: 24),
                      ],
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final CoursesController controller;
  final VoidCallback onBack;
  const _Header({required this.controller, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Row(
            children: [
              _CircleButton(icon: Icons.arrow_back_ios_new_rounded, onTap: onBack),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(() => controller.isSearching.value
                    ? TextField(
                  autofocus: true,
                  onChanged: controller.onQueryChanged,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Search courses',
                    hintStyle: TextStyle(color: AppColors.hint),
                    border: InputBorder.none,
                  ),
                )
                    : Text('Explore Courses',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(22))),
              ),
              const SizedBox(width: 8),
              Obx(() => _CircleButton(
                icon: controller.isSearching.value
                    ? Icons.close_rounded
                    : Icons.search_rounded,
                onTap: controller.toggleSearch,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color(0xFFF3F4F6)),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}