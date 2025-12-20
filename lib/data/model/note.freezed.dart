// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Note _$NoteFromJson(Map<String, dynamic> json) {
  return _Note.fromJson(json);
}

/// @nodoc
mixin _$Note {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String? get excerpt =>
      throw _privateConstructorUsedError; // متن بریده شده - از API به عنوان text می‌آید
  @JsonKey(name: 'description')
  String? get userNote =>
      throw _privateConstructorUsedError; // یادداشت کاربر - از API به عنوان description می‌آید
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError; // نام یادداشت از API
  @JsonKey(name: 'user_headline_id', includeFromJson: false)
  int get chapterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id', includeFromJson: false)
  int get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book')
  NoteBook? get book =>
      throw _privateConstructorUsedError; // اطلاعات کتاب از API
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'text') String? excerpt,
      @JsonKey(name: 'description') String? userNote,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'user_headline_id', includeFromJson: false) int chapterId,
      @JsonKey(name: 'book_id', includeFromJson: false) int bookId,
      @JsonKey(name: 'book') NoteBook? book,
      @JsonKey(name: 'created_at') String? createdAt});

  $NoteBookCopyWith<$Res>? get book;
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? excerpt = freezed,
    Object? userNote = freezed,
    Object? name = freezed,
    Object? chapterId = null,
    Object? bookId = null,
    Object? book = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      excerpt: freezed == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterId: null == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as int,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as NoteBook?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NoteBookCopyWith<$Res>? get book {
    if (_value.book == null) {
      return null;
    }

    return $NoteBookCopyWith<$Res>(_value.book!, (value) {
      return _then(_value.copyWith(book: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoteImplCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$NoteImplCopyWith(
          _$NoteImpl value, $Res Function(_$NoteImpl) then) =
      __$$NoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'text') String? excerpt,
      @JsonKey(name: 'description') String? userNote,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'user_headline_id', includeFromJson: false) int chapterId,
      @JsonKey(name: 'book_id', includeFromJson: false) int bookId,
      @JsonKey(name: 'book') NoteBook? book,
      @JsonKey(name: 'created_at') String? createdAt});

  @override
  $NoteBookCopyWith<$Res>? get book;
}

/// @nodoc
class __$$NoteImplCopyWithImpl<$Res>
    extends _$NoteCopyWithImpl<$Res, _$NoteImpl>
    implements _$$NoteImplCopyWith<$Res> {
  __$$NoteImplCopyWithImpl(_$NoteImpl _value, $Res Function(_$NoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? excerpt = freezed,
    Object? userNote = freezed,
    Object? name = freezed,
    Object? chapterId = null,
    Object? bookId = null,
    Object? book = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$NoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      excerpt: freezed == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterId: null == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as int,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as NoteBook?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteImpl implements _Note {
  const _$NoteImpl(
      {required this.id,
      @JsonKey(name: 'text') this.excerpt,
      @JsonKey(name: 'description') this.userNote,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'user_headline_id', includeFromJson: false)
      this.chapterId = 0,
      @JsonKey(name: 'book_id', includeFromJson: false) this.bookId = 0,
      @JsonKey(name: 'book') this.book,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$NoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'text')
  final String? excerpt;
// متن بریده شده - از API به عنوان text می‌آید
  @override
  @JsonKey(name: 'description')
  final String? userNote;
// یادداشت کاربر - از API به عنوان description می‌آید
  @override
  @JsonKey(name: 'name')
  final String? name;
// نام یادداشت از API
  @override
  @JsonKey(name: 'user_headline_id', includeFromJson: false)
  final int chapterId;
  @override
  @JsonKey(name: 'book_id', includeFromJson: false)
  final int bookId;
  @override
  @JsonKey(name: 'book')
  final NoteBook? book;
// اطلاعات کتاب از API
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'Note(id: $id, excerpt: $excerpt, userNote: $userNote, name: $name, chapterId: $chapterId, bookId: $bookId, book: $book, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.userNote, userNote) ||
                other.userNote == userNote) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, excerpt, userNote, name,
      chapterId, bookId, book, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteImplCopyWith<_$NoteImpl> get copyWith =>
      __$$NoteImplCopyWithImpl<_$NoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteImplToJson(
      this,
    );
  }
}

abstract class _Note implements Note {
  const factory _Note(
      {required final int id,
      @JsonKey(name: 'text') final String? excerpt,
      @JsonKey(name: 'description') final String? userNote,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'user_headline_id', includeFromJson: false)
      final int chapterId,
      @JsonKey(name: 'book_id', includeFromJson: false) final int bookId,
      @JsonKey(name: 'book') final NoteBook? book,
      @JsonKey(name: 'created_at') final String? createdAt}) = _$NoteImpl;

  factory _Note.fromJson(Map<String, dynamic> json) = _$NoteImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'text')
  String? get excerpt;
  @override // متن بریده شده - از API به عنوان text می‌آید
  @JsonKey(name: 'description')
  String? get userNote;
  @override // یادداشت کاربر - از API به عنوان description می‌آید
  @JsonKey(name: 'name')
  String? get name;
  @override // نام یادداشت از API
  @JsonKey(name: 'user_headline_id', includeFromJson: false)
  int get chapterId;
  @override
  @JsonKey(name: 'book_id', includeFromJson: false)
  int get bookId;
  @override
  @JsonKey(name: 'book')
  NoteBook? get book;
  @override // اطلاعات کتاب از API
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$NoteImplCopyWith<_$NoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteBook _$NoteBookFromJson(Map<String, dynamic> json) {
  return _NoteBook.fromJson(json);
}

