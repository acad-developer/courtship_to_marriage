import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../controllers/my_learning_controller.dart';
import '../widgets/purchased_course_card.dart';

class MyLearningView extends GetView<MyLearningController> {
  /// Called when the empty state's button is tapped (go to Courses tab).
  final VoidCallback onExplore;
  const MyLearningView({super.key, required this.onExplore});

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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Learning', style: AppTextStyles.heading(32)),
                  const SizedBox(height: 6),
                  const Text(
                    'Your purchased courses, all in one place.',
                    style: TextStyle(
                        fontSize: 15, color: AppColors.textSecondary),
                  ),
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
            if (controller.hasError.value) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not load your courses.',
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

            final list = controller.courses;
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: controller.refreshList,
              child: list.isEmpty
                  ? _EmptyState(onExplore: onExplore)
                  : ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (_, i) => PurchasedCourseCard(
                  course: list[i],
                  onOpen: () => controller.openCourse(list[i]),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onExplore;
  const _EmptyState({required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(32, 96, 32, 32),
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.primaryLight),
          child: const Icon(Icons.school_rounded,
              size: 38, color: AppColors.primary),
        ),
        const SizedBox(height: 24),
        Text('No courses yet',
            textAlign: TextAlign.center, style: AppTextStyles.heading(24)),
        const SizedBox(height: 10),
        const Text(
          'Courses you purchase will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        Center(
          child: ElevatedButton(
            onPressed: onExplore,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: const Text('Explore Courses',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}