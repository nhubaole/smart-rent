// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SortFilterImpl _$$SortFilterImplFromJson(Map<String, dynamic> json) =>
    _$SortFilterImpl(
      sort: $enumDecode(_$SortEnumMap, json['sort']),
    );

Map<String, dynamic> _$$SortFilterImplToJson(_$SortFilterImpl instance) =>
    <String, dynamic>{
      'sort': _$SortEnumMap[instance.sort]!,
    };

const _$SortEnumMap = {
  Sort.MOST_RELATED: 'MOST_RELATED',
  Sort.LATEST: 'LATEST',
  Sort.LOWEST_TO_HIGHEST: 'LOWEST_TO_HIGHEST',
  Sort.HIGHEST_TO_LOWEST: 'HIGHEST_TO_LOWEST',
};
