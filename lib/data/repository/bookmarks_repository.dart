import 'package:injectable/injectable.dart';
import '../api/bookmarks/bookmarks_api.dart';
import '../api/bookmarks/model/bookmarks_response.dart';
import '../api/bookmarks/model/bookmarks_list_response.dart';

abstract class IBookmarksRepository {
  Future<BookmarksResponse> toggleBookmark({
    required String bookmarkableType,
    required int bookmarkableId,
  });
  
  Future<BookmarksListResponse> getBookmarks({
    int? limit,
    int? page,
  });
}

@LazySingleton(as: IBookmarksRepository)
class BookmarksRepository implements IBookmarksRepository {
  final BookmarksApi _api;

  BookmarksRepository(this._api);

  @override
  Future<BookmarksResponse> toggleBookmark({
    required String bookmarkableType,
    required int bookmarkableId,
  }) async {
    try {
      final response = await _api.toggleBookmark({
        'bookmarkable_type': bookmarkableType,
        'bookmarkable_id': bookmarkableId,
      });
      return response;
    } catch (e) {
      throw Exception('Failed to toggle bookmark: $e');
    }
  }

  @override
  Future<BookmarksListResponse> getBookmarks({
    int? limit,
    int? page,
  }) async {
    try {
      final response = await _api.getBookmarks(
        limit: limit,
        page: page,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get bookmarks: $e');
    }
  }
} 