/// @nodoc
mixin _$NoteBook {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  NoteAuthor? get author => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteBookCopyWith<NoteBook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteBookCopyWith<$Res> {
  factory $NoteBookCopyWith(NoteBook value, $Res Function(NoteBook) then) =
      _$NoteBookCopyWithImpl<$Res, NoteBook>;
  @useResult
  $Res call({int id, String name, String? image, NoteAuthor? author});

  $NoteAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class _$NoteBookCopyWithImpl<$Res, $Val extends NoteBook>
    implements $NoteBookCopyWith<$Res> {
  _$NoteBookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as NoteAuthor?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NoteAuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $NoteAuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoteBookImplCopyWith<$Res>
    implements $NoteBookCopyWith<$Res> {
  factory _$$NoteBookImplCopyWith(
          _$NoteBookImpl value, $Res Function(_$NoteBookImpl) then) =
      __$$NoteBookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? image, NoteAuthor? author});

  @override
  $NoteAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class __$$NoteBookImplCopyWithImpl<$Res>
    extends _$NoteBookCopyWithImpl<$Res, _$NoteBookImpl>
    implements _$$NoteBookImplCopyWith<$Res> {
  __$$NoteBookImplCopyWithImpl(
      _$NoteBookImpl _value, $Res Function(_$NoteBookImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = freezed,
    Object? author = freezed,
  }) {
    return _then(_$NoteBookImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as NoteAuthor?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteBookImpl implements _NoteBook {
  const _$NoteBookImpl(
      {required this.id, required this.name, this.image, this.author});

  factory _$NoteBookImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteBookImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? image;
  @override
  final NoteAuthor? author;

  @override
  String toString() {
    return 'NoteBook(id: $id, name: $name, image: $image, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteBookImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, image, author);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteBookImplCopyWith<_$NoteBookImpl> get copyWith =>
      __$$NoteBookImplCopyWithImpl<_$NoteBookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteBookImplToJson(
      this,
    );
  }
}

abstract class _NoteBook implements NoteBook {
  const factory _NoteBook(
      {required final int id,
      required final String name,
      final String? image,
      final NoteAuthor? author}) = _$NoteBookImpl;

  factory _NoteBook.fromJson(Map<String, dynamic> json) =
      _$NoteBookImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get image;
  @override
  NoteAuthor? get author;
  @override
  @JsonKey(ignore: true)
  _$$NoteBookImplCopyWith<_$NoteBookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteAuthor _$NoteAuthorFromJson(Map<String, dynamic> json) {
  return _NoteAuthor.fromJson(json);
}

/// @nodoc
mixin _$NoteAuthor {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteAuthorCopyWith<NoteAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteAuthorCopyWith<$Res> {
  factory $NoteAuthorCopyWith(
          NoteAuthor value, $Res Function(NoteAuthor) then) =
      _$NoteAuthorCopyWithImpl<$Res, NoteAuthor>;
  @useResult
  $Res call({int id, String name, String? avatar});
}

/// @nodoc
class _$NoteAuthorCopyWithImpl<$Res, $Val extends NoteAuthor>
    implements $NoteAuthorCopyWith<$Res> {
  _$NoteAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteAuthorImplCopyWith<$Res>
    implements $NoteAuthorCopyWith<$Res> {
  factory _$$NoteAuthorImplCopyWith(
          _$NoteAuthorImpl value, $Res Function(_$NoteAuthorImpl) then) =
      __$$NoteAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? avatar});
}

/// @nodoc
class __$$NoteAuthorImplCopyWithImpl<$Res>
    extends _$NoteAuthorCopyWithImpl<$Res, _$NoteAuthorImpl>
    implements _$$NoteAuthorImplCopyWith<$Res> {
  __$$NoteAuthorImplCopyWithImpl(
      _$NoteAuthorImpl _value, $Res Function(_$NoteAuthorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_$NoteAuthorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteAuthorImpl implements _NoteAuthor {
  const _$NoteAuthorImpl({required this.id, required this.name, this.avatar});

  factory _$NoteAuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteAuthorImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'NoteAuthor(id: $id, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteAuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteAuthorImplCopyWith<_$NoteAuthorImpl> get copyWith =>
      __$$NoteAuthorImplCopyWithImpl<_$NoteAuthorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteAuthorImplToJson(
      this,
    );
  }
}

abstract class _NoteAuthor implements NoteAuthor {
  const factory _NoteAuthor(
      {required final int id,
      required final String name,
      final String? avatar}) = _$NoteAuthorImpl;

  factory _NoteAuthor.fromJson(Map<String, dynamic> json) =
      _$NoteAuthorImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$NoteAuthorImplCopyWith<_$NoteAuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
