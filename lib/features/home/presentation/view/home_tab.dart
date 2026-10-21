import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../my_learning/presentation/controllers/purchase_status_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/course_card.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final purchases = Get.find<PurchaseStatusController>();
    final cardWidth = MediaQuery.of(context).size.width * 0.82;

    return Column(
      children: [
        _Header(controller: controller),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _HeroBanner(onExplore: () => controller.changeTab(1)),
                const SizedBox(height: 28),
                const _FeatureStrip(),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Explore Our Courses',
                      style: AppTextStyles.heading(28)),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  if (controller.courses.isEmpty) {
                    return const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Text(
                        'New courses are coming soon.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 440,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                      itemCount: controller.courses.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (_, i) {
                        final course = controller.courses[i];
                        return Obx(() => CourseCard(
                          course: course,
                          width: cardWidth,
                          currency: controller.currency,
                          isPurchased: purchases.isPurchased(course.id),
                          onViewCourse: () => controller.openCourse(course),
                        ));
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final HomeController controller;
  const _Header({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WELCOME BACK',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                controller.userName.value.isEmpty
                    ? ' '
                    : controller.userName.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final VoidCallback onExplore;
  const _HeroBanner({required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: SizedBox(
          height: 420,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: AppColors.dark),
              Image.asset("assets/images/couple.png", fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.5),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.2, 0.55, 1],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Build a Stronger Foundation for Marriage',
                        style: AppTextStyles.heading(32, color: Colors.white)),
                    const SizedBox(height: 12),
                    Text(
                      'Learn to understand each other deeply and prepare for a '
                          'lifetime of love and partnership.',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: onExplore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                      ),
                      child: const Text('Explore Courses',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
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

class _FeatureStrip extends StatelessWidget {
  const _FeatureStrip();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  child: _FeatureItem(
                      icon: Icons.forum_rounded,
                      label: 'BETTER\nCOMMUNICATION')),
              VerticalDivider(width: 1, color: AppColors.border),
              Expanded(
                  child: _FeatureItem(
                      icon: Icons.volunteer_activism_rounded,
                      label: 'MUTUAL\nUNDERSTANDING')),
              VerticalDivider(width: 1, color: AppColors.border),
              Expanded(
                  child: _FeatureItem(
                      icon: Icons.church_rounded,
                      label: 'MARRIAGE\nPREPARATION')),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.primary, size: 30),
        const SizedBox(height: 14),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.4,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}