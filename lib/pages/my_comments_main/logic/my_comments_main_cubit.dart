import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/product/model/product_model.dart'; // Import CommentModel
import 'package:academic/data/repo/user_reviews_repository.dart'; // Import IUserReviewsRepository
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/user_reviews/model/user_review_model.dart';

part 'my_comments_main_state.dart';
part 'my_comments_main_event.dart'; // Add event part
part 'my_comments_main_cubit.freezed.dart'; // Add freezed part

@injectable
class MycommentsmainCubit extends Cubit<MycommentsmainState> {
  final IUserReviewsRepository _userReviewsRepository;

  MycommentsmainCubit(this._userReviewsRepository) : super(const MycommentsmainState()) {
    fetchUserReviews(); // Call fetchUserReviews on initialization
  }

  void onTabTap(String tabName) {
    emit(state.copyWith(currentTab: tabName));
    if (tabName == 'submitted') {
      fetchUserReviews();
    }
  }

  Future<void> fetchUserReviews() async {
    if (state.reviews.isNotEmpty || state.isLoading) return;
    try {
      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));
      final response = await _userReviewsRepository.getUserReviews();
      emit(state.copyWith(isLoading: false, reviews: response.data));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, errorMessage: e.toString()));
    }
  }
}
