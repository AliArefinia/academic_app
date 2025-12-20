import 'package:json_annotation/json_annotation.dart';

part 'study_tour_request_model.g.dart';

@JsonSerializable()
class StudyTourRequestModel {
  @JsonKey(name: 'category_id')
  final int categoryId;
  final String title;
  final String description;

  const StudyTourRequestModel({
    required this.categoryId,
    required this.title,
    required this.description,
  });

  factory StudyTourRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StudyTourRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourRequestModelToJson(this);
}

@JsonSerializable()
class StudyTourRequestResponse {
  final int status;
  final String message;
  final StudyTourRequestData data;
  final int code;

  const StudyTourRequestResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory StudyTourRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$StudyTourRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourRequestResponseToJson(this);
}

@JsonSerializable()
class StudyTourRequestData {
  final String title;
  final String category;
  final String description;
  final String? answer;
  final List<dynamic> books;
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const StudyTourRequestData({
    required this.title,
    required this.category,
    required this.description,
    this.answer,
    required this.books,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyTourRequestData.fromJson(Map<String, dynamic> json) =>
      _$StudyTourRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourRequestDataToJson(this);
}

@JsonSerializable()
class StudyTourRequestListResponse {
  final int status;
  final String message;
  final StudyTourRequestListData data;
  final int code;

  const StudyTourRequestListResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory StudyTourRequestListResponse.fromJson(Map<String, dynamic> json) =>
      _$StudyTourRequestListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourRequestListResponseToJson(this);
}

@JsonSerializable()
class StudyTourRequestListData {
  final List<StudyTourRequestData> list;

  const StudyTourRequestListData({
    required this.list,
  });

  factory StudyTourRequestListData.fromJson(Map<String, dynamic> json) =>
      _$StudyTourRequestListDataFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourRequestListDataToJson(this);
}

@JsonSerializable()
class StudyTourBook {
  final int id;
  final String type;
  final String name;
  final String image;
  final int price;
  @JsonKey(name: 'discount_price')
  final int discountPrice;

  const StudyTourBook({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.price,
    required this.discountPrice,
  });

  factory StudyTourBook.fromJson(Map<String, dynamic> json) =>
      _$StudyTourBookFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourBookToJson(this);
}
