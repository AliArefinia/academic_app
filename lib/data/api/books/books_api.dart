import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/api/home/model/book_model.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart' as error_handler;

part 'books_api.g.dart';

@lazySingleton
@RestApi()
abstract class BooksApi {
  @factoryMethod
  factory BooksApi(Dio dio) = _BooksApi;

  @GET('/api/books')
  Future<BooksResponse> getBooks({
    @Query('tag_id') int? tagId,
    @Query('category_id') int? categoryId,
    @Query('author_id') int? authorId,
    @Query('translator_id') int? translatorId,
    @Query('speaker_id') int? speakerId,
    @Query('publisher_id') int? publisherId,
    @Query('type') String? type,
    @Query('query') String? query,
    @Query('per_page') int? perPage,
    @Query('page') int? page,
  });
}

@JsonSerializable()
class BooksResponse {
  final int status;
  final String message;
  final BooksData data;
  final int code;

  BooksResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    return error_handler.JsonParsingErrorHandler.handleParsingError<BooksResponse>(
      modelName: 'BooksResponse',
      json: json,
      parseFunction: () => _$BooksResponseFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$BooksResponseToJson(this);
}

@JsonSerializable()
class BooksData {
  final List<BookItem> list;
  final Pagination pagination;

  BooksData({
    required this.list,
    required this.pagination,
  });

  factory BooksData.fromJson(Map<String, dynamic> json) {
    return error_handler.JsonParsingErrorHandler.handleParsingError<BooksData>(
      modelName: 'BooksData',
      json: json,
      parseFunction: () => _$BooksDataFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$BooksDataToJson(this);
}

@JsonSerializable()
class BookItem {
  final int id;
  final String name;
  final String image;
  final String type;
  final double price;
  final double? discountPrice;
  final double rate;

  BookItem({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.price,
    this.discountPrice,
    required this.rate,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return error_handler.JsonParsingErrorHandler.handleParsingError<BookItem>(
      modelName: 'BookItem',
      json: json,
      parseFunction: () => _$BookItemFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$BookItemToJson(this);

  // Convert to BookModel for compatibility
  BookModel toBookModel() {
    return BookModel(
      id: id.toString(),
      name: name,
      image: image,
      type: type,
      price: price,
      discountPrice: discountPrice,
      peopleRates: rate,
      numOfPeopleRates: 0, // Default value since not provided in API
    );
  }
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'total_pages')
  final int totalPages;

  Pagination({
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return error_handler.JsonParsingErrorHandler.handleParsingError<Pagination>(
      modelName: 'Pagination',
      json: json,
      parseFunction: () => _$PaginationFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
