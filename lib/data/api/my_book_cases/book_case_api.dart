// 📁 lib/data/api/book_case/book_case_api.dart

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import 'model/my_book_case_model.dart';

part 'book_case_api.g.dart';

@lazySingleton
@RestApi()
abstract class BookCaseApi {
  @factoryMethod
  factory BookCaseApi(Dio dio) = _BookCaseApi;

  @GET('/api/book-cases')
  Future<BookCaseResponse> getBookCases();


  @GET('/api/book-cases/{id}/books')
  Future<BookCaseDetailResponse> getBooksForCase(@Path("id") int id);

  @POST('/api/book-cases/store')
  Future<BookCaseResponse> createBookCase(@Body() Map<String, dynamic> body);

  @POST('/api/book-cases/{caseId}/books/{bookId}')
  Future<BookCaseDetailResponse> addBookToCase(
    @Path("caseId") int caseId,
    @Path("bookId") int bookId,
  );

  @DELETE('/api/book-cases/{id}')
  Future<BookCaseResponse> deleteBookCase(@Path("id") int id);
}