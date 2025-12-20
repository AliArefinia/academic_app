// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRequestResponse _$ProductRequestResponseFromJson(
        Map<String, dynamic> json) =>
    ProductRequestResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: ProductRequestResponse._dataFromJson(json['data']),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductRequestResponseToJson(
        ProductRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

ProductRequestData _$ProductRequestDataFromJson(Map<String, dynamic> json) =>
    ProductRequestData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      numberOfPages: (json['number_of_pages'] as num?)?.toInt(),
      publishYear: json['publish_year'] as String?,
      type: json['type'] as String?,
      price: json['price'] as String?,
      content: json['content'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      file: json['file'] as String?,
      sample: json['sample'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProductRequestDataToJson(ProductRequestData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number_of_pages': instance.numberOfPages,
      'publish_year': instance.publishYear,
      'type': instance.type,
      'price': instance.price,
      'content': instance.content,
      'category_id': instance.categoryId,
      'file': instance.file,
      'sample': instance.sample,
      'image': instance.image,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
