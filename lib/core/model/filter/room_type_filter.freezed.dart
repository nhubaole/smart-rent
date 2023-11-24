// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_type_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomTypeFilter _$RoomTypeFilterFromJson(Map<String, dynamic> json) {
  return _RoomTypeFilter.fromJson(json);
}

/// @nodoc
mixin _$RoomTypeFilter {
  RoomType get roomType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomTypeFilterCopyWith<RoomTypeFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomTypeFilterCopyWith<$Res> {
  factory $RoomTypeFilterCopyWith(
          RoomTypeFilter value, $Res Function(RoomTypeFilter) then) =
      _$RoomTypeFilterCopyWithImpl<$Res, RoomTypeFilter>;
  @useResult
  $Res call({RoomType roomType});
}

/// @nodoc
class _$RoomTypeFilterCopyWithImpl<$Res, $Val extends RoomTypeFilter>
    implements $RoomTypeFilterCopyWith<$Res> {
  _$RoomTypeFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomType = null,
  }) {
    return _then(_value.copyWith(
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as RoomType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomTypeFilterImplCopyWith<$Res>
    implements $RoomTypeFilterCopyWith<$Res> {
  factory _$$RoomTypeFilterImplCopyWith(_$RoomTypeFilterImpl value,
          $Res Function(_$RoomTypeFilterImpl) then) =
      __$$RoomTypeFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RoomType roomType});
}

/// @nodoc
class __$$RoomTypeFilterImplCopyWithImpl<$Res>
    extends _$RoomTypeFilterCopyWithImpl<$Res, _$RoomTypeFilterImpl>
    implements _$$RoomTypeFilterImplCopyWith<$Res> {
  __$$RoomTypeFilterImplCopyWithImpl(
      _$RoomTypeFilterImpl _value, $Res Function(_$RoomTypeFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomType = null,
  }) {
    return _then(_$RoomTypeFilterImpl(
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as RoomType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomTypeFilterImpl extends _RoomTypeFilter {
  const _$RoomTypeFilterImpl({required this.roomType}) : super._();

  factory _$RoomTypeFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomTypeFilterImplFromJson(json);

  @override
  final RoomType roomType;

  @override
  String toString() {
    return 'RoomTypeFilter(roomType: $roomType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomTypeFilterImpl &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, roomType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomTypeFilterImplCopyWith<_$RoomTypeFilterImpl> get copyWith =>
      __$$RoomTypeFilterImplCopyWithImpl<_$RoomTypeFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomTypeFilterImplToJson(
      this,
    );
  }
}

abstract class _RoomTypeFilter extends RoomTypeFilter {
  const factory _RoomTypeFilter({required final RoomType roomType}) =
      _$RoomTypeFilterImpl;
  const _RoomTypeFilter._() : super._();

  factory _RoomTypeFilter.fromJson(Map<String, dynamic> json) =
      _$RoomTypeFilterImpl.fromJson;

  @override
  RoomType get roomType;
  @override
  @JsonKey(ignore: true)
  _$$RoomTypeFilterImplCopyWith<_$RoomTypeFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
