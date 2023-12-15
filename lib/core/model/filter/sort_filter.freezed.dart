// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SortFilter _$SortFilterFromJson(Map<String, dynamic> json) {
  return _SortFilter.fromJson(json);
}

/// @nodoc
mixin _$SortFilter {
  Sort get sort => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SortFilterCopyWith<SortFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortFilterCopyWith<$Res> {
  factory $SortFilterCopyWith(
          SortFilter value, $Res Function(SortFilter) then) =
      _$SortFilterCopyWithImpl<$Res, SortFilter>;
  @useResult
  $Res call({Sort sort});
}

/// @nodoc
class _$SortFilterCopyWithImpl<$Res, $Val extends SortFilter>
    implements $SortFilterCopyWith<$Res> {
  _$SortFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sort = null,
  }) {
    return _then(_value.copyWith(
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as Sort,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SortFilterImplCopyWith<$Res>
    implements $SortFilterCopyWith<$Res> {
  factory _$$SortFilterImplCopyWith(
          _$SortFilterImpl value, $Res Function(_$SortFilterImpl) then) =
      __$$SortFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Sort sort});
}

/// @nodoc
class __$$SortFilterImplCopyWithImpl<$Res>
    extends _$SortFilterCopyWithImpl<$Res, _$SortFilterImpl>
    implements _$$SortFilterImplCopyWith<$Res> {
  __$$SortFilterImplCopyWithImpl(
      _$SortFilterImpl _value, $Res Function(_$SortFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sort = null,
  }) {
    return _then(_$SortFilterImpl(
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as Sort,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SortFilterImpl extends _SortFilter {
  const _$SortFilterImpl({required this.sort}) : super._();

  factory _$SortFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$SortFilterImplFromJson(json);

  @override
  final Sort sort;

  @override
  String toString() {
    return 'SortFilter(sort: $sort)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortFilterImpl &&
            (identical(other.sort, sort) || other.sort == sort));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sort);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SortFilterImplCopyWith<_$SortFilterImpl> get copyWith =>
      __$$SortFilterImplCopyWithImpl<_$SortFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SortFilterImplToJson(
      this,
    );
  }
}

abstract class _SortFilter extends SortFilter {
  const factory _SortFilter({required final Sort sort}) = _$SortFilterImpl;
  const _SortFilter._() : super._();

  factory _SortFilter.fromJson(Map<String, dynamic> json) =
      _$SortFilterImpl.fromJson;

  @override
  Sort get sort;
  @override
  @JsonKey(ignore: true)
  _$$SortFilterImplCopyWith<_$SortFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
