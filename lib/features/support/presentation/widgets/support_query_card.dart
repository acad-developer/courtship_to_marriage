import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/support_query.dart';

class SupportQueryCard extends StatelessWidget {
  final SupportQuery query;
  final bool isBusy;
  final VoidCallback onResolve;
  final VoidCallback onDelete;
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;

  const SupportQueryCard({
    super.key,
    required this.query,
    required this.isBusy,
    required this.onResolve,
    required this.onDelete,
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
  });

  static const _green = Color(0xFF16A34A);
  static const _orange = Color(0xFFD97706);

  @override
  Widget build(BuildContext context) {
    final resolved = query.isResolved;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: (resolved ? _green : _orange).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  resolved ? 'RESOLVED' : 'PENDING',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: resolved ? _green : _orange,
                  ),
                ),
              ),
              const Spacer(),
              if (query.createdAt != null)
                Text(
                  Formatters.dateTime(query.createdAt!),
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(query.subject, style: AppTextStyles.heading(18)),
          const SizedBox(height: 8),
          SelectableText(
            query.message,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 14),
          _InfoLine(icon: Icons.person_outline_rounded, text: query.name),
          if (query.email.isNotEmpty)
            _InfoLine(icon: Icons.mail_outline_rounded, text: query.email),
          if (query.phone.isNotEmpty)
            _InfoLine(icon: Icons.call_outlined, text: query.phone),
          const SizedBox(height: 10),
          Row(
            children: [
              if (query.phone.isNotEmpty) ...[
                _QuickAction(icon: Icons.call_rounded, onTap: onCall),
                const SizedBox(width: 10),
                _QuickAction(
                    icon: Icons.chat_bubble_outline_rounded,
                    onTap: onWhatsapp),
                const SizedBox(width: 10),
              ],
              if (query.email.isNotEmpty)
                _QuickAction(icon: Icons.mail_rounded, onTap: onEmail),
            ],
          ),
          const SizedBox(height: 16),
          if (!resolved)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: isBusy ? null : onResolve,
                icon: isBusy
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
                    : const Icon(Icons.check_circle_outline_rounded, size: 20),
                label: const Text('MARK AS RESOLVED',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, letterSpacing: 1)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                  AppColors.primary.withValues(alpha: 0.7),
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: Text(
                    query.resolvedAt != null
                        ? 'Resolved on ${Formatters.dateTime(query.resolvedAt!)}'
                        : 'Resolved',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: isBusy ? null : onDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  label: const Text('Delete',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(
                        color: AppColors.error.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.hint),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(text,
                style: const TextStyle(fontSize: 13, height: 1.3)),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryLight),
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
    );
  }
}