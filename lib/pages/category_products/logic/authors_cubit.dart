import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'package:academic/data/api/people/people_api.dart';
import 'package:get_it/get_it.dart';

part 'authors_state.dart';
part 'authors_cubit.freezed.dart';

class AuthorsCubit extends Cubit<AuthorsState> {
  final PeopleApi _api = GetIt.I<PeopleApi>();
  AuthorsCubit() : super(const AuthorsState.initial());

  Future<void> fetchAuthors({String? query}) async {
    emit(const AuthorsState.loading());
    try {
      final response = await _api.getAuthors();
      final authors = response.data;
      // اگر جستجو بود، فیلتر کن
      final filtered = query == null || query.isEmpty
          ? authors
          : authors.where((a) => a.name.contains(query)).toList();
      emit(AuthorsState.success(filtered));
    } catch (e) {
      emit(AuthorsState.error(e.toString()));
    }
  }
} 