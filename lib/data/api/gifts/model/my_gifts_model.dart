import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'my_gifts_model.g.dart';

@JsonSerializable()
class MyGiftsResponse {
  final int status;
  final String message;
  final List<MyGiftItem> data;
  final int code;

  MyGiftsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory MyGiftsResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyGiftsResponse>(
      modelName: 'MyGiftsResponse',
      json: json,
      parseFunction: () => _$MyGiftsResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyGiftsResponseToJson(this);
}

@JsonSerializable()
class MyGiftItem {
  final String tracking_code;
  final int amount;
  final String type;
  final String created_at;

  MyGiftItem({
    required this.tracking_code,
    required this.amount,
    required this.type,
    required this.created_at,
  });

  factory MyGiftItem.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyGiftItem>(
      modelName: 'MyGiftItem',
      json: json,
      parseFunction: () => _$MyGiftItemFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyGiftItemToJson(this);
}
