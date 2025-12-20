import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/repository/product_repository.dart';
import 'package:get_it/get_it.dart';

part 'my_comments_state.dart';
part 'my_comments_event.dart'; // Add event part
part 'my_comments_cubit.freezed.dart'; // Add freezed part

class MycommentsCubit extends Cubit<MycommentsState> {
  final IProductRepository _productRepository = GetIt.I<IProductRepository>();

  MycommentsCubit() : super(const MycommentsState());

  void changePageStatus() {
    emit(state.copyWith(isContinued: true));
  }

  void selectOpinion(String opinion) {
    emit(state.copyWith(opinion: opinion));
  }

  rateAction(int index) {
    emit(state.copyWith(rate: index));
  }

  Future<void> submitReview({
    required int productId,
    required String comment,
    int? rate,
    int? recommendation,
  }) async {
    print('submitReview called! productId=$productId, comment="$comment", rate=$rate, recommendation=$recommendation');
    
    if (comment.trim().isEmpty) {
      emit(state.copyWith(showCommentError: true));
      return;
    }
    
    emit(state.copyWith(isLoading: true, error: null, success: false, showCommentError: false));
    try {
      await _productRepository.submitReview(
        productId: productId,
        comment: comment,
        rate: rate,
        recommendation: recommendation,
      );
      print('submitReview success!');
      emit(state.copyWith(isLoading: false, success: true));
    } catch (e) {
      print('submitReview error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
