import 'package:injectable/injectable.dart';
import '../api/gifts/gifts_api.dart';
import '../api/gifts/model/my_gifts_model.dart';

abstract class IGiftsRepository {
  Future<MyGiftsResponse> getMyGifts();
}

@LazySingleton(as: IGiftsRepository)
class GiftsRepository implements IGiftsRepository {
  final GiftsApi _api;

  GiftsRepository(this._api);

  @override
  Future<MyGiftsResponse> getMyGifts() async {
    try {
      final response = await _api.getMyGifts();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch gifts: ${e.toString()}');
    }
  }
}
