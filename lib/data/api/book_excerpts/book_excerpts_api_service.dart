import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/model/book_excerpt.dart';

@lazySingleton
class BookExcerptsApiService {
  final Dio _dio;

  BookExcerptsApiService(this._dio);

  Future<List<BookExcerpt>> getBookExcerpts() async {
    try {
      final response = await _dio.get('/api/book-clipping');
      final List<dynamic> data = response.data['data']['list'];
      return data.map((json) => BookExcerpt.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<BookExcerpt> storeBookExcerpt(int bookId, String text) async {
    try {
      final response = await _dio.post(
        '/api/book-clipping/store',
        data: {
          'book_id': bookId,
          'text': text,
        },
      );
      return BookExcerpt.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
} 