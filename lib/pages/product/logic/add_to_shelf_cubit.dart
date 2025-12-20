import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/my_book_cases/model/my_book_case_model.dart';
import 'package:academic/data/repo/book_case_repository.dart';

part 'add_to_shelf_state.dart';
part 'add_to_shelf_cubit.freezed.dart';

class AddToShelfCubit extends Cubit<AddToShelfState> {
  final BookCaseRepository repository;

  AddToShelfCubit(this.repository) : super(const AddToShelfState.initial()) {
    fetchShelves();
  }

  Future<void> fetchShelves() async {
    emit(const AddToShelfState.loading());
    try {
      final shelves = await repository.getBookCases();
      emit(AddToShelfState.success(shelves));
    } catch (e) {
      emit(AddToShelfState.error(e.toString()));
    }
  }

  Future<void> addBookToShelf(int bookId, int shelfId) async {
    try {
      await repository.addBookToCase(shelfId, bookId);
      emit(const AddToShelfState.bookAdded());
    } catch (e) {
      emit(AddToShelfState.error(e.toString()));
    }
  }

  Future<void> createNewShelf(String name) async {
    try {
      await repository.createBookCase(name);
      await fetchShelves();
    } catch (e) {
      emit(AddToShelfState.error(e.toString()));
    }
  }
} 