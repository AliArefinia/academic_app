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
      emit(MyChaptersState.error('خطا در بارگذاری سرفصل‌ها: ${e.toString()}'));
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
        emit(const MyChaptersState.error('عنوان باید حداقل ۳ کاراکتر باشد'));
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
      emit(MyChaptersState.error('خطا در ایجاد سرفصل: ${e.toString()}'));
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
      emit(MyChaptersState.error('خطا در به‌روزرسانی سرفصل: ${e.toString()}'));
    }
  }

  Future<void> deleteChapter(int chapterId) async {
    try {
      emit(const MyChaptersState.loading());
      await _chaptersRepository.deleteChapter(chapterId);
      await loadChapters();
    } catch (e) {
      emit(MyChaptersState.error('خطا در حذف سرفصل: ${e.toString()}'));
    }
  }
}
