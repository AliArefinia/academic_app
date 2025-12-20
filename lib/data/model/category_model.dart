import 'package:academic/core/error/json_parsing_error_handler.dart';

class CategoryModel {
  final int id;
  final String? name;

  CategoryModel({
    required this.id,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<CategoryModel>(
      modelName: 'CategoryModel',
      json: json,
      parseFunction: () => CategoryModel(
        id: json['id'],
        name: json['name'],
      ),
    );
  }
} 