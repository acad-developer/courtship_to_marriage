import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/legal_document.dart';

class LegalHighlightCard extends StatelessWidget {
  final LegalHighlight highlight;
  const LegalHighlightCard({super.key, required this.highlight});

  static IconData iconFor(LegalIcon icon) {
    switch (icon) {
      case LegalIcon.person:
        return Icons.person_outline_rounded;
      case LegalIcon.tune:
        return Icons.tune_rounded;
      case LegalIcon.shield:
        return Icons.verified_user_outlined;
      case LegalIcon.lock:
        return Icons.lock_outline_rounded;
      case LegalIcon.description:
        return Icons.description_outlined;
      case LegalIcon.gavel:
        return Icons.gavel_rounded;
      case LegalIcon.payments:
        return Icons.payments_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(iconFor(highlight.icon),
                color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(highlight.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 3),
                Text(highlight.text,
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
  }
}
