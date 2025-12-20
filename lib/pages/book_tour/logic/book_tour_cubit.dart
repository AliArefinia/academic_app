import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/model/book_excerpt.dart';
import 'package:academic/data/repo/book_excerpts_repository.dart';
import 'package:academic/data/repository/likes_repository.dart';
import 'package:injectable/injectable.dart';

part 'book_tour_state.dart';

part 'book_tour_event.dart'; // Add event part
part 'book_tour_cubit.freezed.dart'; // Add freezed part

@injectable
class BooktourCubit extends Cubit<BooktourState> {
  final BookExcerptsRepository _bookExcerptsRepository;
  final ILikesRepository _likesRepository;
  String currentChip = 'همه';

  BooktourCubit(this._bookExcerptsRepository, this._likesRepository)
      : super(const BooktourState()) {
    fetchBookExcerpts();
  }

  void onChipTap(String chip) {
    currentChip = chip;
    emit(state.copyWith(currentChip: chip));
  }

  Future<void> fetchBookExcerpts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final excerpts = await _bookExcerptsRepository.getBookExcerpts();
      emit(state.copyWith(
        isLoading: false,
        bookExcerpts: excerpts,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> toggleLike(int bookExcerptId) async {
    try {
      final response = await _likesRepository.toggleLike(
        likeableType: 'book_excerpts',
        likeableId: bookExcerptId,
      );

      // Update the like count and isLiked status in the state
      final updatedExcerpts = state.bookExcerpts.map((excerpt) {
        if (excerpt.id == bookExcerptId) {
          final currentLikesCount = excerpt.likesCount ?? 0;
          final newLikesCount =
              response.liked ? currentLikesCount + 1 : currentLikesCount - 1;

          return excerpt.copyWith(
            likesCount: newLikesCount,
            isLiked: response.liked,
          );
        }
        return excerpt;
      }).toList();

      emit(state.copyWith(bookExcerpts: updatedExcerpts));
    } catch (e) {
      // Handle error if needed
      print('Error toggling like: $e');
    }
  }
}
