import 'package:json_annotation/json_annotation.dart';

part 'study_tour_model.g.dart';

@JsonSerializable()
class StudyTourModel {
  final String title;
  final String category;
  final String description;
  final String? answer;
  final List<StudyTourBook> books;
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  StudyTourModel({
    required this.title,
    required this.category,
    required this.description,
    this.answer,
    required this.books,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyTourModel.fromJson(Map<String, dynamic> json) =>
      _$StudyTourModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourModelToJson(this);

  // Helper getters for backward compatibility
  String get id => title.hashCode.toString();
  String get categoryName => category;
  int get bookCount => books.length;
  StudyTourStatus get statusEnum {
    switch (status) {
      case 'در انتظار بررسی':
        return StudyTourStatus.pending;
      case 'پاسخ داده شد':
        return StudyTourStatus.approved;
      case 'رد شده':
        return StudyTourStatus.rejected;
      default:
        return StudyTourStatus.pending;
    }
  }
}

@JsonSerializable()
class StudyTourBook {
  final int id;
  final String type;
  final String name;
  final String image;
  final int price;
  @JsonKey(name: 'discount_price')
  final int discountPrice;

  const StudyTourBook({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.price,
    required this.discountPrice,
  });

  factory StudyTourBook.fromJson(Map<String, dynamic> json) =>
      _$StudyTourBookFromJson(json);

  Map<String, dynamic> toJson() => _$StudyTourBookToJson(this);
}

enum StudyTourStatus {
  pending,
  approved,
  rejected,
}
