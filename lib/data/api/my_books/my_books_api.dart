import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'model/my_books_response.dart';

part 'my_books_api.g.dart';


@lazySingleton
@RestApi()
abstract class MyBooksApi {
  @factoryMethod
  factory MyBooksApi(Dio dio) = _MyBooksApi;

  @GET('/api/my-books')
  Future<MyBooksRootResponse> getMyBooks(@Query("limit") int limit);
}