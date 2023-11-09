// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      street: json['street'] as String,
      address: json['address'] as String,
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      district: District.fromJson(json['district'] as Map<String, dynamic>),
      ward: Ward.fromJson(json['ward'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
      'ward': instance.ward,
    };
