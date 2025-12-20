import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/core/api_constants.dart';
import 'model/home_response.dart';

part 'home_api_service.g.dart';

@lazySingleton
@RestApi()
abstract class HomeApiService {
  @factoryMethod
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(AppUrls.home)
  Future<HomeResponse> getHome();
}
