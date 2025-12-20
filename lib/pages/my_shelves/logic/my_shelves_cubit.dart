import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/my_book_cases/model/my_book_case_model.dart';

import '../../../data/repo/book_case_repository.dart';

part 'my_shelves_state.dart';
part 'my_shelves_event.dart';
part 'my_shelves_cubit.freezed.dart';

class MyshelvesCubit extends Cubit<MyshelvesState> {
  final BookCaseRepository repository;

  MyshelvesCubit(this.repository) : super(const MyshelvesState.initial()){
    fetchShelves();
  }

  Future<void> fetchShelves() async {
    emit(const MyshelvesState.loading());
    try {
      final shelves = await repository.getBookCases();
      emit(MyshelvesState.success(shelves));
    } catch (e) {
      emit(MyshelvesState.error(e.toString()));
    }
  }

  void addShelf(BookCase newShelf) {
    state.maybeWhen(
      success: (currentShelves) {
        final updated = List<BookCase>.from(currentShelves)..insert(0, newShelf);
        emit(MyshelvesState.success(updated));
      },
      orElse: () {},
    );
  }

  Future<void> createBookCase(String name) async {
    try {
      await repository.createBookCase(name);
      // After successful creation, fetch all shelves
      await fetchShelves();
    } catch (e) {
      emit(MyshelvesState.error(e.toString()));
    }
  }

  Future<void> deleteBookCase(int id) async {
    try {
      await repository.deleteBookCase(id);
      // After successful deletion, fetch all shelves
      await fetchShelves();
    } catch (e) {
      emit(MyshelvesState.error(e.toString()));
    }
  }
}