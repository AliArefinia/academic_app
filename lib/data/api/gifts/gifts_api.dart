import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/my_gifts_model.dart';

part 'gifts_api.g.dart';

@lazySingleton
@RestApi()
abstract class GiftsApi {
  @factoryMethod
  factory GiftsApi(Dio dio) = _GiftsApi;

  @GET('/api/my-gifts')
  Future<MyGiftsResponse> getMyGifts();
}
