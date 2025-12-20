
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final String? image;
  final String? link;

  BannerModel({this.image, this.link});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<BannerModel>(
      modelName: 'BannerModel',
      json: json,
      parseFunction: () => _$BannerModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
