// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: _toStr(json['id']),
      name: json['name'] as String?,
      image: json['image'] as String?,
      author: json['author'] == null
          ? null
          : PersonModel.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] as String?,
      publisherId: _toInt(json['publisher_id']),
      translator: json['translator'] as String?,
      audioTime: json['audioTime'] as String?,
      content: json['content'] as String?,
      price: _toDouble(json['price']),
      discountPrice: _toDouble(json['discount_price']),
      peopleRates: _toDouble(json['peopleRates']),
      numOfPeopleRates: _toInt(json['numOfPeopleRates']),
      menuOfContents: json['menuOfContents'] as String?,
      bookId: _toStr(json['bookId']),
      type: json['type'] as String?,
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => PersonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      speaker: json['speaker'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      excerpts: (json['excerpts'] as List<dynamic>?)
          ?.map((e) => ExcerptModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentCount: (json['comment_count'] as num?)?.toInt(),
      authorBooks: (json['author_books'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      publisherBooks: (json['publisher_books'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      relatedBooks: (json['related_books'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      epub: json['epub'] as String?,
      file: json['file'] as String?,
      sampleEpub: json['sample_epub'] as String?,
      sample: json['sample'] as String?,
      sampleAudio: json['sample_audio'] as String?,
      time: json['time'] as String?,
      avgRate: (json['avg_rate'] as num?)?.toDouble(),
      fileSize: _toDouble(json['file_size']),
      isPurchased: json['is_purchased'] as bool?,
      publishYear: _toInt(json['publish_year']),
      headlines: (json['headlines'] as List<dynamic>?)
          ?.map((e) => HeadlineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasSubscription: json['has_subsciption'] as bool?,
      isBookmarked: json['is_bookmarked'] as bool?,
      isLiked: json['is_liked'] as bool?,
      isLoggedIn: json['isLoggedIn'] as bool?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'author': instance.author,
      'publisher': instance.publisher,
      'publisher_id': instance.publisherId,
      'translator': instance.translator,
      'audioTime': instance.audioTime,
      'content': instance.content,
      'price': instance.price,
      'discount_price': instance.discountPrice,
      'peopleRates': instance.peopleRates,
      'numOfPeopleRates': instance.numOfPeopleRates,
      'menuOfContents': instance.menuOfContents,
      'bookId': instance.bookId,
      'type': instance.type,
      'authors': instance.authors,
      'speaker': instance.speaker,
      'categories': instance.categories,
      'excerpts': instance.excerpts,
      'comments': instance.comments,
      'comment_count': instance.commentCount,
      'author_books': instance.authorBooks,
      'publisher_books': instance.publisherBooks,
      'related_books': instance.relatedBooks,
      'epub': instance.epub,
      'file': instance.file,
      'sample_epub': instance.sampleEpub,
      'sample': instance.sample,
      'sample_audio': instance.sampleAudio,
      'time': instance.time,
      'avg_rate': instance.avgRate,
      'file_size': instance.fileSize,
      'is_purchased': instance.isPurchased,
      'publish_year': instance.publishYear,
      'headlines': instance.headlines,
      'has_subsciption': instance.hasSubscription,
      'is_bookmarked': instance.isBookmarked,
      'is_liked': instance.isLiked,
      'isLoggedIn': instance.isLoggedIn,
      'tags': instance.tags,
    };

ExcerptModel _$ExcerptModelFromJson(Map<String, dynamic> json) => ExcerptModel(
      id: _toStr(json['id']),
      author: json['author'] == null
          ? null
          : PersonModel.fromJson(json['author'] as Map<String, dynamic>),
      book: json['book'] == null
          ? null
          : BookModel.fromJson(json['book'] as Map<String, dynamic>),
      text: json['text'] as String?,
      likesCount: _toInt(json['likes_count']),
      commentsCount: _toInt(json['comments_count']),
    );

Map<String, dynamic> _$ExcerptModelToJson(ExcerptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'book': instance.book,
      'text': instance.text,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: _toStr(json['id']),
      comment: json['comment'] as String?,
      userName: json['user'] as String?,
      userAvatar: json['user_avatar'] as String?,
      rate: (json['rate'] as num?)?.toInt(),
      recommendation: json['recommendation'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user': instance.userName,
      'user_avatar': instance.userAvatar,
      'rate': instance.rate,
      'recommendation': instance.recommendation,
      'created_at': instance.createdAt?.toIso8601String(),
    };

HeadlineModel _$HeadlineModelFromJson(Map<String, dynamic> json) =>
    HeadlineModel(
      id: _toStr(json['id']),
      title: json['title'] as String,
      time: TimeModel.fromJson(json['time'] as Map<String, dynamic>),
      file: json['file'] as String,
    );

Map<String, dynamic> _$HeadlineModelToJson(HeadlineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time': instance.time,
      'file': instance.file,
    };

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) => TimeModel(
      seconds: _toStr(json['seconds']),
      minutes: _toStr(json['minutes']),
      hours: _toStr(json['hours']),
    );

Map<String, dynamic> _$TimeModelToJson(TimeModel instance) => <String, dynamic>{
      'seconds': instance.seconds,
      'minutes': instance.minutes,
      'hours': instance.hours,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: _toStr(json['id']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
