import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/likes_response.dart';

part 'likes_api.g.dart';

@lazySingleton
@RestApi()
abstract class LikesApi {
  @factoryMethod
  factory LikesApi(Dio dio) = _LikesApi;

  @POST('/api/likes/toggle')
  Future<LikesResponse> toggleLike(@Body() Map<String, dynamic> body);
} 