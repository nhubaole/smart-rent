// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CityImpl _$$CityImplFromJson(Map<String, dynamic> json) => _$CityImpl(
      name: json['name'] as String,
      slug: json['slug'] as String,
      type: json['type'] as String,
      name_with_type: json['name_with_type'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$$CityImplToJson(_$CityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'type': instance.type,
      'name_with_type': instance.name_with_type,
      'code': instance.code,
    };
