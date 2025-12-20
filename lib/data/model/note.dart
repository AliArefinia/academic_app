import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required int id,
    @JsonKey(name: 'text') String? excerpt, // متن بریده شده - از API به عنوان text می‌آید
    @JsonKey(name: 'description') String? userNote, // یادداشت کاربر - از API به عنوان description می‌آید
    @JsonKey(name: 'name') String? name, // نام یادداشت از API
    @JsonKey(name: 'user_headline_id', includeFromJson: false) @Default(0) int chapterId,
    @JsonKey(name: 'book_id', includeFromJson: false) @Default(0) int bookId,
    @JsonKey(name: 'book') NoteBook? book, // اطلاعات کتاب از API
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}

// Extension for backward compatibility
extension NoteExtension on Note {
  String get bookName => book?.name ?? '';
  String get bookImage => book?.image ?? '';
  String? get authorName => book?.author?.name;
  String? get authorAvatar => book?.author?.avatar;
  // Use name as excerpt if excerpt is null
  String get excerptText => excerpt ?? name ?? '';
}

@freezed
class NoteBook with _$NoteBook {
  const factory NoteBook({
    required int id,
    required String name,
    String? image,
    NoteAuthor? author,
  }) = _NoteBook;

  factory NoteBook.fromJson(Map<String, dynamic> json) =>
      _$NoteBookFromJson(json);
}

@freezed
class NoteAuthor with _$NoteAuthor {
  const factory NoteAuthor({
    required int id,
    required String name,
    String? avatar,
  }) = _NoteAuthor;

  factory NoteAuthor.fromJson(Map<String, dynamic> json) =>
      _$NoteAuthorFromJson(json);
}
