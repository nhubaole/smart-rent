// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'util_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UtilFilterImpl _$$UtilFilterImplFromJson(Map<String, dynamic> json) =>
    _$UtilFilterImpl(
      listUtils: (json['listUtils'] as List<dynamic>)
          .map((e) => $enumDecode(_$UtilitiesEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$UtilFilterImplToJson(_$UtilFilterImpl instance) =>
    <String, dynamic>{
      'listUtils':
          instance.listUtils.map((e) => _$UtilitiesEnumMap[e]!).toList(),
    };

const _$UtilitiesEnumMap = {
  Utilities.WC: 'WC',
  Utilities.WINDOW: 'WINDOW',
  Utilities.WIFI: 'WIFI',
  Utilities.KITCHEN: 'KITCHEN',
  Utilities.LAUNDRY: 'LAUNDRY',
  Utilities.FRIDGE: 'FRIDGE',
  Utilities.PARKING: 'PARKING',
  Utilities.SECURITY: 'SECURITY',
  Utilities.FLEXIBLE_HOURS: 'FLEXIBLE_HOURS',
  Utilities.PRIVATE: 'PRIVATE',
  Utilities.LOFT: 'LOFT',
  Utilities.PET: 'PET',
  Utilities.BED: 'BED',
  Utilities.WARDROBE: 'WARDROBE',
  Utilities.AIR_CONDITIONER: 'AIR_CONDITIONER',
};
