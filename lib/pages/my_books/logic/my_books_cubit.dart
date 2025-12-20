import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/repo/my_books_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/api/my_books/model/my_books_response.dart';

part 'my_books_state.dart';
part 'my_books_cubit.freezed.dart';



@injectable
class MyBooksCubit extends Cubit<MyBooksState> {
  final MyBooksRepository _repository;

  MyBooksCubit(this._repository) : super(const MyBooksState.loading()) {
    loadMyBooks();
  }

  Future<void> loadMyBooks() async {
    emit(const MyBooksState.loading());

    try {
      final result = await _repository.fetchMyBooks(limit: 50);
      if(result.data != null){
        final booksList = result.data!.list ?? [];
        if(booksList.isEmpty){
          emit(const MyBooksState.empty());
        } else {
          emit(MyBooksState.success(result.data!));
        }
      } else {
        emit(const MyBooksState.empty());
      }
    } catch (e) {
      emit(MyBooksState.error(e.toString()));
    }
  }

  void selectCategory(int index) {
    state.maybeWhen(
      success: (data, selectedCategory) {
        emit(MyBooksState.success(data, selectedCategory: index));
      },
      orElse: () {},
    );
  }
}