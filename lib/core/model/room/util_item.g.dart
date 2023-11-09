// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'util_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UtilItemImpl _$$UtilItemImplFromJson(Map<String, dynamic> json) =>
    _$UtilItemImpl(
      utility: $enumDecode(_$UtilitiesEnumMap, json['utility']),
      isChecked: json['isChecked'] as bool,
    );

Map<String, dynamic> _$$UtilItemImplToJson(_$UtilItemImpl instance) =>
    <String, dynamic>{
      'utility': _$UtilitiesEnumMap[instance.utility]!,
      'isChecked': instance.isChecked,
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
