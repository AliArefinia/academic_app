// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_book_case_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCaseResponse _$BookCaseResponseFromJson(Map<String, dynamic> json) =>
    BookCaseResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      rawData: json['data'],
    );

Map<String, dynamic> _$BookCaseResponseToJson(BookCaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.rawData,
    };

BookCaseDetailResponse _$BookCaseDetailResponseFromJson(
        Map<String, dynamic> json) =>
    BookCaseDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: BookCase.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookCaseDetailResponseToJson(
        BookCaseDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

BookCase _$BookCaseFromJson(Map<String, dynamic> json) => BookCase(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      booksCount: _toIntSafe(json['books_count']),
      books: (json['books'] as List<dynamic>?)
              ?.map((e) => MyBookItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BookCaseToJson(BookCase instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'books_count': instance.booksCount,
      'books': instance.books,
    };
