import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'person_model.g.dart';

String? _toStr(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

@JsonSerializable()
class PersonModel {
  @JsonKey(fromJson: _toStr)
  final String? id;
  final String name;

  PersonModel({
    this.id,
    required this.name,
  });

  /// Safely converts the ID to an integer
  int? get idAsInt {
    if (id == null) return null;
    return int.tryParse(id!);
  }

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PersonModel>(
      modelName: 'PersonModel',
      json: json,
      parseFunction: () => _$PersonModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
} 