import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/api/home/model/book_model.dart';
import 'package:academic/data/api/categories/categories_api.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'package:get_it/get_it.dart';

part 'category_products_state.dart';
part 'category_products_cubit.freezed.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  bool isText = false;
  bool isAudio = false;
  List<int> selectedAuthors = [];
  List<int> selectedTranslators = [];
  List<int> selectedSpeakers = [];
  List<int> selectedPublishers = [];
  final CategoriesApi _categoriesApi = GetIt.I<CategoriesApi>();

  CategoryProductsCubit() : super(const CategoryProductsState.initial());

  void toggleText() {
    isText = !isText;
    fetchWithFilters();
  }

  void toggleAudio() {
    isAudio = !isAudio;
    fetchWithFilters();
  }

  void setAuthors(List<int> authors) {
    selectedAuthors = authors;
    fetchWithFilters();
  }

  void setTranslators(List<int> translators) {
    selectedTranslators = translators;
    fetchWithFilters();
  }

  void setSpeakers(List<int> speakers) {
    selectedSpeakers = speakers;
    fetchWithFilters();
  }

  void setPublishers(List<int> publishers) {
    selectedPublishers = publishers;
    fetchWithFilters();
  }

  void fetchWithFilters() {
    fetchCategoryProducts(
      categoryId: _lastCategoryId,
      text: isText ? 1 : 0,
      audio: isAudio ? 1 : 0,
      authors: selectedAuthors,
      translators: selectedTranslators,
      speakers: selectedSpeakers,
      publishers: selectedPublishers,
    );
  }

  int _lastCategoryId = 0;

  Future<void> fetchCategoryProducts({
    required int categoryId,
    String? query,
    int? audio,
    int? text,
    List<int>? translators,
    List<int>? authors,
    List<int>? speakers,
    List<int>? publishers,
  }) async {
    try {
      _lastCategoryId = categoryId;
      emit(const CategoryProductsState.loading());
      final response = await _categoriesApi.getCategoryProducts(
        categoryId,
        query: query,
        audio: audio,
        text: text,
        translators: translators,
        authors: authors,
        speakers: speakers,
        publishers: publishers,
      );
      emit(CategoryProductsState.success(products: response.products));
    } catch (e) {
      emit(CategoryProductsState.error(e.toString()));
    }
  }
} 