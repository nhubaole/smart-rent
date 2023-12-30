// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomTypeFilterImpl _$$RoomTypeFilterImplFromJson(Map<String, dynamic> json) =>
    _$RoomTypeFilterImpl(
      roomType: $enumDecode(_$RoomTypeEnumMap, json['roomType']),
    );

Map<String, dynamic> _$$RoomTypeFilterImplToJson(
        _$RoomTypeFilterImpl instance) =>
    <String, dynamic>{
      'roomType': _$RoomTypeEnumMap[instance.roomType]!,
    };

const _$RoomTypeEnumMap = {
  RoomType.DORMITORY_HOMESTAY: 'DORMITORY_HOMESTAY',
  RoomType.ROOM: 'ROOM',
  RoomType.WHOLE_HOUSE: 'WHOLE_HOUSE',
  RoomType.APARTMENT: 'APARTMENT',
};
