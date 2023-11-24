// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capacity_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CapacityFilter _$CapacityFilterFromJson(Map<String, dynamic> json) {
  return _CapacityFilter.fromJson(json);
}

/// @nodoc
mixin _$CapacityFilter {
  int get capacity => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CapacityFilterCopyWith<CapacityFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapacityFilterCopyWith<$Res> {
  factory $CapacityFilterCopyWith(
          CapacityFilter value, $Res Function(CapacityFilter) then) =
      _$CapacityFilterCopyWithImpl<$Res, CapacityFilter>;
  @useResult
  $Res call({int capacity, Gender gender});
}

/// @nodoc
class _$CapacityFilterCopyWithImpl<$Res, $Val extends CapacityFilter>
    implements $CapacityFilterCopyWith<$Res> {
  _$CapacityFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capacity = null,
    Object? gender = null,
  }) {
    return _then(_value.copyWith(
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CapacityFilterImplCopyWith<$Res>
    implements $CapacityFilterCopyWith<$Res> {
  factory _$$CapacityFilterImplCopyWith(_$CapacityFilterImpl value,
          $Res Function(_$CapacityFilterImpl) then) =
      __$$CapacityFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int capacity, Gender gender});
}

/// @nodoc
class __$$CapacityFilterImplCopyWithImpl<$Res>
    extends _$CapacityFilterCopyWithImpl<$Res, _$CapacityFilterImpl>
    implements _$$CapacityFilterImplCopyWith<$Res> {
  __$$CapacityFilterImplCopyWithImpl(
      _$CapacityFilterImpl _value, $Res Function(_$CapacityFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capacity = null,
    Object? gender = null,
  }) {
    return _then(_$CapacityFilterImpl(
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CapacityFilterImpl extends _CapacityFilter {
  const _$CapacityFilterImpl({required this.capacity, required this.gender})
      : super._();

  factory _$CapacityFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapacityFilterImplFromJson(json);

  @override
  final int capacity;
  @override
  final Gender gender;

  @override
  String toString() {
    return 'CapacityFilter(capacity: $capacity, gender: $gender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapacityFilterImpl &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, capacity, gender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CapacityFilterImplCopyWith<_$CapacityFilterImpl> get copyWith =>
      __$$CapacityFilterImplCopyWithImpl<_$CapacityFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CapacityFilterImplToJson(
      this,
    );
  }
}

abstract class _CapacityFilter extends CapacityFilter {
  const factory _CapacityFilter(
      {required final int capacity,
      required final Gender gender}) = _$CapacityFilterImpl;
  const _CapacityFilter._() : super._();

  factory _CapacityFilter.fromJson(Map<String, dynamic> json) =
      _$CapacityFilterImpl.fromJson;

  @override
  int get capacity;
  @override
  Gender get gender;
  @override
  @JsonKey(ignore: true)
  _$$CapacityFilterImplCopyWith<_$CapacityFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
