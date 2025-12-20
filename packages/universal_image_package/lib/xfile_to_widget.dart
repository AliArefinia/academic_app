import 'package:cross_file/cross_file.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_image_flutter/base_cached_image.dart';
import 'package:universal_image_flutter/universal_image_loader.dart';
import 'package:universal_image_flutter/xfile_ext.dart';

final class XFileToWidget extends StatelessWidget {
  final XFile xFile;
  final UniversalImageLoaderOption option;

  const XFileToWidget(this.xFile, {super.key, this.option = const UniversalImageLoaderOption()});

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
    if (kIsWeb) {
      return _xFileWebHandler(xFile);
    } else if (_isUrl(xFile.path)) {
      return ExtendedImage.network(xFile.path);
    } else if (xFile.path.contains("assets/")) {
      return Image.asset(xFile.path);
    } else {
      return Image.file(xFile.toFile);
    }
  }

  Widget _xFileWebHandler(XFile xFile) {
    if (_isUrl(xFile.path)) {
      return ExtendedImage.network(xFile.path);
    } else if (xFile.path.contains("assets/")) {
      return Image.asset(xFile.path);
    }
    return FutureBuilder<Uint8List>(
      future: xFile.readAsBytes(),
      builder: (context, snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          children = <Widget>[
            if (snapshot.data != null)
              Image.memory(
                snapshot.data!,
                height: option.height,
                color: option.color,
                colorBlendMode: option.blendMode,
                width: option.width,
                fit: option.fit,
              )
            else
              BaseCachedNetworkImage(
                imageUrl: xFile.path,
                option: option,
              )
          ];
        } else if (snapshot.hasError) {
        } else {
          children = <Widget>[
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
