import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'package:academic/data/api/people/people_api.dart';
import 'package:get_it/get_it.dart';

part 'publishers_state.dart';
part 'publishers_cubit.freezed.dart';

class PublishersCubit extends Cubit<PublishersState> {
  final PeopleApi _api = GetIt.I<PeopleApi>();
  PublishersCubit() : super(const PublishersState.initial());

  Future<void> fetchPublishers({String? query}) async {
    emit(const PublishersState.loading());
    try {
      final response = await _api.getPublishers();
      final publishers = response.data;
      final filtered = query == null || query.isEmpty
          ? publishers
          : publishers.where((a) => a.name.contains(query)).toList();
      emit(PublishersState.success(filtered));
    } catch (e) {
      emit(PublishersState.error(e.toString()));
    }
  }
} 