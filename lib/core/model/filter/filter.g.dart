// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterImpl _$$FilterImplFromJson(Map<String, dynamic> json) => _$FilterImpl(
      priceFilter: json['priceFilter'] == null
          ? null
          : PriceFilter.fromJson(json['priceFilter'] as Map<String, dynamic>),
      utilFilter: json['utilFilter'] == null
          ? null
          : UtilFilter.fromJson(json['utilFilter'] as Map<String, dynamic>),
      roomTypeFilter: json['roomTypeFilter'] == null
          ? null
          : RoomTypeFilter.fromJson(
              json['roomTypeFilter'] as Map<String, dynamic>),
      capacityFilter: json['capacityFilter'] == null
          ? null
          : CapacityFilter.fromJson(
              json['capacityFilter'] as Map<String, dynamic>),
      sortFilter: json['sortFilter'] == null
          ? null
          : SortFilter.fromJson(json['sortFilter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FilterImplToJson(_$FilterImpl instance) =>
    <String, dynamic>{
      'priceFilter': instance.priceFilter,
      'utilFilter': instance.utilFilter,
      'roomTypeFilter': instance.roomTypeFilter,
      'capacityFilter': instance.capacityFilter,
      'sortFilter': instance.sortFilter,
    };
