import 'package:academic/l10n/l10n.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/product_request/product_request_api.dart';
import 'package:academic/data/api/product_request/model/product_request_model.dart';
import 'dart:io';

abstract class IProductRequestRepository {
  Future<ProductRequestResponse> uploadProductRequest({
    required String name,
    required int numberOfPages,
    required String publishYear,
    required String type,
    required String price,
    required String content,
    required int categoryId,
    required File file,
    File? sample,
    File? image,
  });
}

@LazySingleton(as: IProductRequestRepository)
class ProductRequestRepository implements IProductRequestRepository {
  final ProductRequestApi _api;

  ProductRequestRepository(this._api);

  @override
  Future<ProductRequestResponse> uploadProductRequest({
    required String name,
    required int numberOfPages,
    required String publishYear,
    required String type,
    required String price,
    required String content,
    required int categoryId,
    required File file,
    File? sample,
    File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'number_of_pages': numberOfPages.toString(),
        'publish_year': publishYear,
        'type': type,
        'price': price,
        'content': content,
        'category_id': categoryId.toString(),
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
        if (sample != null)
          'sample': await MultipartFile.fromFile(
            sample.path,
            filename: sample.path.split('/').last,
          ),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await _api.uploadProductRequest(formData);
      return response;
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ??
          e.message ??
          l10n.errorUploadingProduct;
      throw Exception(message);
    } catch (e) {
      throw Exception(l10n.unexpectedErrorWithMessage(e.toString()));
    }
  }
}

