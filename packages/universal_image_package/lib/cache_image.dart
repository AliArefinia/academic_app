import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:universal_image_flutter/universal_image_loader.dart';
final class CachedImage extends StatelessWidget {
  final String path;
  final UniversalImageLoaderOption option;

  const CachedImage(
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
      return ExtendedImage.network(
        path,
        height: option.height,
        width: option.width,
        fit: option.fit,
        alignment: option.alignment,
        color: option.color,
        colorBlendMode: option.blendMode,
        enableLoadState: true,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Container(
                width: option.width,
                height: option.height,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            case LoadState.completed:
              return state.completedWidget;
            case LoadState.failed:
              return Container(
                width: option.width,
                height: option.height,
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 24),
                ),
              );
          }
        },
      );
    } else {
      return ExtendedImage.asset(
        path,
        height: option.height,
        width: option.width,
        fit: option.fit,
        alignment: option.alignment,
        color: option.color,
        colorBlendMode: option.blendMode,
        enableLoadState: true,
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.failed) {
            return Container(
              width: option.width,
              height: option.height,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.broken_image, size: 24),
              ),
            );
          }
          return state.completedWidget;
        },
      );
    }
  }
}