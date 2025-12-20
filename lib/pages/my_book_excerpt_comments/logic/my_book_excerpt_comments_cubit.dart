import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/model/my_book_excerpt_comment.dart';
import 'package:academic/data/repo/my_book_excerpts_repository.dart';
import 'package:injectable/injectable.dart';

part 'my_book_excerpt_comments_state.dart';
part 'my_book_excerpt_comments_cubit.freezed.dart';

@injectable
class MyBookExcerptCommentsCubit extends Cubit<MyBookExcerptCommentsState> {
  final MyBookExcerptsRepository _repository;
  final int excerptId;

  MyBookExcerptCommentsCubit(this._repository, this.excerptId) : super(const MyBookExcerptCommentsState()) {
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final comments = await _repository.getMyBookExcerptComments(excerptId);
      emit(state.copyWith(
        isLoading: false,
        comments: comments,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}

