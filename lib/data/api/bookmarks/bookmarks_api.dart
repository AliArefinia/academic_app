import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/bookmarks_response.dart';
import 'model/bookmarks_list_response.dart';

part 'bookmarks_api.g.dart';

@lazySingleton
@RestApi()
abstract class BookmarksApi {
  @factoryMethod
  factory BookmarksApi(Dio dio) = _BookmarksApi;

  @POST('/api/bookmarks/toggle')
  Future<BookmarksResponse> toggleBookmark(@Body() Map<String, dynamic> body);

  @GET('/api/bookmarks')
  Future<BookmarksListResponse> getBookmarks({
    @Query('limit') int? limit,
    @Query('page') int? page,
  });
} 