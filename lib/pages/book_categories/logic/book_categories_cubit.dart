import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/api/categories/model/category_model.dart';
import '../../../data/repository/categories_repository.dart';

part 'book_categories_state.dart';
part 'book_categories_event.dart'; // Add event part
part 'book_categories_cubit.freezed.dart'; // Add freezed part

@injectable
class BookcategoriesCubit extends Cubit<BookcategoriesState> {
  final ICategoriesRepository _repository;

  BookcategoriesCubit(this._repository) : super(const BookcategoriesState.initial());

  Future<void> getCategories({String? query}) async {
    try {
      emit(const BookcategoriesState.loading());
      final response = await _repository.getCategories(query: query);
      emit(BookcategoriesState.success(
        mainCategories: response.mainCategories,
        featuredCategories: response.featured,
      ));
    } catch (e) {
      emit(BookcategoriesState.error(e.toString()));
    }
  }

  Future<void> getSubCategories(int categoryId) async {
    try {
      emit(const BookcategoriesState.loading());
      final response = await _repository.getSubCategories(categoryId);
      emit(BookcategoriesState.success(
        mainCategories: response.mainCategories,
        featuredCategories: response.featured,
      ));
    } catch (e) {
      emit(BookcategoriesState.error(e.toString()));
    }
  }
}
