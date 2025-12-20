import 'package:cross_file/cross_file.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_image_flutter/cache_image.dart';
import 'package:universal_image_flutter/cache_svg.dart';
import 'package:universal_image_flutter/mime_type.dart';
import 'package:universal_image_flutter/xfile_ext.dart';
import 'package:universal_image_flutter/xfile_to_widget.dart';

final class UniversalImageLoaderOption {
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Color? color;
  final BlendMode blendMode;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final ColorFilter? colorFilter;

  const UniversalImageLoaderOption({
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.blendMode = BlendMode.srcIn,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeInCurve = Curves.easeOutCubic,
    this.colorFilter,
  });
}

final class UniversalImageLoader extends StatelessWidget {
  final String? path;
  final XFile? xFile;
  final UniversalImageLoaderOption option;
  final GestureTapCallback? onTap;

  const UniversalImageLoader({
    super.key,
    this.path,
    this.xFile,
    this.onTap,
    this.option = const UniversalImageLoaderOption(),
  });

  static bool _isUrl(String path) {
    try {
      final uri = Uri.parse(path);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  static ImageProvider imageProvider({String? url, XFile? file}) {
    if (url != null) {
      return ExtendedNetworkImageProvider(url, headers: const {}, cache: true);
    } else {
      if (kIsWeb) {
        return ExtendedNetworkImageProvider(file!.path);
      }
      if (file!.mimeType != null) {
        switch (file.convertMimeType) {
          case AppMimeType.image:
            return FileImage(file.toFile);
          case AppMimeType.video:
          // TODO: Handle this case.
          default:
            return FileImage(file.toFile);
        }
      }
      return FileImage(file.toFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (path != null || (xFile != null)) {
      Widget child = Container();

      if (xFile != null) {
        child = XFileToWidget(
          xFile!,
          option: option,
        );
      } else {
        if (_isUrl(path!)) {
          // For network images, always use CachedImage
          child = CachedImage(
            path!,
            option: option,
          );
        } else {
          // For local files, use CachedSvg for SVG files and CachedImage for others
          if (path!.toLowerCase().endsWith('.svg')) {
            child = CachedSvg(
              path!,
              option: option,
            );
          } else {
            child = CachedImage(
              path!,
              option: option,
            );
          }
        }
      }
      return GestureDetector(onTap: onTap, child: child);
    } else {
      return Container();
    }
  }
}
