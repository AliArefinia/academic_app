import 'package:injectable/injectable.dart';
import '../api/book_excerpts/book_excerpts_api_service.dart';
import '../model/book_excerpt.dart';

@lazySingleton
class BookExcerptsRepository {
  final BookExcerptsApiService _apiService;

  BookExcerptsRepository(this._apiService);

  Future<List<BookExcerpt>> getBookExcerpts() async {
    try {
      final result = await _apiService.getBookExcerpts();
      return result;
    } catch (e, stackTrace) {
      print('Error fetching book excerpts: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
} 