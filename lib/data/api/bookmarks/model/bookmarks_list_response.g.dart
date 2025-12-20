// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarksListResponse _$BookmarksListResponseFromJson(
        Map<String, dynamic> json) =>
    BookmarksListResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BookmarksListData.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookmarksListResponseToJson(
        BookmarksListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

BookmarksListData _$BookmarksListDataFromJson(Map<String, dynamic> json) =>
    BookmarksListData(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookmarksListDataToJson(BookmarksListData instance) =>
    <String, dynamic>{
      'list': instance.list,
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      perPage: (json['perPage'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'perPage': instance.perPage,
      'total': instance.total,
    };
