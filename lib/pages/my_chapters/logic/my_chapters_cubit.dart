import 'package:academic/l10n/l10n.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/data/repo/chapters_repository.dart';

part 'my_chapters_state.dart';
part 'my_chapters_cubit.freezed.dart';

@injectable
class MyChaptersCubit extends Cubit<MyChaptersState> {
  final ChaptersRepository _chaptersRepository;

  MyChaptersCubit(this._chaptersRepository) : super(const MyChaptersState.initial()) {
    loadChapters();
  }

  Future<void> loadChapters() async {
    try {
      emit(const MyChaptersState.loading());
      final chapters = await _chaptersRepository.getMyChapters();
      emit(MyChaptersState.loaded(chapters));
    } catch (e) {
      emit(MyChaptersState.error(l10n.errorLoadingChaptersWithMessage(e.toString())));
    }
  }

  Future<void> createChapter({
    required String title,
    String? description,
    File? image,
    int? categoryId,
  }) async {
    try {
      if (title.trim().length < 3) {
        emit(MyChaptersState.error(l10n.titleMinLength));
        return;
      }

      emit(const MyChaptersState.loading());
      await _chaptersRepository.createChapter(
        title: title.trim(),
        description: description?.trim(),
        image: image,
        categoryId: categoryId,
      );
      await loadChapters();
    } catch (e) {
      emit(MyChaptersState.error(l10n.errorCreatingChapterWithMessage(e.toString())));
    }
  }

  Future<void> updateChapter({
    required int chapterId,
    String? description,
  }) async {
    try {
      emit(const MyChaptersState.loading());
      await _chaptersRepository.updateChapter(
        chapterId: chapterId,
        description: description?.trim(),
      );
      await loadChapters();
    } catch (e) {
      emit(MyChaptersState.error(l10n.errorUpdatingChapterWithMessage(e.toString())));
    }
  }

  Future<void> deleteChapter(int chapterId) async {
    try {
      emit(const MyChaptersState.loading());
      await _chaptersRepository.deleteChapter(chapterId);
      await loadChapters();
    } catch (e) {
      emit(MyChaptersState.error(l10n.errorDeletingChapterWithMessage(e.toString())));
    }
  }
}
