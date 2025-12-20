import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'package:academic/data/api/people/people_api.dart';
import 'package:get_it/get_it.dart';

part 'translators_state.dart';
part 'translators_cubit.freezed.dart';

class TranslatorsCubit extends Cubit<TranslatorsState> {
  final PeopleApi _api = GetIt.I<PeopleApi>();
  TranslatorsCubit() : super(const TranslatorsState.initial());

  Future<void> fetchTranslators({String? query}) async {
    emit(const TranslatorsState.loading());
    try {
      final response = await _api.getTranslators();
      final translators = response.data;
      final filtered = query == null || query.isEmpty
          ? translators
          : translators.where((a) => a.name.contains(query)).toList();
      emit(TranslatorsState.success(filtered));
    } catch (e) {
      emit(TranslatorsState.error(e.toString()));
    }
  }
} 