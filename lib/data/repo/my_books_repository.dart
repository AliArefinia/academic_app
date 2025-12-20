import 'package:academic/data/api/my_books/my_books_api.dart';
import 'package:academic/data/api/my_books/model/my_books_response.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
class MyBooksRepository {
  final MyBooksApi api;

  MyBooksRepository(this.api);

  Future<MyBooksRootResponse> fetchMyBooks({int limit = 20}) {
    return api.getMyBooks(limit);
  }
}