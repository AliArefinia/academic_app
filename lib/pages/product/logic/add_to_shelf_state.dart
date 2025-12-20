part of 'add_to_shelf_cubit.dart';

@freezed
class AddToShelfState with _$AddToShelfState {
  const factory AddToShelfState.initial() = _Initial;
  const factory AddToShelfState.loading() = _Loading;
  const factory AddToShelfState.success(List<BookCase> shelves) = _Success;
  const factory AddToShelfState.error(String message) = _Error;
  const factory AddToShelfState.bookAdded() = _BookAdded;
} 