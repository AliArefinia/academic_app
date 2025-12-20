import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/data/repo/chapters_repository.dart';

part 'public_chapters_state.dart';
part 'public_chapters_cubit.freezed.dart';

@injectable
class PublicChaptersCubit extends Cubit<PublicChaptersState> {
  final ChaptersRepository _chaptersRepository;

  PublicChaptersCubit(this._chaptersRepository) : super(const PublicChaptersState.initial()) {
    loadPublicChapters();
  }

  Future<void> loadPublicChapters() async {
    try {
      emit(const PublicChaptersState.loading());
      final chapters = await _chaptersRepository.getAllChapters();
      emit(PublicChaptersState.loaded(chapters));
    } catch (e) {
      emit(PublicChaptersState.error('خطا در بارگذاری سرفصل‌ها: ${e.toString()}'));
    }
  }
}
