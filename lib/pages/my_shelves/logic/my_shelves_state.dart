part of 'my_shelves_cubit.dart';

@freezed
class MyshelvesState with _$MyshelvesState {
  const factory MyshelvesState.initial() = _Initial;
  const factory MyshelvesState.loading() = _Loading;
  const factory MyshelvesState.success(List<BookCase> shelves) = _Success;
  const factory MyshelvesState.error(String message) = _Error;
}