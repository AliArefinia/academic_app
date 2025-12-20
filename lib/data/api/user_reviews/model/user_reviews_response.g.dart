// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReviewsResponse _$UserReviewsResponseFromJson(Map<String, dynamic> json) =>
    UserReviewsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserReviewsResponseToJson(
        UserReviewsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
