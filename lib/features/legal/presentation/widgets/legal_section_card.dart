import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/legal_document.dart';
import 'linked_text.dart';

class LegalSectionCard extends StatelessWidget {
  final int number;
  final LegalSection section;
  const LegalSectionCard(
      {super.key, required this.number, required this.section});

  static const _body =
      TextStyle(fontSize: 14, height: 1.6, color: AppColors.textSecondary);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              child: Text('$number',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(section.title,
                    style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final p in section.paragraphs)
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: LinkedText(p, style: _body)),
        for (final b in section.bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: LinkedText(b, style: _body)),
              ],
            ),
          ),
        for (final c in section.closing)
          Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 8),
              child: LinkedText(c, style: _body)),
      ],
    );
  }
}
