// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'util_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UtilFilter _$UtilFilterFromJson(Map<String, dynamic> json) {
  return _UtilFilter.fromJson(json);
}

/// @nodoc
mixin _$UtilFilter {
  List<Utilities> get listUtils => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UtilFilterCopyWith<UtilFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UtilFilterCopyWith<$Res> {
  factory $UtilFilterCopyWith(
          UtilFilter value, $Res Function(UtilFilter) then) =
      _$UtilFilterCopyWithImpl<$Res, UtilFilter>;
  @useResult
  $Res call({List<Utilities> listUtils});
}

/// @nodoc
class _$UtilFilterCopyWithImpl<$Res, $Val extends UtilFilter>
    implements $UtilFilterCopyWith<$Res> {
  _$UtilFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listUtils = null,
  }) {
    return _then(_value.copyWith(
      listUtils: null == listUtils
          ? _value.listUtils
          : listUtils // ignore: cast_nullable_to_non_nullable
              as List<Utilities>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UtilFilterImplCopyWith<$Res>
    implements $UtilFilterCopyWith<$Res> {
  factory _$$UtilFilterImplCopyWith(
          _$UtilFilterImpl value, $Res Function(_$UtilFilterImpl) then) =
      __$$UtilFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Utilities> listUtils});
}

/// @nodoc
class __$$UtilFilterImplCopyWithImpl<$Res>
    extends _$UtilFilterCopyWithImpl<$Res, _$UtilFilterImpl>
    implements _$$UtilFilterImplCopyWith<$Res> {
  __$$UtilFilterImplCopyWithImpl(
      _$UtilFilterImpl _value, $Res Function(_$UtilFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listUtils = null,
  }) {
    return _then(_$UtilFilterImpl(
      listUtils: null == listUtils
          ? _value._listUtils
          : listUtils // ignore: cast_nullable_to_non_nullable
              as List<Utilities>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UtilFilterImpl extends _UtilFilter {
  const _$UtilFilterImpl({required final List<Utilities> listUtils})
      : _listUtils = listUtils,
        super._();

  factory _$UtilFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$UtilFilterImplFromJson(json);

  final List<Utilities> _listUtils;
  @override
  List<Utilities> get listUtils {
    if (_listUtils is EqualUnmodifiableListView) return _listUtils;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listUtils);
  }

  @override
  String toString() {
    return 'UtilFilter(listUtils: $listUtils)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UtilFilterImpl &&
            const DeepCollectionEquality()
                .equals(other._listUtils, _listUtils));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_listUtils));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UtilFilterImplCopyWith<_$UtilFilterImpl> get copyWith =>
      __$$UtilFilterImplCopyWithImpl<_$UtilFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UtilFilterImplToJson(
      this,
    );
  }
}

abstract class _UtilFilter extends UtilFilter {
  const factory _UtilFilter({required final List<Utilities> listUtils}) =
      _$UtilFilterImpl;
  const _UtilFilter._() : super._();

  factory _UtilFilter.fromJson(Map<String, dynamic> json) =
      _$UtilFilterImpl.fromJson;

  @override
  List<Utilities> get listUtils;
  @override
  @JsonKey(ignore: true)
  _$$UtilFilterImplCopyWith<_$UtilFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
