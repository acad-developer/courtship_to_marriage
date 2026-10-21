import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/contact_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/contact_actions.dart';
import '../../../../core/widgets/page_header.dart';
import '../../data/about_content.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (mounted) setState(() => _version = 'Version ${info.version}');
    } catch (_) {}
  }

  static IconData _icon(AboutIcon i) {
    switch (i) {
      case AboutIcon.play:
        return Icons.play_circle_outline_rounded;
      case AboutIcon.schedule:
        return Icons.schedule_rounded;
      case AboutIcon.heart:
        return Icons.favorite_border_rounded;
      case AboutIcon.support:
        return Icons.support_agent_rounded;
      case AboutIcon.phone:
        return Icons.phone_iphone_rounded;
      case AboutIcon.search:
        return Icons.search_rounded;
    }
  }

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(t, style: AppTextStyles.heading(20)),
      );

  Widget _offerCard(AboutItem item) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: AppColors.primaryLight, shape: BoxShape.circle),
              child: Icon(_icon(item.icon), color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 3),
                  Text(item.text,
                      style: const TextStyle(
                          fontSize: 13,
                          height: 1.45,
                          color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _step(int n, AboutItem item) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              child: Text('$n',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(item.text,
                      style: const TextStyle(
                          fontSize: 13,
                          height: 1.45,
                          color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _contactTile(IconData icon, String label, String value, VoidCallback onTap) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTextStyles.label),
                    const SizedBox(height: 2),
                    Text(value,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.hint),
            ],
          ),
        ),
      );

  Widget _linkRow(String label, String route) => InkWell(
        onTap: () => Get.toNamed(route),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textPrimary))),
              const Icon(Icons.chevron_right_rounded, color: AppColors.hint),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppPageHeader(title: 'About Us'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              children: [
                // Hero
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Image.asset(AppConstants.logoPath,
                          height: 72,
                          errorBuilder: (_, __, ___) => const Icon(
                              Icons.favorite_rounded,
                              color: AppColors.primary,
                              size: 56)),
                      const SizedBox(height: 14),
                      Text(AppConstants.appName,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading(24)),
                      const SizedBox(height: 8),
                      Text(AppConstants.tagline,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.label),
                      if (_version.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(_version,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _title('Our Mission'),
                const Text(AboutContent.mission,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.65,
                        color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                _title('What We Offer'),
                for (final o in AboutContent.offers) _offerCard(o),
                const SizedBox(height: 14),
                _title('How It Works'),
                for (var i = 0; i < AboutContent.steps.length; i++)
                  _step(i + 1, AboutContent.steps[i]),
                const SizedBox(height: 10),
                _title('Our Values'),
                for (final v in AboutContent.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            color: AppColors.primary, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(v,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary))),
                      ],
                    ),
                  ),
                const SizedBox(height: 22),
                _title('Get in Touch'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _contactTile(Icons.mail_outline_rounded, 'EMAIL',
                          AppContact.supportEmail, ContactActions.emailSupport),
                      const Divider(height: 1, color: AppColors.border),
                      _contactTile(Icons.call_outlined, 'PHONE',
                          AppContact.supportPhone, ContactActions.callSupport),
                      const Divider(height: 1, color: AppColors.border),
                      _contactTile(Icons.chat_outlined, 'WHATSAPP',
                          AppContact.whatsappPhone, ContactActions.whatsappSupport),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _linkRow('Privacy Policy', AppRoutes.privacyPolicy),
                      const Divider(height: 1, color: AppColors.border),
                      _linkRow('Terms & Conditions', AppRoutes.terms),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text('© ${DateTime.now().year} ${AppConstants.appName}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.hint)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
