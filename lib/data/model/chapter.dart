import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

@freezed
class Chapter with _$Chapter {
  const factory Chapter({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false) @Default(0) int userId,
    @JsonKey(name: 'user') ChapterUser? user,
    @JsonKey(name: 'notes_count') int? notesCount,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'created_at', includeFromJson: false) String? createdAt,
    @JsonKey(name: 'updated_at', includeFromJson: false) String? updatedAt,
    @JsonKey(name: 'date', includeFromJson: false) String? date,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}

// Extension for backward compatibility
extension ChapterExtension on Chapter {
  String get userName => user?.name ?? '';
  String? get userAvatar => user?.avatar;
  int get userIdValue => userId != 0 ? userId : (user?.id ?? 0);
}

@freezed
class ChapterUser with _$ChapterUser {
  const factory ChapterUser({
    required int id,
    required String name,
    String? avatar,
  }) = _ChapterUser;

  factory ChapterUser.fromJson(Map<String, dynamic> json) =>
      _$ChapterUserFromJson(json);
}
