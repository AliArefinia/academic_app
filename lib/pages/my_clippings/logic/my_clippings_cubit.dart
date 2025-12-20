import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/model/my_book_excerpt.dart';
import 'package:academic/data/repo/my_book_excerpts_repository.dart';
import 'package:injectable/injectable.dart';

part 'my_clippings_state.dart';

part 'my_clippings_event.dart'; // Add event part
part 'my_clippings_cubit.freezed.dart'; // Add freezed part

@injectable
class MyClippingsCubit extends Cubit<MyClippingsState> {
  final MyBookExcerptsRepository _repository;

  MyClippingsCubit(this._repository) : super(const MyClippingsState()) {
    fetchMyBookExcerpts();
  }

  Future<void> fetchMyBookExcerpts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final excerpts = await _repository.getMyBookExcerpts();
      emit(state.copyWith(
        isLoading: false,
        myBookExcerpts: excerpts,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void bottomNavigationBarAction(int value) {
    emit(state.copyWith(index: value));
  }

  void checkWhoLikeShow() {
    if(state.isWhoLikeShow) {
      emit(state.copyWith(isWhoLikeShow: false));
    } else {
      emit(state.copyWith(isWhoLikeShow: true, isPeopleCommentsShow: false));
    }
  }

  void checkPeopleCommentsShow() {
    if(state.isPeopleCommentsShow) {
      emit(state.copyWith(isPeopleCommentsShow: false));
    } else {
      emit(state.copyWith(isPeopleCommentsShow: true, isWhoLikeShow: false));
    }
  }
}
