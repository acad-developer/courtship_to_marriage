import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/course_entity.dart';
import '../controllers/course_detail_controller.dart';
import '../../../../../core/widgets/purchased_badge.dart';

class CourseDetailView extends StatefulWidget {
  final CourseEntity course;
  const CourseDetailView({super.key, required this.course});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  late final CourseDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      CourseDetailController(widget.course, Get.find(), Get.find()),
      tag: widget.course.id,
    );
  }

  @override
  void dispose() {
    Get.delete<CourseDetailController>(tag: widget.course.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final currency = controller.currency;
    final price = course.priceIn(currency);
    final original = course.originalPriceIn(currency);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: Obx(() => controller.isPurchased
          ? const SizedBox.shrink()
          : _BuyBar(
        priceText: Formatters.money(price, currency),
        onBuy: controller.buyCourse,
      )),
      body: Column(
        children: [
          _Header(
            onBack: () => Navigator.of(context).maybePop(),
            onShare: controller.share,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
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
                  const SizedBox(height: 24),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        course.language.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: AppColors.primary,
                        ),
                      ),
                      _MetaText('• ${course.lessonCount} Lessons'),
                      _MetaText('• ${Formatters.hours(course.durationHours)}'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(course.displayTitle, style: AppTextStyles.heading(32)),
                  const SizedBox(height: 16),
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.6,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(() => controller.isPurchased
                      ? const PurchasedBadge(
                    large: true,
                    text: 'You already purchased this course',
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Formatters.money(price, currency),
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      if (original != null) ...[
                        const SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            Formatters.money(original, currency),
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.hint,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ],
                  )),
                  if (course.learnings.isNotEmpty) ...[
                    const _SectionDivider(),
                    Text("What You'll Learn", style: AppTextStyles.heading(24)),
                    const SizedBox(height: 18),
                    for (final item in course.learnings) _LearningItem(item),
                  ],
                  if (course.aboutParagraphs.isNotEmpty) ...[
                    const _SectionDivider(),
                    Text('About This Course', style: AppTextStyles.heading(24)),
                    const SizedBox(height: 16),
                    for (final p in course.aboutParagraphs)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          p,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.7,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onShare;
  const _Header({required this.onBack, required this.onShare});

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
              _CircleButton(
                  icon: Icons.arrow_back_ios_new_rounded, onTap: onBack),
              const SizedBox(width: 16),
              Expanded(
                child: Text('Course Details',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(22)),
              ),
              const SizedBox(width: 8),
              _CircleButton(icon: Icons.share_rounded, onTap: onShare),
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

class _MetaText extends StatelessWidget {
  final String text;
  const _MetaText(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
  );
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 28),
    child: Divider(height: 1, color: AppColors.border),
  );
}

class _LearningItem extends StatelessWidget {
  final String text;
  const _LearningItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child:
            Icon(Icons.check_rounded, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyBar extends StatelessWidget {
  final String priceText;
  final VoidCallback onBuy;
  const _BuyBar({required this.priceText, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ONE-TIME PAYMENT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                priceText,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text('Buy Course',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}