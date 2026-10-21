import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/contact_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/help_support_controller.dart';
import '../utils/faq_items.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppPageHeader(title: 'Help & Support'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Frequently Asked Questions',
                      style: AppTextStyles.heading(24)),
                  const SizedBox(height: 16),
                  for (final item in faqItems) _FaqTile(item: item),
                  const SizedBox(height: 32),
                  Text('Still need help?', style: AppTextStyles.heading(24)),
                  const SizedBox(height: 8),
                  const Text(
                    "Can't find your answer? Reach us directly, or send us a "
                        'message.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  _ContactCard(controller: controller),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'CONTACT US',
                    onPressed: controller.openContactUs,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final FaqItem item;
  const _FaqTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          expandedAlignment: Alignment.centerLeft,
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.hint,
          title: Text(
            item.question,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          children: [
            Text(
              item.answer,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final HelpSupportController controller;
  const _ContactCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _ContactRow(
            icon: Icons.mail_outline_rounded,
            label: 'EMAIL US',
            value: AppContact.supportEmail,
            onTap: controller.emailUs,
          ),
          const Divider(height: 1, color: AppColors.border),
          _ContactRow(
            icon: Icons.call_outlined,
            label: 'CALL US',
            value: AppContact.supportPhone,
            onTap: controller.callUs,
          ),
          const Divider(height: 1, color: AppColors.border),
          _ContactRow(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'WHATSAPP',
            value: AppContact.whatsappPhone,
            onTap: controller.whatsappUs,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryLight),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.label),
                  const SizedBox(height: 4),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.hint),
          ],
        ),
      ),
    );
  }
}