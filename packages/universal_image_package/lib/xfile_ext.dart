import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:mime/mime.dart';
import 'package:universal_image_flutter/mime_type.dart';


extension XFileExtension on XFile {
  File get toFile => File(path);

  AppMimeType get convertMimeType =>
      AppMimeType.fromStringType(_tt(mimeType)?.first ?? '');

  List<String>? _tt(url) => (lookupMimeType(url ?? '') ?? '').split('/');
}

extension FileWithXfile on File {
  XFile get toXFile => XFile(path);
}
