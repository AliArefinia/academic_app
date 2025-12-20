import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/api/categories/model/category_model.dart';
import '../../../data/repository/categories_repository.dart';

part 'sub_categories_state.dart';
part 'sub_categories_cubit.freezed.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final ICategoriesRepository repository;
  SubCategoriesCubit(this.repository) : super(const SubCategoriesState.initial());

  Future<void> fetchSubCategories(int categoryId) async {
    try {
      emit(const SubCategoriesState.loading());
      final response = await repository.getSubCategories(categoryId);
      print('SUBCATEGORIES RAW RESPONSE: ' + response.toString());
      print('SUBCATEGORIES subCategories: ' + (response.subCategories?.toString() ?? 'null'));
      emit(SubCategoriesState.success(subCategories: response.subCategories ?? []));
    } catch (e) {
      emit(SubCategoriesState.error(e.toString()));
    }
  }
} 