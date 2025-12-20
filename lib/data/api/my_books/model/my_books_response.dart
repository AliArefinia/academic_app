import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'my_books_response.g.dart';

@JsonSerializable()
class MyBooksRootResponse {
  final int? status;
  final String? message;
  final MyBooksResponse? data;
  final int? code;

  MyBooksRootResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory MyBooksRootResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyBooksRootResponse>(
      modelName: 'MyBooksRootResponse',
      json: json,
      parseFunction: () => _$MyBooksRootResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyBooksRootResponseToJson(this);
}

@JsonSerializable()
class MyBooksResponse {
  @JsonKey(name: "text_books_count")
  final int? textBooksCount;

  @JsonKey(name: "audio_books_count")
  final int? audioBooksCount;

  final List<MyBookItem>? list;

  MyBooksResponse({
    this.textBooksCount,
    this.audioBooksCount,
    this.list,
  });

  factory MyBooksResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyBooksResponse>(
      modelName: 'MyBooksResponse',
      json: json,
      parseFunction: () => _$MyBooksResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyBooksResponseToJson(this);
}

@JsonSerializable()
class MyBookItem {
  final int? id;
  final String? name;
  final String? image;
  final String? type;

  @JsonKey(name: "progress_time", fromJson: _toIntNullable)
  final int? progressTime;

  @JsonKey(name: "last_page_read", fromJson: _toIntNullable)
  final int? lastPageRead;

  MyBookItem({
    this.id,
    this.name,
    this.image,
    this.type,
    this.progressTime,
    this.lastPageRead,
  });

  factory MyBookItem.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyBookItem>(
      modelName: 'MyBookItem',
      json: json,
      parseFunction: () => _$MyBookItemFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyBookItemToJson(this);
}

/// Custom function to safely convert any value to nullable int
int? _toIntNullable(dynamic value) {
  if (value == null || value == "") return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return 0;
}