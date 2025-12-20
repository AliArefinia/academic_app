import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/api/home/model/book_model.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'package:academic/data/api/home/model/category_model.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';
import 'package:academic/core/utils/price_parser.dart';

part 'product_model.g.dart';

String _toStr(dynamic value) {
  if (value == null) return ''; // Return empty string for null
  return value.toString();
}

double? _toDouble(dynamic value) {
  return PriceParser.parseToDouble(value);
}

int _toInt(dynamic value) {
  return PriceParser.parseToInt(value);
}

@JsonSerializable()
class ProductModel extends BookModel {
  /// فقط همین‌ها فیلدهای اضافه‌ی این subclass هستند
  final String? menuOfContents;
  @JsonKey(fromJson: _toStr)
  final String? bookId;
  final String? type;
  final List<PersonModel>? authors;
  final String? speaker;
  final List<CategoryModel>? categories;
  final List<ExcerptModel>? excerpts;
  final List<CommentModel>? comments;
  @JsonKey(name: 'comment_count')
  final int? commentCount;
  @JsonKey(name: 'author_books')
  final List<BookModel>? authorBooks;
  @JsonKey(name: 'publisher_books')
  final List<BookModel>? publisherBooks;
  @JsonKey(name: 'related_books')
  final List<BookModel>? relatedBooks;
  final String? epub;
  @JsonKey(name: 'file')
  final String? file;
  @JsonKey(name: 'sample_epub')
  final String? sampleEpub;
  @JsonKey(name: 'sample')
  final String? sample;
  @JsonKey(name: 'sample_audio')
  final String? sampleAudio;
  final String? time;
  @JsonKey(name: 'avg_rate')
  final double? avgRate;
  @JsonKey(name: 'file_size', fromJson: _toDouble)
  final double? fileSize;
  @JsonKey(name: 'is_purchased')
  final bool? isPurchased;
  @JsonKey(name: 'publish_year', fromJson: _toInt)
  final int? publishYear;
  final List<HeadlineModel>? headlines;
  @JsonKey(name: 'has_subsciption')
  final bool? hasSubscription;
  @JsonKey(name: 'is_bookmarked')
  final bool? isBookmarked;
  @JsonKey(name: 'is_liked')
  final bool? isLiked;
  @JsonKey(name: 'isLoggedIn')
  final bool? isLoggedIn;
  final List<TagModel>? tags;

