// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'util_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UtilItem _$UtilItemFromJson(Map<String, dynamic> json) {
  return _UtilItem.fromJson(json);
}

/// @nodoc
mixin _$UtilItem {
  Utilities get utility => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UtilItemCopyWith<UtilItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UtilItemCopyWith<$Res> {
  factory $UtilItemCopyWith(UtilItem value, $Res Function(UtilItem) then) =
      _$UtilItemCopyWithImpl<$Res, UtilItem>;
  @useResult
  $Res call({Utilities utility, bool isChecked});
}

/// @nodoc
class _$UtilItemCopyWithImpl<$Res, $Val extends UtilItem>
    implements $UtilItemCopyWith<$Res> {
  _$UtilItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? utility = null,
    Object? isChecked = null,
  }) {
    return _then(_value.copyWith(
      utility: null == utility
          ? _value.utility
          : utility // ignore: cast_nullable_to_non_nullable
              as Utilities,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UtilItemImplCopyWith<$Res>
    implements $UtilItemCopyWith<$Res> {
  factory _$$UtilItemImplCopyWith(
          _$UtilItemImpl value, $Res Function(_$UtilItemImpl) then) =
      __$$UtilItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Utilities utility, bool isChecked});
}

/// @nodoc
class __$$UtilItemImplCopyWithImpl<$Res>
    extends _$UtilItemCopyWithImpl<$Res, _$UtilItemImpl>
    implements _$$UtilItemImplCopyWith<$Res> {
  __$$UtilItemImplCopyWithImpl(
      _$UtilItemImpl _value, $Res Function(_$UtilItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? utility = null,
    Object? isChecked = null,
  }) {
    return _then(_$UtilItemImpl(
      utility: null == utility
          ? _value.utility
          : utility // ignore: cast_nullable_to_non_nullable
              as Utilities,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UtilItemImpl extends _UtilItem {
  const _$UtilItemImpl({required this.utility, required this.isChecked})
      : super._();

  factory _$UtilItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UtilItemImplFromJson(json);

  @override
  final Utilities utility;
  @override
  final bool isChecked;

  @override
  String toString() {
    return 'UtilItem(utility: $utility, isChecked: $isChecked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UtilItemImpl &&
            (identical(other.utility, utility) || other.utility == utility) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, utility, isChecked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UtilItemImplCopyWith<_$UtilItemImpl> get copyWith =>
      __$$UtilItemImplCopyWithImpl<_$UtilItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UtilItemImplToJson(
      this,
    );
  }
}

abstract class _UtilItem extends UtilItem {
  const factory _UtilItem(
      {required final Utilities utility,
      required final bool isChecked}) = _$UtilItemImpl;
  const _UtilItem._() : super._();

  factory _UtilItem.fromJson(Map<String, dynamic> json) =
      _$UtilItemImpl.fromJson;

  @override
  Utilities get utility;
  @override
  bool get isChecked;
  @override
  @JsonKey(ignore: true)
  _$$UtilItemImplCopyWith<_$UtilItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
