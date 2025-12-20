import 'package:injectable/injectable.dart';
import '../api/likes/likes_api.dart';
import '../api/likes/model/likes_response.dart';

abstract class ILikesRepository {
  Future<LikesResponse> toggleLike({
    required String likeableType,
    required int likeableId,
  });
}

@LazySingleton(as: ILikesRepository)
class LikesRepository implements ILikesRepository {
  final LikesApi _api;

  LikesRepository(this._api);

  @override
  Future<LikesResponse> toggleLike({
    required String likeableType,
    required int likeableId,
  }) async {
    try {
      final response = await _api.toggleLike({
        'likeable_type': likeableType,
        'likeable_id': likeableId,
      });
      return response;
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }
} 