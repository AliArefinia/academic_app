import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:universal_image_flutter/universal_image_loader.dart';
final class CachedSvg extends StatelessWidget {
  final String path;
  final UniversalImageLoaderOption option;

  const CachedSvg(
    this.path, {
    super.key,
    this.option = const UniversalImageLoaderOption(),
  });

  bool _isUrl(String path) {
    try {
      final uri = Uri.parse(path);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isUrl(path)) {
      return svg.SvgPicture.network(
        path,
        height: option.height,
        width: option.width,
        fit: option.fit,
        alignment: option.alignment,
        colorFilter: option.colorFilter,
        placeholderBuilder: (context) => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        semanticsLabel: 'Remote SVG',
      );
    } else {
      return svg.SvgPicture.asset(
        path,
        height: option.height,
        width: option.width,
        fit: option.fit,
        alignment: option.alignment,
        colorFilter: option.colorFilter,
        placeholderBuilder: (context) => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        semanticsLabel: 'Asset SVG',
      );
    }
  }
}