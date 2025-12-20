import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/api/user_reviews/model/user_review_model.dart'; // Import UserReviewModel

part 'user_reviews_response.g.dart';

@JsonSerializable()
class UserReviewsResponse {
  final List<UserReviewModel> data; // Use UserReviewModel

  UserReviewsResponse({
    required this.data,
  });

  factory UserReviewsResponse.fromJson(Map<String, dynamic> json) {
    // Handle the case where data array contains mixed types (empty arrays and review objects)
    final dataList = json['data'] as List<dynamic>? ?? [];
    
    // Filter out empty arrays and only parse actual review objects
    final reviews = dataList
        .where((item) => item is Map<String, dynamic>) // Only keep Map objects
        .map((item) => UserReviewModel.fromJson(item as Map<String, dynamic>))
        .toList();
    
    return UserReviewsResponse(data: reviews);
  }
  
  Map<String, dynamic> toJson() => _$UserReviewsResponseToJson(this);
} 