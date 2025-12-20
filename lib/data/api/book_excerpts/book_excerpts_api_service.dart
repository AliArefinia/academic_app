import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/model/book_excerpt.dart';

@lazySingleton
class BookExcerptsApiService {
  final Dio _dio;

  BookExcerptsApiService(this._dio);

  Future<List<BookExcerpt>> getBookExcerpts() async {
    try {
      final response = await _dio.get('/api/book-excerpts');
      final List<dynamic> data = response.data['data']['list'];
      return data.map((json) => BookExcerpt.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

} 