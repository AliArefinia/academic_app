import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/data/model/note.dart';
import 'model/headlines_response.dart';

part 'headlines_api.g.dart';

@lazySingleton
@RestApi()
abstract class HeadlinesApi {
  @factoryMethod
  factory HeadlinesApi(Dio dio) = _HeadlinesApi;

  @GET('/api/my-headlines')
  Future<dynamic> getMyHeadlines();

  @GET('/api/headlines')
  Future<dynamic> getAllHeadlines();

  @GET('/api/headlines/{id}')
  Future<dynamic> getHeadlineByIdRaw(@Path('id') int id);

  @POST('/api/store-headlines')
  @MultiPart()
  Future<dynamic> storeHeadlineRaw(@Body() FormData formData);

  @PUT('/api/headlines/{id}')
  @MultiPart()
  Future<dynamic> updateHeadlineRaw(
    @Path('id') int id,
    @Body() FormData formData,
  );

  @DELETE('/api/headlines/{id}')
  Future<void> deleteHeadline(@Path('id') int id);
}
