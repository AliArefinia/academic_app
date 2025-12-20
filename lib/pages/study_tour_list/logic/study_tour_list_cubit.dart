import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/repository/study_tour_request_repository.dart';
import '../models/study_tour_model.dart';

part 'study_tour_list_state.dart';
part 'study_tour_list_cubit.freezed.dart';

@injectable
class StudyTourListCubit extends Cubit<StudyTourListState> {
  final IStudyTourRequestRepository _studyTourRequestRepository;

  StudyTourListCubit(this._studyTourRequestRepository) 
      : super(const StudyTourListState.initial());

  Future<void> loadStudyTours() async {
    try {
      emit(const StudyTourListState.loading());
      
      final response = await _studyTourRequestRepository.getMyStudyTourRequests();
      
      if (response.data.list.isEmpty) {
        emit(const StudyTourListState.empty());
      } else {
        // Convert API response to StudyTourModel list
        final studyTours = response.data.list.map((item) => StudyTourModel(
          title: item.title,
          category: item.category,
          description: item.description,
          answer: item.answer,
          books: item.books.map((book) => StudyTourBook(
            id: book['id'] as int,
            type: book['type'] as String,
            name: book['name'] as String,
            image: book['image'] as String,
            price: book['price'] as int,
            discountPrice: book['discount_price'] as int,
          )).toList(),
          status: item.status,
          createdAt: item.createdAt,
          updatedAt: item.updatedAt,
        )).toList();
        
        emit(StudyTourListState.loaded(studyTours));
      }
    } catch (e) {
      emit(StudyTourListState.error('خطا در بارگذاری سیر مطالعاتی‌ها: ${e.toString()}'));
    }
  }
}
