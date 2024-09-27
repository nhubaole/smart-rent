// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ward.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ward _$WardFromJson(Map<String, dynamic> json) {
  return _Ward.fromJson(json);
}

/// @nodoc
mixin _$Ward {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get name_with_type => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get path_with_type => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get parent_code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WardCopyWith<Ward> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WardCopyWith<$Res> {
  factory $WardCopyWith(Ward value, $Res Function(Ward) then) =
      _$WardCopyWithImpl<$Res, Ward>;
  @useResult
  $Res call(
      {String name,
      String type,
      String slug,
      String name_with_type,
      String path,
      String path_with_type,
      String code,
      String parent_code});
}

/// @nodoc
class _$WardCopyWithImpl<$Res, $Val extends Ward>
    implements $WardCopyWith<$Res> {
  _$WardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? slug = null,
    Object? name_with_type = null,
    Object? path = null,
    Object? path_with_type = null,
    Object? code = null,
    Object? parent_code = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      name_with_type: null == name_with_type
          ? _value.name_with_type
          : name_with_type // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      path_with_type: null == path_with_type
          ? _value.path_with_type
          : path_with_type // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      parent_code: null == parent_code
          ? _value.parent_code
          : parent_code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WardImplCopyWith<$Res> implements $WardCopyWith<$Res> {
  factory _$$WardImplCopyWith(
          _$WardImpl value, $Res Function(_$WardImpl) then) =
      __$$WardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String type,
      String slug,
      String name_with_type,
      String path,
      String path_with_type,
      String code,
      String parent_code});
}

/// @nodoc
class __$$WardImplCopyWithImpl<$Res>
    extends _$WardCopyWithImpl<$Res, _$WardImpl>
    implements _$$WardImplCopyWith<$Res> {
  __$$WardImplCopyWithImpl(_$WardImpl _value, $Res Function(_$WardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? slug = null,
    Object? name_with_type = null,
    Object? path = null,
    Object? path_with_type = null,
    Object? code = null,
    Object? parent_code = null,
  }) {
    return _then(_$WardImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      name_with_type: null == name_with_type
          ? _value.name_with_type
          : name_with_type // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      path_with_type: null == path_with_type
          ? _value.path_with_type
          : path_with_type // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      parent_code: null == parent_code
          ? _value.parent_code
          : parent_code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WardImpl extends _Ward {
  const _$WardImpl(
      {required this.name,
      required this.type,
      required this.slug,
      required this.name_with_type,
      required this.path,
      required this.path_with_type,
      required this.code,
      required this.parent_code})
      : super._();

  factory _$WardImpl.fromJson(Map<String, dynamic> json) =>
      _$$WardImplFromJson(json);

  @override
  final String name;
  @override
  final String type;
  @override
  final String slug;
  @override
  final String name_with_type;
  @override
  final String path;
  @override
  final String path_with_type;
  @override
  final String code;
  @override
  final String parent_code;

  @override
  String toString() {
    return 'Ward(name: $name, type: $type, slug: $slug, name_with_type: $name_with_type, path: $path, path_with_type: $path_with_type, code: $code, parent_code: $parent_code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WardImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.name_with_type, name_with_type) ||
                other.name_with_type == name_with_type) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.path_with_type, path_with_type) ||
                other.path_with_type == path_with_type) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.parent_code, parent_code) ||
                other.parent_code == parent_code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, slug, name_with_type,
      path, path_with_type, code, parent_code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WardImplCopyWith<_$WardImpl> get copyWith =>
      __$$WardImplCopyWithImpl<_$WardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WardImplToJson(
      this,
    );
  }
}

abstract class _Ward extends Ward {
  const factory _Ward(
      {required final String name,
      required final String type,
      required final String slug,
      required final String name_with_type,
      required final String path,
      required final String path_with_type,
      required final String code,
      required final String parent_code}) = _$WardImpl;
  const _Ward._() : super._();

  factory _Ward.fromJson(Map<String, dynamic> json) = _$WardImpl.fromJson;

  @override
  String get name;
  @override
  String get type;
  @override
  String get slug;
  @override
  String get name_with_type;
  @override
  String get path;
  @override
  String get path_with_type;
  @override
  String get code;
  @override
  String get parent_code;
  @override
  @JsonKey(ignore: true)
  _$$WardImplCopyWith<_$WardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
