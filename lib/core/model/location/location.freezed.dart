// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String get street => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  City get city => throw _privateConstructorUsedError;
  District get district => throw _privateConstructorUsedError;
  Ward get ward => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call(
      {String street, String address, City city, District district, Ward ward});

  $CityCopyWith<$Res> get city;
  $DistrictCopyWith<$Res> get district;
  $WardCopyWith<$Res> get ward;
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? address = null,
    Object? city = null,
    Object? district = null,
    Object? ward = null,
  }) {
    return _then(_value.copyWith(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as District,
      ward: null == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as Ward,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CityCopyWith<$Res> get city {
    return $CityCopyWith<$Res>(_value.city, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DistrictCopyWith<$Res> get district {
    return $DistrictCopyWith<$Res>(_value.district, (value) {
      return _then(_value.copyWith(district: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WardCopyWith<$Res> get ward {
    return $WardCopyWith<$Res>(_value.ward, (value) {
      return _then(_value.copyWith(ward: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$$_LocationCopyWith(
          _$_Location value, $Res Function(_$_Location) then) =
      __$$_LocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String street, String address, City city, District district, Ward ward});

  @override
  $CityCopyWith<$Res> get city;
  @override
  $DistrictCopyWith<$Res> get district;
  @override
  $WardCopyWith<$Res> get ward;
}

/// @nodoc
class __$$_LocationCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$_Location>
    implements _$$_LocationCopyWith<$Res> {
  __$$_LocationCopyWithImpl(
      _$_Location _value, $Res Function(_$_Location) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? address = null,
    Object? city = null,
    Object? district = null,
    Object? ward = null,
  }) {
    return _then(_$_Location(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as District,
      ward: null == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as Ward,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location extends _Location {
  const _$_Location(
      {required this.street,
      required this.address,
      required this.city,
      required this.district,
      required this.ward})
      : super._();

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$$_LocationFromJson(json);

  @override
  final String street;
  @override
  final String address;
  @override
  final City city;
  @override
  final District district;
  @override
  final Ward ward;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Location &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.ward, ward) || other.ward == ward));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, address, city, district, ward);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      __$$_LocationCopyWithImpl<_$_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(
      this,
    );
  }
}

abstract class _Location extends Location {
  const factory _Location(
      {required final String street,
      required final String address,
      required final City city,
      required final District district,
      required final Ward ward}) = _$_Location;
  const _Location._() : super._();

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  String get street;
  @override
  String get address;
  @override
  City get city;
  @override
  District get district;
  @override
  Ward get ward;
  @override
  @JsonKey(ignore: true)
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      throw _privateConstructorUsedError;
}
