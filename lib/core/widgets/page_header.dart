import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../theme/app_theme.dart';

class AppPageHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  const AppPageHeader({
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
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack ?? Get.back,
                icon: const Icon(Icons.arrow_back_rounded,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading(20)),
              ),
              trailing ?? const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}