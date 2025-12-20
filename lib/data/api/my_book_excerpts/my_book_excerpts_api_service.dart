import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/model/my_book_excerpt.dart';
import 'package:academic/data/model/my_book_excerpt_comment.dart';

@lazySingleton
class MyBookExcerptsApiService {
  final Dio _dio;

  MyBookExcerptsApiService(this._dio);

  Future<List<MyBookExcerpt>> getMyBookExcerpts() async {
    try {
      final response = await _dio.get('/api/my-book-excerpts');
      final List<dynamic> data = response.data['data']['list'];
      return data.map((json) => MyBookExcerpt.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }


  Future<List<MyBookExcerptComment>> getMyBookExcerptComments(int excerptId) async {
    try {
      final response = await _dio.get('/api/my-book-excerpts/comments/$excerptId');
      final List<dynamic> data = response.data['data']['list'];
      return data.map((json) => MyBookExcerptComment.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
} 