import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TobaccoImagePlaceholder extends StatelessWidget {
  const TobaccoImagePlaceholder({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _Placeholder(width: width, height: height);
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => _Placeholder(width: width, height: height),
      errorWidget: (_, _, _) => _Placeholder(width: width, height: height),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      color: cs.surfaceContainerHighest,
      child: Icon(
        Icons.local_fire_department_outlined,
        size: 32,
        color: cs.onSurfaceVariant.withValues(alpha: 0.4),
      ),
    );
  }
}
