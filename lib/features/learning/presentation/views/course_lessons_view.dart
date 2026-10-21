import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../../../core/widgets/page_header.dart';
import '../../domain/entities/lesson_entity.dart';
import '../controllers/course_lessons_controller.dart';

class CourseLessonsView extends GetView<CourseLessonsController> {
  const CourseLessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    final course = controller.course;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppPageHeader(
            title: course.title,
            trailing: IconButton(
              onPressed: controller.share,
              icon: const Icon(Icons.share_rounded,
                  color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- course info -------------------------------------
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: AppNetworkImage(course.imageUrl),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            _Pill(
                              text: course.language.toUpperCase(),
                              background: AppColors.primaryLight,
                              foreground: AppColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Obx(() {
                              final count = controller.lessons.isEmpty
                                  ? course.lessonCount
                                  : controller.lessons.length;
                              return _Pill(
                                text: '$count LESSONS',
                                background: const Color(0xFFF3F4F6),
                                foreground: AppColors.textSecondary,
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(course.displayTitle,
                            style: AppTextStyles.heading(30)),
                        const SizedBox(height: 12),
                        Text(
                          course.description,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Row(
                          children: [
                            Icon(Icons.check_circle_rounded,
                                size: 22, color: AppColors.primary),
                            SizedBox(width: 10),
                            Text(
                              'You have full access to this course',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),

                  // ---- lessons -----------------------------------------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Course Lessons',
                              style: AppTextStyles.heading(24)),
                        ),
                        const Text('Auto-play next',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textSecondary)),
                        const SizedBox(width: 6),
                        Obx(() => Switch(
                          value: controller.autoPlayNext.value,
                          onChanged: controller.toggleAutoPlay,
                        )),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primary),
                        ),
                      );
                    }
                    final error = controller.errorMessage.value;
                    if (error != null) {
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            children: [
                              Text(error,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColors.textSecondary)),
                              TextButton(
                                onPressed: controller.load,
                                child: const Text('Retry',
                                    style:
                                    TextStyle(color: AppColors.primary)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (controller.lessons.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            'Lessons for this course will appear here soon.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      );
                    }

                    final list = controller.lessons;
                    final current = controller.currentIndex.value;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
                      child: Column(
                        children: [
                          for (var i = 0; i < list.length; i++) ...[
                            _LessonCard(
                              index: i,
                              lesson: list[i],
                              isCurrent: i == current,
                              onTap: () => controller.openLesson(i),
                            ),
                            const SizedBox(height: 14),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  const _Pill({
    required this.text,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: foreground,
        ),
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final int index;
  final LessonEntity lesson;
  final bool isCurrent;
  final VoidCallback onTap;

  const _LessonCard({
    required this.index,
    required this.lesson,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isCurrent ? AppColors.primary.withValues(alpha: 0.5) : AppColors.border,
              width: isCurrent ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (lesson.displayThumbnail.isEmpty)
                        Container(color: AppColors.primaryLight)
                      else
                        Image.network(
                          lesson.displayThumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: AppColors.primaryLight),
                        ),
                      Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCurrent
                                ? AppColors.primary
                                : Colors.white.withValues(alpha: 0.9),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 20,
                            color: isCurrent
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${lesson.title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading(16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 15, color: AppColors.textSecondary),
                        const SizedBox(width: 5),
                        Text(
                          lesson.durationSeconds > 0
                              ? Formatters.clock(lesson.durationSeconds)
                              : '--:--',
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textSecondary),
                        ),
                        if (isCurrent) ...[
                          const SizedBox(width: 10),
                          const Text(
                            'CURRENT',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}