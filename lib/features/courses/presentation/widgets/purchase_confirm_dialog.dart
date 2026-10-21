import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/utils/currency.dart';
import '../../domain/entities/course_entity.dart';

class PurchaseConfirmDialog extends StatelessWidget {
  final CourseEntity course;
  final Currency currency;
  final VoidCallback onConfirm;

  const PurchaseConfirmDialog({
    super.key,
    required this.course,
    required this.currency,
    required this.onConfirm,
  });

  static const _green = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    final price = course.priceIn(currency);
    final original = course.originalPriceIn(currency);
    final listPrice = original ?? price;
    final hasDiscount = original != null;
    final savings = listPrice - price;
    final percent = hasDiscount ? (savings / listPrice * 100).round() : 0;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryLight),
              child: const Icon(Icons.shopping_bag_outlined,
                  color: AppColors.primary, size: 30),
            ),
            const SizedBox(height: 16),
            Text('Confirm Your Purchase',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading(24)),
            const SizedBox(height: 6),
            const Text(
              'Please review your order before continuing',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 22),
            _CourseSummary(course: course),
            const SizedBox(height: 20),
            _PriceRow(
              label: 'Course price',
              value: Formatters.money(listPrice, currency),
            ),
            if (hasDiscount) ...[
              const SizedBox(height: 10),
              _PriceRow(
                label: 'Discount ($percent% off)',
                value: '-${Formatters.money(savings, currency)}',
                valueColor: _green,
              ),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1, color: AppColors.border),
            ),
            _PriceRow(
              label: 'Total',
              value: Formatters.money(price, currency),
              emphasized: true,
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  _Perk(text: 'One-time payment, no subscription'),
                  SizedBox(height: 8),
                  _Perk(text: 'Lifetime access to all lessons'),
                ],
              ),
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'CONFIRM PURCHASE',
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Cancel',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary)),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'By confirming, you agree to our Terms & Conditions.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: AppColors.hint),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseSummary extends StatelessWidget {
  final CourseEntity course;
  const _CourseSummary({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AppNetworkImage(course.imageUrl, width: 64, height: 64),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(16)),
                const SizedBox(height: 6),
                Text(
                  '${course.language} • ${course.lessonCount} Lessons • '
                      '${Formatters.hours(course.durationHours)}',
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool emphasized;

  const _PriceRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: emphasized ? 17 : 14,
            fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
            color: emphasized ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: emphasized ? 24 : 14,
            fontWeight: FontWeight.w700,
            color: valueColor ??
                (emphasized ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _Perk extends StatelessWidget {
  final String text;
  const _Perk({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle_rounded,
            size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textPrimary)),
        ),
      ],
    );
  }
}