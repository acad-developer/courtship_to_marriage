import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/page_header.dart';
import '../../domain/entities/legal_document.dart';
import '../widgets/legal_highlight_card.dart';
import '../widgets/legal_section_card.dart';

/// Renders any [LegalDocument] (Privacy Policy, Terms & Conditions).
class LegalDocumentView extends StatelessWidget {
  final LegalDocument document;
  const LegalDocumentView({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppPageHeader(title: document.title),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('LAST UPDATED: ${document.lastUpdated}'
                            .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                                color: AppColors.primary)),
                      ),
                      const SizedBox(height: 12),
                      Text(document.intro,
                          style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                if (document.highlights.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  for (final h in document.highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LegalHighlightCard(highlight: h),
                    ),
                ],
                const SizedBox(height: 14),
                for (var i = 0; i < document.sections.length; i++) ...[
                  LegalSectionCard(number: i + 1, section: document.sections[i]),
                  if (i != document.sections.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Divider(height: 1, color: AppColors.border),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
