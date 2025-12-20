import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_development_books_state.dart';
part 'personal_development_books_event.dart'; // Add event part
part 'personal_development_books_cubit.freezed.dart'; // Add freezed part

class PersonaldevelopmentbooksCubit extends Cubit<PersonaldevelopmentbooksState> {
  PersonaldevelopmentbooksCubit() : super(PersonaldevelopmentbooksState.initial());

  void toggleTextBooks() {
    emit(state.copyWith(isTextBooksActive: !state.isTextBooksActive));
  }

  void toggleAudioBooks() {
    emit(state.copyWith(isAudioBooksActive: !state.isAudioBooksActive));
  }

  void toggleViewMode(bool bool) {
    emit(state.copyWith(isGridView: !state.isGridView));
  }
}


