// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return _Chapter.fromJson(json);
}

/// @nodoc
mixin _$Chapter {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  ChapterUser? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes_count')
  int? get notesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeFromJson: false)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', includeFromJson: false)
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'date', includeFromJson: false)
  String? get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterCopyWith<Chapter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) then) =
      _$ChapterCopyWithImpl<$Res, Chapter>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
      int userId,
      @JsonKey(name: 'user') ChapterUser? user,
      @JsonKey(name: 'notes_count') int? notesCount,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'created_at', includeFromJson: false) String? createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: false) String? updatedAt,
      @JsonKey(name: 'date', includeFromJson: false) String? date});

  $ChapterUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res, $Val extends Chapter>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? userId = null,
    Object? user = freezed,
    Object? notesCount = freezed,
    Object? categoryId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ChapterUser?,
      notesCount: freezed == notesCount
          ? _value.notesCount
          : notesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChapterUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $ChapterUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChapterImplCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
          _$ChapterImpl value, $Res Function(_$ChapterImpl) then) =
      __$$ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
      int userId,
      @JsonKey(name: 'user') ChapterUser? user,
      @JsonKey(name: 'notes_count') int? notesCount,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'created_at', includeFromJson: false) String? createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: false) String? updatedAt,
      @JsonKey(name: 'date', includeFromJson: false) String? date});

  @override
  $ChapterUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
      _$ChapterImpl _value, $Res Function(_$ChapterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? userId = null,
    Object? user = freezed,
    Object? notesCount = freezed,
    Object? categoryId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? date = freezed,
  }) {
    return _then(_$ChapterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ChapterUser?,
      notesCount: freezed == notesCount
          ? _value.notesCount
          : notesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterImpl implements _Chapter {
  const _$ChapterImpl(
      {required this.id,
      required this.title,
      this.description,
      @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
      this.userId = 0,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: 'notes_count') this.notesCount,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'created_at', includeFromJson: false) this.createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: false) this.updatedAt,
      @JsonKey(name: 'date', includeFromJson: false) this.date});

  factory _$ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
  final int userId;
  @override
  @JsonKey(name: 'user')
  final ChapterUser? user;
  @override
  @JsonKey(name: 'notes_count')
  final int? notesCount;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'created_at', includeFromJson: false)
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at', includeFromJson: false)
  final String? updatedAt;
  @override
  @JsonKey(name: 'date', includeFromJson: false)
  final String? date;

  @override
  String toString() {
    return 'Chapter(id: $id, title: $title, description: $description, userId: $userId, user: $user, notesCount: $notesCount, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.notesCount, notesCount) ||
                other.notesCount == notesCount) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, userId,
      user, notesCount, categoryId, createdAt, updatedAt, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(
      this,
    );
  }
}

abstract class _Chapter implements Chapter {
  const factory _Chapter(
      {required final int id,
      required final String title,
      final String? description,
      @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
      final int userId,
      @JsonKey(name: 'user') final ChapterUser? user,
      @JsonKey(name: 'notes_count') final int? notesCount,
      @JsonKey(name: 'category_id') final int? categoryId,
      @JsonKey(name: 'created_at', includeFromJson: false)
      final String? createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: false)
      final String? updatedAt,
      @JsonKey(name: 'date', includeFromJson: false)
      final String? date}) = _$ChapterImpl;

  factory _Chapter.fromJson(Map<String, dynamic> json) = _$ChapterImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
  int get userId;
  @override
  @JsonKey(name: 'user')
  ChapterUser? get user;
  @override
  @JsonKey(name: 'notes_count')
  int? get notesCount;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'created_at', includeFromJson: false)
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at', includeFromJson: false)
  String? get updatedAt;
  @override
  @JsonKey(name: 'date', includeFromJson: false)
  String? get date;
  @override
  @JsonKey(ignore: true)
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterUser _$ChapterUserFromJson(Map<String, dynamic> json) {
  return _ChapterUser.fromJson(json);
}

/// @nodoc
mixin _$ChapterUser {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterUserCopyWith<ChapterUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterUserCopyWith<$Res> {
  factory $ChapterUserCopyWith(
          ChapterUser value, $Res Function(ChapterUser) then) =
      _$ChapterUserCopyWithImpl<$Res, ChapterUser>;
  @useResult
  $Res call({int id, String name, String? avatar});
}

/// @nodoc
class _$ChapterUserCopyWithImpl<$Res, $Val extends ChapterUser>
    implements $ChapterUserCopyWith<$Res> {
  _$ChapterUserCopyWithImpl(this._value, this._then);

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
abstract class _$$ChapterUserImplCopyWith<$Res>
    implements $ChapterUserCopyWith<$Res> {
  factory _$$ChapterUserImplCopyWith(
          _$ChapterUserImpl value, $Res Function(_$ChapterUserImpl) then) =
      __$$ChapterUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? avatar});
}

/// @nodoc
class __$$ChapterUserImplCopyWithImpl<$Res>
    extends _$ChapterUserCopyWithImpl<$Res, _$ChapterUserImpl>
    implements _$$ChapterUserImplCopyWith<$Res> {
  __$$ChapterUserImplCopyWithImpl(
      _$ChapterUserImpl _value, $Res Function(_$ChapterUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_$ChapterUserImpl(
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
class _$ChapterUserImpl implements _ChapterUser {
  const _$ChapterUserImpl({required this.id, required this.name, this.avatar});

  factory _$ChapterUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterUserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'ChapterUser(id: $id, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterUserImpl &&
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
  _$$ChapterUserImplCopyWith<_$ChapterUserImpl> get copyWith =>
      __$$ChapterUserImplCopyWithImpl<_$ChapterUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterUserImplToJson(
      this,
    );
  }
}

abstract class _ChapterUser implements ChapterUser {
  const factory _ChapterUser(
      {required final int id,
      required final String name,
      final String? avatar}) = _$ChapterUserImpl;

  factory _ChapterUser.fromJson(Map<String, dynamic> json) =
      _$ChapterUserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$ChapterUserImplCopyWith<_$ChapterUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
