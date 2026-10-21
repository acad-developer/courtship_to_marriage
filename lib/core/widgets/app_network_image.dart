import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppNetworkImage(
      this.url, {
        super.key,
        this.fit = BoxFit.cover,
        this.width,
        this.height,
      });

  static const _placeholderAsset = 'assets/images/couple.png';

  Widget _placeholder() => Image.asset(
    _placeholderAsset,
    width: width,
    height: height,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _placeholder();
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 150),
      placeholder: (_, _) => _placeholder(),
      errorWidget: (_, _, _) => _placeholder(),
    );
  }
}