import 'package:academic/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/repository/product_request_repository.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'package:academic/data/repository/categories_repository.dart';
import 'dart:io';
import 'upload_product_state.dart';

@injectable
class UploadProductCubit extends Cubit<UploadProductState> {
  final IProductRequestRepository _productRequestRepository;
  final ICategoriesRepository _categoriesRepository;

  UploadProductCubit(
    this._productRequestRepository,
    this._categoriesRepository,
  ) : super(const UploadProductState.initial());

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<void> loadCategories() async {
    try {
      final response = await _categoriesRepository.getCategories(query: '');
      _categories = response.mainCategories
          .where((cat) => cat.parentId == null || cat.parentId == 0)
          .toList();
    } catch (e) {
      // Silently fail - categories will be empty
      _categories = [];
    }
  }

  Future<void> uploadProduct({
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
    emit(const UploadProductState.loading());

    try {
      final response = await _productRequestRepository.uploadProductRequest(
        name: name,
        numberOfPages: numberOfPages,
        publishYear: publishYear,
        type: type,
        price: price,
        content: content,
        categoryId: categoryId,
        file: file,
        sample: sample,
        image: image,
      );

      if (response.isSuccess) {
        emit(UploadProductState.success(
          response.message.isNotEmpty
              ? response.message
              : l10n.productUploadedSuccessfully,
        ));
      } else {
        emit(UploadProductState.error(
          response.message.isNotEmpty
              ? response.message
              : l10n.errorUploadingProduct,
        ));
      }
    } catch (e) {
      emit(UploadProductState.error(e.toString()));
    }
  }
}

