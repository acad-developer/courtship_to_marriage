import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/admin_lessons_controller.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_lesson_tile.dart';

class AdminLessonsView extends GetView<AdminLessonsController> {
  const AdminLessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openCreate,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Lesson',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          const AdminHeader(title: 'Lessons'),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(18)),
                const SizedBox(height: 4),
                Obx(() => Text(
                  '${controller.lessons.length} lessons • '
                      '${Formatters.duration(controller.totalSeconds)} of video',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary),
                )),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
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
              if (controller.lessons.isEmpty) return const _EmptyState();

              final list = controller.lessons;
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 14, 24, 4),
                    child: Row(
                      children: [
                        Icon(Icons.drag_indicator_rounded,
                            size: 16, color: AppColors.hint),
                        SizedBox(width: 6),
                        Text('Drag the handle to reorder lessons',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
                      buildDefaultDragHandles: false,
                      itemCount: list.length,
                      onReorder: controller.reorder,
                      proxyDecorator: (child, index, animation) =>
                          Material(color: Colors.transparent, child: child),
                      itemBuilder: (_, i) {
                        final lesson = list[i];
                        return Padding(
                          key: ValueKey(lesson.id),
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AdminLessonTile(
                            index: i,
                            lesson: lesson,
                            onTap: () => controller.openEdit(lesson),
                            onAction: (a) => controller.onMenuAction(lesson, a),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
              child: const Icon(Icons.play_lesson_rounded,
                  size: 36, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text('No lessons yet', style: AppTextStyles.heading(24)),
            const SizedBox(height: 8),
            const Text(
              'Tap "Add Lesson" to add the first video to this course.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}