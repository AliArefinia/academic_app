part of 'study_tour_list_cubit.dart';

@freezed
class StudyTourListState with _$StudyTourListState {
  const factory StudyTourListState.initial() = _Initial;
  const factory StudyTourListState.loading() = _Loading;
  const factory StudyTourListState.loaded(List<StudyTourModel> studyTours) = _Loaded;
  const factory StudyTourListState.empty() = _Empty;
  const factory StudyTourListState.error(String message) = _Error;
}
