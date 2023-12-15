// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PriceFilter _$PriceFilterFromJson(Map<String, dynamic> json) {
  return _PriceFilter.fromJson(json);
}

/// @nodoc
mixin _$PriceFilter {
  int get fromPrice => throw _privateConstructorUsedError;
  int get toPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceFilterCopyWith<PriceFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceFilterCopyWith<$Res> {
  factory $PriceFilterCopyWith(
          PriceFilter value, $Res Function(PriceFilter) then) =
      _$PriceFilterCopyWithImpl<$Res, PriceFilter>;
  @useResult
  $Res call({int fromPrice, int toPrice});
}

/// @nodoc
class _$PriceFilterCopyWithImpl<$Res, $Val extends PriceFilter>
    implements $PriceFilterCopyWith<$Res> {
  _$PriceFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromPrice = null,
    Object? toPrice = null,
  }) {
    return _then(_value.copyWith(
      fromPrice: null == fromPrice
          ? _value.fromPrice
          : fromPrice // ignore: cast_nullable_to_non_nullable
              as int,
      toPrice: null == toPrice
          ? _value.toPrice
          : toPrice // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceFilterImplCopyWith<$Res>
    implements $PriceFilterCopyWith<$Res> {
  factory _$$PriceFilterImplCopyWith(
          _$PriceFilterImpl value, $Res Function(_$PriceFilterImpl) then) =
      __$$PriceFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fromPrice, int toPrice});
}

/// @nodoc
class __$$PriceFilterImplCopyWithImpl<$Res>
    extends _$PriceFilterCopyWithImpl<$Res, _$PriceFilterImpl>
    implements _$$PriceFilterImplCopyWith<$Res> {
  __$$PriceFilterImplCopyWithImpl(
      _$PriceFilterImpl _value, $Res Function(_$PriceFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromPrice = null,
    Object? toPrice = null,
  }) {
    return _then(_$PriceFilterImpl(
      fromPrice: null == fromPrice
          ? _value.fromPrice
          : fromPrice // ignore: cast_nullable_to_non_nullable
              as int,
      toPrice: null == toPrice
          ? _value.toPrice
          : toPrice // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceFilterImpl extends _PriceFilter {
  const _$PriceFilterImpl({required this.fromPrice, required this.toPrice})
      : super._();

  factory _$PriceFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceFilterImplFromJson(json);

  @override
  final int fromPrice;
  @override
  final int toPrice;

  @override
  String toString() {
    return 'PriceFilter(fromPrice: $fromPrice, toPrice: $toPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceFilterImpl &&
            (identical(other.fromPrice, fromPrice) ||
                other.fromPrice == fromPrice) &&
            (identical(other.toPrice, toPrice) || other.toPrice == toPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fromPrice, toPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceFilterImplCopyWith<_$PriceFilterImpl> get copyWith =>
      __$$PriceFilterImplCopyWithImpl<_$PriceFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceFilterImplToJson(
      this,
    );
  }
}

abstract class _PriceFilter extends PriceFilter {
  const factory _PriceFilter(
      {required final int fromPrice,
      required final int toPrice}) = _$PriceFilterImpl;
  const _PriceFilter._() : super._();

  factory _PriceFilter.fromJson(Map<String, dynamic> json) =
      _$PriceFilterImpl.fromJson;

  @override
  int get fromPrice;
  @override
  int get toPrice;
  @override
  @JsonKey(ignore: true)
  _$$PriceFilterImplCopyWith<_$PriceFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
