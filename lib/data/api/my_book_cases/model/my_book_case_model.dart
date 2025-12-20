import 'package:json_annotation/json_annotation.dart';

import '../../my_books/model/my_books_response.dart';

part 'my_book_case_model.g.dart';

// Custom function to safely convert books_count to int
int _toIntSafe(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

@JsonSerializable()
class BookCaseResponse {
  final int status;
  final String message;
  @JsonKey(name: 'data')
  final dynamic rawData;

  BookCaseResponse({
    required this.status,
    required this.message,
    required this.rawData,
  });

  BookCase? get singleData {
    if (rawData is Map<String, dynamic>) {
      return BookCase.fromJson(rawData);
    }
    return null;
  }

  List<BookCase> get data {
    if (rawData is List) {
      return (rawData as List)
          .map((e) => BookCase.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  factory BookCaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BookCaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookCaseResponseToJson(this);
}

@JsonSerializable()
class BookCaseDetailResponse {
  final int status;
  final String message;
  final BookCase data;

  BookCaseDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookCaseDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BookCaseDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookCaseDetailResponseToJson(this);
}

@JsonSerializable()
class BookCase {
  final int id;
  final String name;

  @JsonKey(name: 'books_count', fromJson: _toIntSafe)
  final int booksCount;
  @JsonKey(defaultValue: [])
  final List<MyBookItem> books;

  BookCase({
    required this.id,
    required this.name,
    required this.booksCount,
    required this.books,
  });

  factory BookCase.fromJson(Map<String, dynamic> json) =>
      _$BookCaseFromJson(json);

  Map<String, dynamic> toJson() => _$BookCaseToJson(this);
}
