import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 72});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Center(
        child: Image.asset(
          AppConstants.logoPath,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
          const Icon(Icons.favorite, color: AppColors.primary),
        ),
      ),
    );
  }
}