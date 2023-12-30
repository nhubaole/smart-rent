// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capacity_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CapacityFilterImpl _$$CapacityFilterImplFromJson(Map<String, dynamic> json) =>
    _$CapacityFilterImpl(
      capacity: json['capacity'] as int,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$$CapacityFilterImplToJson(
        _$CapacityFilterImpl instance) =>
    <String, dynamic>{
      'capacity': instance.capacity,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.ALL: 'ALL',
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
};
