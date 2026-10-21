import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class AdminHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  const AdminHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

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
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Row(
            children: [
              InkWell(
                onTap: onBack ?? Get.back,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFF3F4F6)),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 18, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(22)),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}