import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'package:academic/data/api/people/people_api.dart';
import 'package:get_it/get_it.dart';

part 'speakers_state.dart';
part 'speakers_cubit.freezed.dart';

class SpeakersCubit extends Cubit<SpeakersState> {
  final PeopleApi _api = GetIt.I<PeopleApi>();
  SpeakersCubit() : super(const SpeakersState.initial());

  Future<void> fetchSpeakers({String? query}) async {
    emit(const SpeakersState.loading());
    try {
      final response = await _api.getSpeakers();
      final speakers = response.data;
      final filtered = query == null || query.isEmpty
          ? speakers
          : speakers.where((a) => a.name.contains(query)).toList();
      emit(SpeakersState.success(filtered));
    } catch (e) {
      emit(SpeakersState.error(e.toString()));
    }
  }
} 