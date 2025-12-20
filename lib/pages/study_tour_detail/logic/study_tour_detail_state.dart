part of 'study_tour_detail_cubit.dart';

@freezed
class StudyTourDetailState with _$StudyTourDetailState {
  const factory StudyTourDetailState.initial() = _Initial;
  const factory StudyTourDetailState.loading() = _Loading;
  const factory StudyTourDetailState.loaded(StudyTourDetailModel studyTour) = _Loaded;
  const factory StudyTourDetailState.error(String message) = _Error;
}
