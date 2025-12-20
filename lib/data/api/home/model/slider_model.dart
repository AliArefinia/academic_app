
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel {
  final String? image;
  final String? link;

  SliderModel({this.image, this.link});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<SliderModel>(
      modelName: 'SliderModel',
      json: json,
      parseFunction: () => _$SliderModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$SliderModelToJson(this);
}
