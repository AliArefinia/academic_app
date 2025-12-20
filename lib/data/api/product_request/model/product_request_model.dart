import 'package:json_annotation/json_annotation.dart';

part 'product_request_model.g.dart';

@JsonSerializable()
class ProductRequestResponse {
  final int status;
  final String message;
  @JsonKey(fromJson: _dataFromJson)
  final dynamic data; // Can be null, empty array, or object
  final int? code;

  ProductRequestResponse({
    required this.status,
    required this.message,
    this.data,
    this.code,
  });

  factory ProductRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRequestResponseToJson(this);

  // Helper to check if request was successful
  bool get isSuccess => status == 200;

  // Custom converter for data field
  static dynamic _dataFromJson(dynamic json) {
    // Return as-is (can be null, empty array, or object)
    return json;
  }
}

@JsonSerializable()
class ProductRequestData {
  final int id;
  final String name;
  @JsonKey(name: 'number_of_pages')
  final int? numberOfPages;
  @JsonKey(name: 'publish_year')
  final String? publishYear;
  final String? type;
  final String? price;
  final String? content;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  final String? file;
  final String? sample;
  final String? image;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  ProductRequestData({
    required this.id,
    required this.name,
    this.numberOfPages,
    this.publishYear,
    this.type,
    this.price,
    this.content,
    this.categoryId,
    this.file,
    this.sample,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductRequestData.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRequestDataToJson(this);
}