  ProductModel({
    required super.id,
    required super.name,
    super.image,
    super.author,
    super.publisher,
    super.publisherId,
    super.translator,
    super.audioTime,
    super.content,
    super.price,
    super.discountPrice,
    super.peopleRates,
    super.numOfPeopleRates,
    this.menuOfContents,
    this.bookId,
    this.type,
    this.authors,
    this.speaker,
    this.categories,
    this.excerpts,
    this.comments,
    this.commentCount,
    this.authorBooks,
    this.publisherBooks,
    this.relatedBooks,
    this.epub,
    this.file,
    this.sampleEpub,
    this.sample,
    this.sampleAudio,
    this.time,
    this.avgRate,
    this.fileSize,
    this.isPurchased,
    this.publishYear,
    this.headlines,
    this.hasSubscription,
    this.isBookmarked,
    this.isLiked,
    this.isLoggedIn,
    this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<ProductModel>(
      modelName: 'ProductModel',
      json: json,
      parseFunction: () {
        // Create a copy to avoid modifying the original
        json = Map<String, dynamic>.from(json);
        
        // Handle nested categories structure (categories: { data: [...] })
        if (json['categories'] != null && json['categories'] is Map) {
          final categoriesMap = json['categories'] as Map<String, dynamic>;
          if (categoriesMap.containsKey('data') && categoriesMap['data'] is List) {
            json['categories'] = categoriesMap['data'];
          }
        }
        
        // Check if file is PDF
        final fileUrl = json['file']?.toString() ?? '';
        final isPdf = json['type'] == '1' || (fileUrl.isNotEmpty && fileUrl.toLowerCase().endsWith('.pdf'));
        
        // Handle file field - map to epub if epub doesn't exist AND it's not a PDF
        if (json['file'] != null && json['epub'] == null && !isPdf) {
          json['epub'] = json['file'];
        }
        
        // Handle sample field - map to sampleEpub if sampleEpub doesn't exist AND it's not a PDF
        final sampleUrl = json['sample']?.toString() ?? '';
        final isSamplePdf = sampleUrl.isNotEmpty && sampleUrl.toLowerCase().endsWith('.pdf');
        if (json['sample'] != null && json['sample_epub'] == null && !isSamplePdf) {
          json['sample_epub'] = json['sample'];
        }
        
        // Safe parse price and discount_price (could be string like "32,000")
        if (json['price'] != null) {
          final priceValue = json['price'];
          if (priceValue is String) {
            // Remove commas and parse
            json['price'] = double.tryParse(priceValue.replaceAll(',', '')) ?? 0.0;
          }
        }
        
        if (json['discount_price'] != null) {
          final discountValue = json['discount_price'];
          if (discountValue is String) {
            final parsed = double.tryParse(discountValue.replaceAll(',', ''));
            json['discount_price'] = (parsed != null && parsed > 0) ? parsed : null;
          }
        }
        
        return _$ProductModelFromJson(json);
      },
    );
  }

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class ExcerptModel {
  @JsonKey(fromJson: _toStr)
  final String? id;
  final PersonModel? author;
  final BookModel? book;
  final String? text;
  @JsonKey(name: 'likes_count', fromJson: _toInt)
  final int? likesCount;
  @JsonKey(name: 'comments_count', fromJson: _toInt)
  final int? commentsCount;

  ExcerptModel({
    this.id,
    this.author,
    this.book,
    this.text,
    this.likesCount,
    this.commentsCount,
  });

  factory ExcerptModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<ExcerptModel>(
      modelName: 'ExcerptModel',
      json: json,
      parseFunction: () {
        if (json['author'] != null && json['author'] is! Map) {
          // Handle case where author is not a Map
          json['author'] = {'id': json['author'], 'name': json['user'] ?? ''};
        }
        return _$ExcerptModelFromJson(json);
      },
    );
  }
  Map<String, dynamic> toJson() => _$ExcerptModelToJson(this);
}

@JsonSerializable()
class CommentModel {
  @JsonKey(fromJson: _toStr)
  final String? id;
  final String? comment;
  @JsonKey(name: 'user')
  final String? userName;
  @JsonKey(name: 'user_avatar')
  final String? userAvatar;
  final int? rate;
  final bool? recommendation;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  CommentModel({
    this.id,
    this.comment,
    this.userName,
    this.userAvatar,
    this.rate,
    this.recommendation,
    this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<CommentModel>(
      modelName: 'CommentModel',
      json: json,
      parseFunction: () {
        // Create a copy to avoid modifying the original
        json = Map<String, dynamic>.from(json);
        
        // Safe parse rate (could be string or int)
        if (json['rate'] != null) {
          final rateValue = json['rate'];
          if (rateValue is String) {
            json['rate'] = int.tryParse(rateValue);
          } else if (rateValue is num) {
            json['rate'] = rateValue.toInt();
          }
        }
        
        return _$CommentModelFromJson(json);
      },
    );
  }
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

@JsonSerializable()
class HeadlineModel {
  @JsonKey(fromJson: _toStr)
  final String? id;
  final String title;
  final TimeModel time;
  final String file;

  HeadlineModel({
    required this.id,
    required this.title,
    required this.time,
    required this.file,
  });

  factory HeadlineModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<HeadlineModel>(
      modelName: 'HeadlineModel',
      json: json,
      parseFunction: () => _$HeadlineModelFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$HeadlineModelToJson(this);
}

@JsonSerializable()
class TimeModel {
  @JsonKey(fromJson: _toStr)
  final String? seconds;
  @JsonKey(fromJson: _toStr)
  final String? minutes;
  @JsonKey(fromJson: _toStr)
  final String? hours;

  TimeModel({
    required this.seconds,
    required this.minutes,
    required this.hours,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<TimeModel>(
      modelName: 'TimeModel',
      json: json,
      parseFunction: () => _$TimeModelFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$TimeModelToJson(this);
}

@JsonSerializable()
class TagModel {
  @JsonKey(fromJson: _toStr)
  final String? id;
  final String? name;

  TagModel({
    this.id,
    this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<TagModel>(
      modelName: 'TagModel',
      json: json,
      parseFunction: () => _$TagModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}