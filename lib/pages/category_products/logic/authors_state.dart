part of 'authors_cubit.dart';

@freezed
class AuthorsState with _$AuthorsState {
  const factory AuthorsState.initial() = _Initial;
  const factory AuthorsState.loading() = _Loading;
  const factory AuthorsState.success(List<PersonModel> authors) = _Success;
  const factory AuthorsState.error(String message) = _Error;
} 