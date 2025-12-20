import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_constants.dart';
import 'model/user_reviews_response.dart'; // Use a distinct model name

part 'user_reviews_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class UserReviewsApiService {
  @factoryMethod
  factory UserReviewsApiService(Dio dio) = _UserReviewsApiService;

  @GET(AppUrls.reviews)
  Future<UserReviewsResponse> getUserReviews();
} 