
import 'package:injectable/injectable.dart';
import '../api/home/home_api_service.dart';
import '../api/home/model/home_response.dart';


@lazySingleton
class HomeRepository {
  final HomeApiService _apiService;

  HomeRepository(this._apiService);

  Future<HomeResponse> fetchHomeData() {
    return _apiService.getHome();
  }
}
