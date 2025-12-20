import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reviews_and_rating_state.dart';
part 'reviews_and_rating_event.dart'; // Add event part
part 'reviews_and_rating_cubit.freezed.dart'; // Add freezed part

class ReviewsandratingCubit extends Cubit<ReviewsandratingState> {
  ReviewsandratingCubit() : super(const ReviewsandratingState());


  bottomNavigationBarAction(int value) {
    emit(state.copyWith(index: value));
  }



}
