import 'package:academic/data/api/people/model/person_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';
import 'package:academic/core/utils/price_parser.dart';

part 'book_model.g.dart';

String? _toStr(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

double? _toDouble(dynamic value) {
  return PriceParser.parseToDouble(value);
}

int? _toInt(dynamic value) {
  return PriceParser.parseToInt(value);
}

@JsonSerializable()
class BookModel {
  @JsonKey(fromJson: _toStr)
  final String? id;
  final String? type;
  final String? name;
  final String? image;
  final PersonModel? author;
  final String? publisher;
  @JsonKey(name: 'publisher_id', fromJson: _toInt)
  final int? publisherId;
  final String? translator;
  final String? audioTime;
  final String? content;
  @JsonKey(fromJson: _toDouble)
  final double? price;
  @JsonKey(name: 'discount_price', fromJson: _toDouble)
  final double? discountPrice;
  @JsonKey(fromJson: _toDouble)
  final double? peopleRates;
  @JsonKey(fromJson: _toInt)
  final int? numOfPeopleRates;

  BookModel({
    this.id,
    this.type,
    this.name,
    this.image,
    this.author,
    this.publisher,
    this.publisherId,
    this.translator,
    this.audioTime,
    this.content,
    this.price,
    this.discountPrice,
    this.peopleRates,
    this.numOfPeopleRates,
  });

  /// Safely converts the ID to an integer
  int? get idAsInt => _toInt(id);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<BookModel>(
      modelName: 'BookModel',
      json: json,
      parseFunction: () => _$BookModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}