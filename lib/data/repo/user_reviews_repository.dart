import 'package:injectable/injectable.dart';
import 'dart:developer';

import '../api/user_reviews/user_reviews_api.dart'; // Import UserReviewsApiService
import '../api/user_reviews/model/user_reviews_response.dart'; // Import UserReviewsResponse

abstract class IUserReviewsRepository {
  Future<UserReviewsResponse> getUserReviews();
}

class UserReviewsRepository implements IUserReviewsRepository {
  final UserReviewsApiService _api;

  UserReviewsRepository(this._api);

  @override
  Future<UserReviewsResponse> getUserReviews() async {
    final response = await _api.getUserReviews();
    log('DEBUG: UserReviewsResponse raw data: ${response.toJson()}');
    return response;
  }
} 