import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';
import 'package:academic/data/api/home/model/book_model.dart';

part 'bookmarks_list_response.g.dart';

@JsonSerializable()
class BookmarksListResponse {
  final int? status;
  final String? message;
  final BookmarksListData? data;
  final int? code;

  BookmarksListResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory BookmarksListResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<BookmarksListResponse>(
      modelName: 'BookmarksListResponse',
      json: json,
      parseFunction: () => _$BookmarksListResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$BookmarksListResponseToJson(this);
}

@JsonSerializable()
class BookmarksListData {
  final List<BookModel>? list;
  final Pagination? pagination;

  BookmarksListData({
    this.list,
    this.pagination,
  });

  factory BookmarksListData.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<BookmarksListData>(
      modelName: 'BookmarksListData',
      json: json,
      parseFunction: () => _$BookmarksListDataFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$BookmarksListDataToJson(this);
}

@JsonSerializable()
class Pagination {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<Pagination>(
      modelName: 'Pagination',
      json: json,
      parseFunction: () => _$PaginationFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
