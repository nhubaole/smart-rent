// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return _Filter.fromJson(json);
}

/// @nodoc
mixin _$Filter {
  PriceFilter? get priceFilter => throw _privateConstructorUsedError;
  UtilFilter? get utilFilter => throw _privateConstructorUsedError;
  RoomTypeFilter? get roomTypeFilter => throw _privateConstructorUsedError;
  CapacityFilter? get capacityFilter => throw _privateConstructorUsedError;
  SortFilter? get sortFilter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res, Filter>;
  @useResult
  $Res call(
      {PriceFilter? priceFilter,
      UtilFilter? utilFilter,
      RoomTypeFilter? roomTypeFilter,
      CapacityFilter? capacityFilter,
      SortFilter? sortFilter});

  $PriceFilterCopyWith<$Res>? get priceFilter;
  $UtilFilterCopyWith<$Res>? get utilFilter;
  $RoomTypeFilterCopyWith<$Res>? get roomTypeFilter;
  $CapacityFilterCopyWith<$Res>? get capacityFilter;
  $SortFilterCopyWith<$Res>? get sortFilter;
}

/// @nodoc
class _$FilterCopyWithImpl<$Res, $Val extends Filter>
    implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceFilter = freezed,
    Object? utilFilter = freezed,
    Object? roomTypeFilter = freezed,
    Object? capacityFilter = freezed,
    Object? sortFilter = freezed,
  }) {
    return _then(_value.copyWith(
      priceFilter: freezed == priceFilter
          ? _value.priceFilter
          : priceFilter // ignore: cast_nullable_to_non_nullable
              as PriceFilter?,
      utilFilter: freezed == utilFilter
          ? _value.utilFilter
          : utilFilter // ignore: cast_nullable_to_non_nullable
              as UtilFilter?,
      roomTypeFilter: freezed == roomTypeFilter
          ? _value.roomTypeFilter
          : roomTypeFilter // ignore: cast_nullable_to_non_nullable
              as RoomTypeFilter?,
      capacityFilter: freezed == capacityFilter
          ? _value.capacityFilter
          : capacityFilter // ignore: cast_nullable_to_non_nullable
              as CapacityFilter?,
      sortFilter: freezed == sortFilter
          ? _value.sortFilter
          : sortFilter // ignore: cast_nullable_to_non_nullable
              as SortFilter?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceFilterCopyWith<$Res>? get priceFilter {
    if (_value.priceFilter == null) {
      return null;
    }

    return $PriceFilterCopyWith<$Res>(_value.priceFilter!, (value) {
      return _then(_value.copyWith(priceFilter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UtilFilterCopyWith<$Res>? get utilFilter {
    if (_value.utilFilter == null) {
      return null;
    }

    return $UtilFilterCopyWith<$Res>(_value.utilFilter!, (value) {
      return _then(_value.copyWith(utilFilter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RoomTypeFilterCopyWith<$Res>? get roomTypeFilter {
    if (_value.roomTypeFilter == null) {
      return null;
    }

    return $RoomTypeFilterCopyWith<$Res>(_value.roomTypeFilter!, (value) {
      return _then(_value.copyWith(roomTypeFilter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CapacityFilterCopyWith<$Res>? get capacityFilter {
    if (_value.capacityFilter == null) {
      return null;
    }

    return $CapacityFilterCopyWith<$Res>(_value.capacityFilter!, (value) {
      return _then(_value.copyWith(capacityFilter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SortFilterCopyWith<$Res>? get sortFilter {
    if (_value.sortFilter == null) {
      return null;
    }

    return $SortFilterCopyWith<$Res>(_value.sortFilter!, (value) {
      return _then(_value.copyWith(sortFilter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilterImplCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$$FilterImplCopyWith(
          _$FilterImpl value, $Res Function(_$FilterImpl) then) =
      __$$FilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PriceFilter? priceFilter,
      UtilFilter? utilFilter,
      RoomTypeFilter? roomTypeFilter,
      CapacityFilter? capacityFilter,
      SortFilter? sortFilter});

  @override
  $PriceFilterCopyWith<$Res>? get priceFilter;
  @override
  $UtilFilterCopyWith<$Res>? get utilFilter;
  @override
  $RoomTypeFilterCopyWith<$Res>? get roomTypeFilter;
  @override
  $CapacityFilterCopyWith<$Res>? get capacityFilter;
  @override
  $SortFilterCopyWith<$Res>? get sortFilter;
}

/// @nodoc
class __$$FilterImplCopyWithImpl<$Res>
    extends _$FilterCopyWithImpl<$Res, _$FilterImpl>
    implements _$$FilterImplCopyWith<$Res> {
  __$$FilterImplCopyWithImpl(
      _$FilterImpl _value, $Res Function(_$FilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceFilter = freezed,
    Object? utilFilter = freezed,
    Object? roomTypeFilter = freezed,
    Object? capacityFilter = freezed,
    Object? sortFilter = freezed,
  }) {
    return _then(_$FilterImpl(
      priceFilter: freezed == priceFilter
          ? _value.priceFilter
          : priceFilter // ignore: cast_nullable_to_non_nullable
              as PriceFilter?,
      utilFilter: freezed == utilFilter
          ? _value.utilFilter
          : utilFilter // ignore: cast_nullable_to_non_nullable
              as UtilFilter?,
      roomTypeFilter: freezed == roomTypeFilter
          ? _value.roomTypeFilter
          : roomTypeFilter // ignore: cast_nullable_to_non_nullable
              as RoomTypeFilter?,
      capacityFilter: freezed == capacityFilter
          ? _value.capacityFilter
          : capacityFilter // ignore: cast_nullable_to_non_nullable
              as CapacityFilter?,
      sortFilter: freezed == sortFilter
          ? _value.sortFilter
          : sortFilter // ignore: cast_nullable_to_non_nullable
              as SortFilter?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterImpl extends _Filter {
  const _$FilterImpl(
      {this.priceFilter,
      this.utilFilter,
      this.roomTypeFilter,
      this.capacityFilter,
      this.sortFilter})
      : super._();

  factory _$FilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterImplFromJson(json);

  @override
  final PriceFilter? priceFilter;
  @override
  final UtilFilter? utilFilter;
  @override
  final RoomTypeFilter? roomTypeFilter;
  @override
  final CapacityFilter? capacityFilter;
  @override
  final SortFilter? sortFilter;

  @override
  String toString() {
    return 'Filter(priceFilter: $priceFilter, utilFilter: $utilFilter, roomTypeFilter: $roomTypeFilter, capacityFilter: $capacityFilter, sortFilter: $sortFilter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterImpl &&
            (identical(other.priceFilter, priceFilter) ||
                other.priceFilter == priceFilter) &&
            (identical(other.utilFilter, utilFilter) ||
                other.utilFilter == utilFilter) &&
            (identical(other.roomTypeFilter, roomTypeFilter) ||
                other.roomTypeFilter == roomTypeFilter) &&
            (identical(other.capacityFilter, capacityFilter) ||
                other.capacityFilter == capacityFilter) &&
            (identical(other.sortFilter, sortFilter) ||
                other.sortFilter == sortFilter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, priceFilter, utilFilter,
      roomTypeFilter, capacityFilter, sortFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      __$$FilterImplCopyWithImpl<_$FilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterImplToJson(
      this,
    );
  }
}

abstract class _Filter extends Filter {
  const factory _Filter(
      {final PriceFilter? priceFilter,
      final UtilFilter? utilFilter,
      final RoomTypeFilter? roomTypeFilter,
      final CapacityFilter? capacityFilter,
      final SortFilter? sortFilter}) = _$FilterImpl;
  const _Filter._() : super._();

  factory _Filter.fromJson(Map<String, dynamic> json) = _$FilterImpl.fromJson;

  @override
  PriceFilter? get priceFilter;
  @override
  UtilFilter? get utilFilter;
  @override
  RoomTypeFilter? get roomTypeFilter;
  @override
  CapacityFilter? get capacityFilter;
  @override
  SortFilter? get sortFilter;
  @override
  @JsonKey(ignore: true)
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
