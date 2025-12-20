part of 'study_tour_request_cubit.dart';

@freezed
class StudyTourRequestState with _$StudyTourRequestState {
  const factory StudyTourRequestState.initial() = _Initial;
  const factory StudyTourRequestState.loadingCategories() = _LoadingCategories;
  const factory StudyTourRequestState.loadingSubmission() = _LoadingSubmission;
  const factory StudyTourRequestState.categoriesLoaded(List<CategoryModel> categories) = _CategoriesLoaded;
  const factory StudyTourRequestState.success(String message) = _Success;
  const factory StudyTourRequestState.error(String message) = _Error;
}
