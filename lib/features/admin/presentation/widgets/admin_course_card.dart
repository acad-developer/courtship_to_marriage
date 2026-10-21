import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/admin_course.dart';

enum CourseMenuAction { edit, lessons, togglePublish, delete }

class AdminCourseCard extends StatelessWidget {
  final AdminCourse course;
  final VoidCallback onTap;
  final ValueChanged<CourseMenuAction> onAction;

  const AdminCourseCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.onAction,
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
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 88,
                  height: 88,
                  child: AppNetworkImage(course.imageUrl),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _Chip(
                          text: course.isPublished ? 'PUBLISHED' : 'DRAFT',
                          background: course.isPublished
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFF3F4F6),
                          foreground: course.isPublished
                              ? const Color(0xFF16A34A)
                              : AppColors.textSecondary,
                        ),
                        _Chip(
                          text: course.language.toUpperCase(),
                          background: AppColors.primaryLight,
                          foreground: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading(17)),
                    const SizedBox(height: 6),
                    Text(
                      '${Formatters.price(course.priceUsd)}  •  '
                          '${Formatters.inr(course.priceInr)}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${course.lessonCount} lessons  •  '
                          '${Formatters.hours(course.totalHours)}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<CourseMenuAction>(
                onSelected: onAction,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_vert_rounded,
                    color: AppColors.textSecondary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: CourseMenuAction.edit, child: Text('Edit course')),
                  const PopupMenuItem(
                      value: CourseMenuAction.lessons,
                      child: Text('Manage lessons')),
                  PopupMenuItem(
                    value: CourseMenuAction.togglePublish,
                    child: Text(
                        course.isPublished ? 'Move to draft' : 'Publish'),
                  ),
                  const PopupMenuItem(
                    value: CourseMenuAction.delete,
                    child:
                    Text('Delete', style: TextStyle(color: AppColors.error)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  const _Chip({
    required this.text,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: foreground,
        ),
      ),
    );
  }
}