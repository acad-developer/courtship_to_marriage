import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/currency.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../../../core/widgets/purchased_badge.dart';
import '../../../courses/domain/entities/course_entity.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;
  final double width;
  final Currency currency;
  final bool isPurchased;
  final VoidCallback onViewCourse;

  const CourseCard({
    super.key,
    required this.course,
    required this.width,
    required this.currency,
    required this.isPurchased,
    required this.onViewCourse,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewCourse,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(course.imageUrl),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        course.language.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading(22)),
                    const SizedBox(height: 8),
                    Text(course.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppColors.textSecondary, height: 1.4)),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: isPurchased
                              ? const Align(
                            alignment: Alignment.centerLeft,
                            child: PurchasedBadge(),
                          )
                              : Text(
                            Formatters.money(
                                course.priceIn(currency), currency),
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: onViewCourse,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.dark,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('View Course',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}