import 'package:flutter/material.dart';

class PurchasedBadge extends StatelessWidget {
  final String text;
  final bool large;

  const PurchasedBadge({
    super.key,
    this.text = 'Already purchased',
    this.large = false,
  });

  static const _green = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    if (!large) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, size: 18, color: _green),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _green,
              ),
            ),
          ),
        ],
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, size: 26, color: _green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}