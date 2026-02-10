import 'package:injectable/injectable.dart';
import '../api/my_book_excerpts/my_book_excerpts_api_service.dart';
import '../model/my_book_excerpt.dart';
import '../model/my_book_excerpt_comment.dart';

@lazySingleton
class MyBookExcerptsRepository {
  final MyBookExcerptsApiService _apiService;

  MyBookExcerptsRepository(this._apiService);

  Future<List<MyBookExcerpt>> getMyBookExcerpts() {
    return _apiService.getMyBookExcerpts();
  }

  Future<MyBookExcerpt> storeBookExcerpt(int bookId, String text) {
    return _apiService.storeBookExcerpt(bookId, text);
  }

  Future<List<MyBookExcerptComment>> getMyBookExcerptComments(int excerptId) {
    return _apiService.getMyBookExcerptComments(excerptId);
  }
} 