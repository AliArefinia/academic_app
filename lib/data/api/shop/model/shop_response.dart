import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse {
  final ShopProductSection? pamphlets;
  final ShopProductSection? educational;
  @JsonKey(name: 'question_bank')
  final ShopProductSection? questionBank;
  final ShopProductSection? periodical;
  final ShopProductSection? quarterly;
  final ShopProductSection? monthly;
  final ShopProductSection? yearbook;

  ShopResponse({
    this.pamphlets,
    this.educational,
    this.questionBank,
    this.periodical,
    this.quarterly,
    this.monthly,
    this.yearbook,
  });

  factory ShopResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<ShopResponse>(
      modelName: 'ShopResponse',
      json: json,
      parseFunction: () => _$ShopResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);
}

@JsonSerializable()
class ShopProductSection {
  final List<ProductModel>? data;

  ShopProductSection({this.data});

  factory ShopProductSection.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<ShopProductSection>(
      modelName: 'ShopProductSection',
      json: json,
      parseFunction: () {
        // Handle nested structure: { "data": [...] }
        if (json['data'] != null && json['data'] is List) {
          final List<dynamic> items = json['data'] as List<dynamic>;
          return ShopProductSection(
            data: items
                .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
                .toList(),
          );
        }
        return _$ShopProductSectionFromJson(json);
      },
    );
  }

  Map<String, dynamic> toJson() => _$ShopProductSectionToJson(this);
}

