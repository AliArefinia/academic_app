import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_image_flutter/universal_image_loader.dart';

final class BaseCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final UniversalImageLoaderOption option;

  const BaseCachedNetworkImage({super.key, required this.imageUrl, this.option = const UniversalImageLoaderOption()});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: option.width,
        height: option.height,
        fit: option.fit,
        colorFilter: option.color != null ? ColorFilter.mode(option.color!, option.blendMode) : null,
        placeholderBuilder: (context) => Container(
          width: option.width,
          height: option.height,
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      );
    } else {
      return ExtendedImage.network(
        imageUrl,
        height: option.height,
        color: option.color,
        colorBlendMode: option.blendMode,
        width: option.width,
        fit: option.fit,
        alignment: option.alignment,
        mode: ExtendedImageMode.none,
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
              return AnimatedOpacity(
                duration: option.fadeInDuration,
                curve: option.fadeInCurve,
                opacity: 1.0,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  width: option.width,
                  height: option.height,
                  fit: option.fit,
                  color: option.color,
                  colorBlendMode: option.blendMode,
                  alignment: option.alignment,
                ),
              );
            case LoadState.failed:
              return Container(
                width: option.width,
                height: option.height,
                color: Colors.grey[200],
                child: const Icon(Icons.error),
              );
          }
        },
        // errorWidget: sl<ConfigManager>().getConfig<ImageHelperConfig>().errorWidget,
        // placeholder: sl<ConfigManager>().getConfig<ImageHelperConfig>()?.placeholder,
        // progressIndicatorBuilder: sl<ConfigManager>().getConfig<ImageHelperConfig>()?.progressIndicatorBuilder,
      );
    }
  }
}
