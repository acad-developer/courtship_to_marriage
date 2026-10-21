import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';

class MessageSentDialog extends StatelessWidget {
  const MessageSentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFDCFCE7)),
              child: const Icon(Icons.check_rounded,
                  color: Color(0xFF16A34A), size: 34),
            ),
            const SizedBox(height: 16),
            Text('Message Sent',
                textAlign: TextAlign.center, style: AppTextStyles.heading(24)),
            const SizedBox(height: 10),
            const Text(
              'Thank you for contacting us. Our team has received your '
                  'message and will get back to you soon.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'OK',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}