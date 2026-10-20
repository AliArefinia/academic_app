import 'package:academic/l10n/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/data/model/note.dart';
import 'package:academic/data/repo/chapters_repository.dart';
import 'package:academic/data/repo/notes_repository.dart';

part 'chapter_detail_state.dart';
part 'chapter_detail_cubit.freezed.dart';

@injectable
class ChapterDetailCubit extends Cubit<ChapterDetailState> {
  final ChaptersRepository _chaptersRepository;
  final NotesRepository _notesRepository;

  ChapterDetailCubit(this._chaptersRepository, this._notesRepository)
      : super(const ChapterDetailState.initial());

  Future<void> loadChapterDetail(int chapterId) async {
    try {
      emit(const ChapterDetailState.loading());
      final chapter = await _chaptersRepository.getChapterById(chapterId);
      final notes = await _chaptersRepository.getChapterNotes(chapterId);
      emit(ChapterDetailState.loaded(chapter, notes));
    } on DioException catch (e) {
      // Handle 404 errors specifically
      if (e.response?.statusCode == 404) {
        emit(ChapterDetailState.error(
          l10n.chapterNotFound,
        ));
      } else {
        emit(ChapterDetailState.error(
          l10n.errorLoadingDetailsWithMessage(e.message ?? l10n.unknownError),
        ));
      }
    } catch (e) {
      emit(ChapterDetailState.error(l10n.errorLoadingDetailsWithMessage(e.toString())));
    }
  }

  Future<void> updateNote({
    required int noteId,
    required String userNote,
    required int chapterId,
  }) async {
    try {
      final state = this.state;
      if (state is _Loaded) {
        await _notesRepository.updateNote(noteId: noteId, userNote: userNote);
        // Reload chapter detail to get updated notes
        await loadChapterDetail(chapterId);
      }
    } catch (e) {
      final state = this.state;
      if (state is _Loaded) {
        emit(ChapterDetailState.error(l10n.errorUpdatingNoteWithMessage(e.toString())));
        // Restore previous state after showing error
        await Future.delayed(const Duration(seconds: 2));
        await loadChapterDetail(chapterId);
      }
    }
  }

  Future<void> deleteNote({
    required int noteId,
    required int chapterId,
  }) async {
    try {
      final state = this.state;
      if (state is _Loaded) {
        await _notesRepository.deleteNote(noteId);
        // Reload chapter detail to get updated notes
        await loadChapterDetail(chapterId);
      }
    } catch (e) {
      final state = this.state;
      if (state is _Loaded) {
        emit(ChapterDetailState.error(l10n.errorDeletingNoteWithMessage(e.toString())));
        // Restore previous state after showing error
        await Future.delayed(const Duration(seconds: 2));
        await loadChapterDetail(chapterId);
      }
    }
  }
}
