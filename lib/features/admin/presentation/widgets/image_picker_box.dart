import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';

class ImagePickerBox extends StatelessWidget {
  final File? file;
  final String url;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final double aspectRatio;

  const ImagePickerBox({
    super.key,
    required this.file,
    required this.url,
    required this.onTap,
    this.title = 'Tap to add image',
    this.subtitle = 'Landscape (16:9) works best, under 5 MB',
    this.aspectRatio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = file != null || url.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (file != null)
                Image.file(file!, fit: BoxFit.cover)
              else if (url.isNotEmpty) AppNetworkImage(url)
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_photo_alternate_outlined,
                        size: 44, color: AppColors.primary),
                    const SizedBox(height: 10),
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              if (hasImage)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_rounded, size: 14, color: Colors.white),
                        SizedBox(width: 6),
                        Text('Change',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}