import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'user_review_model.g.dart';

@JsonSerializable()
class UserReviewModel {
  final int? id;
  final String? name; // Book Name
  final String? type; // Book Type
  final String? image; // Book Image
  @JsonKey(name: 'author_names')
  final List<String>? authorNames; // Book Author Names
  @JsonKey(name: 'publisher_name')
  final String? publisherName; // Book Publisher Name
  @JsonKey(fromJson: _stringToInt) // User's Rate for the Book (assuming it comes as a String)
  final int? rate;
  final String? comment; // User's comment text

  UserReviewModel({
    this.id,
    this.name,
    this.type,
    this.image,
    this.authorNames,
    this.publisherName,
    this.rate,
    this.comment,
  });

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<UserReviewModel>(
      modelName: 'UserReviewModel',
      json: json,
      parseFunction: () => _$UserReviewModelFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$UserReviewModelToJson(this);
}

// Helper function to convert String to int, handling null and invalid format
int? _stringToInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}
 