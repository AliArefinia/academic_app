import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'package:academic/data/repository/categories_repository.dart';
import 'package:academic/data/repository/study_tour_request_repository.dart';

part 'study_tour_request_state.dart';
part 'study_tour_request_cubit.freezed.dart';

@injectable
class StudyTourRequestCubit extends Cubit<StudyTourRequestState> {
  final ICategoriesRepository _categoriesRepository;
  final IStudyTourRequestRepository _studyTourRequestRepository;

  StudyTourRequestCubit(
    this._categoriesRepository,
    this._studyTourRequestRepository,
  ) : super(const StudyTourRequestState.initial());

  Future<void> loadCategories() async {
    try {
      emit(const StudyTourRequestState.loadingCategories());
      final response = await _categoriesRepository.getCategories(query: '');
      print('📋 Loaded categories:');
      print('📋 Main categories:');
      for (final category in response.mainCategories) {
        print('  - ID: ${category.id}, Name: ${category.name}');
      }
      print('📋 Featured categories:');
      for (final category in response.featured) {
        print('  - ID: ${category.id}, Name: ${category.name}');
      }

      // برای درخواست سیر مطالعاتی از featured categories استفاده کن
      emit(StudyTourRequestState.categoriesLoaded(response.featured));
    } catch (e) {
      print('❌ Error loading categories: $e');
      emit(StudyTourRequestState.error('خطا در بارگذاری دسته‌بندی‌ها'));
    }
  }

  Future<void> submitRequest({
    required int categoryId,
    required String title,
    required String description,
  }) async {
    try {
      print('🚀 Starting to submit study tour request...');
      print('📝 Category ID: $categoryId');
      print('📝 Title: $title');
      print('📝 Description: $description');

      emit(const StudyTourRequestState.loadingSubmission());
      print('📤 Emitted loading submission state');

      final response = await _studyTourRequestRepository.submitRequest(
        categoryId: categoryId,
        title: title,
        description: description,
      );

      print('✅ API response received: ${response.message}');
      emit(StudyTourRequestState.success(response.message));
      print('📤 Emitted success state');
    } catch (e, stackTrace) {
      print('❌ Error in submitRequest: $e');
      print('📋 Stack trace: $stackTrace');

      emit(StudyTourRequestState.error(ErrorMessageMapper.mapError(e)));
      print('📤 Emitted error state');
    }
  }
}
