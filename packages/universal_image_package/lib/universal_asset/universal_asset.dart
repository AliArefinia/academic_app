import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

enum AssetType {
  icon,
  path,
  widget,
  xFile,
}

typedef UniversalAssets<T> = Map<AssetType, T>;

extension ProfileAssetsExtension on UniversalAssets {
  IconData get icon => this[AssetType.icon] as IconData;
  String get path => this[AssetType.path];
  Widget get widget => this[AssetType.widget] as Widget;
  XFile get xFile => this[AssetType.xFile] as XFile;
}
