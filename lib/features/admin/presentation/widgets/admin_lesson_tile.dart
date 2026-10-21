import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/admin_lesson.dart';

enum LessonMenuAction { edit, delete }

class AdminLessonTile extends StatelessWidget {
  final int index; // position in the list (0-based), used by the drag handle
  final AdminLesson lesson;
  final VoidCallback onTap;
  final ValueChanged<LessonMenuAction> onAction;

  const AdminLessonTile({
    super.key,
    required this.index,
    required this.lesson,
    required this.onTap,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(6, 10, 4, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Icon(Icons.drag_indicator_rounded,
                      color: AppColors.hint),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: AppNetworkImage(
                    lesson.thumbnailUrl,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${index + 1}. ${lesson.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading(15)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          lesson.durationSeconds > 0
                              ? Formatters.clock(lesson.durationSeconds)
                              : '--:--',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<LessonMenuAction>(
                onSelected: onAction,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_vert_rounded,
                    color: AppColors.textSecondary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                      value: LessonMenuAction.edit, child: Text('Edit lesson')),
                  PopupMenuItem(
                    value: LessonMenuAction.delete,
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