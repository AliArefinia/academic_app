import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'name')
  final String? name;
  final String? icon;

  CategoryModel({
    required this.id,
    this.title,
    this.name,
    this.icon,
  });

  String get displayName => title ?? name ?? '';

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
