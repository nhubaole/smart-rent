// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      roomType: $enumDecodeNullable(_$RoomTypeEnumMap, json['roomType']) ??
          RoomType.ROOM,
      capacity: json['capacity'] as int? ?? 0,
      gender:
          $enumDecodeNullable(_$GenderEnumMap, json['gender']) ?? Gender.ALL,
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      price: json['price'] as int? ?? 0,
      deposit: json['deposit'] as int? ?? 0,
      electricityCost: json['electricityCost'] as int? ?? 0,
      waterCost: json['waterCost'] as int? ?? 0,
      internetCost: json['internetCost'] as int? ?? 0,
      hasParking: json['hasParking'] as bool? ?? true,
      parkingFee: json['parkingFee'] as int? ?? 0,
      location: json['location'] as String? ?? '',
      utilities: (json['utilities'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$UtilitiesEnumMap, e))
              .toList() ??
          const [],
      createdByUid: json['createdByUid'] as String? ?? '',
      dateTime: json['dateTime'] as String? ?? '',
      isRented: json['isRented'] as bool? ?? true,
      status: $enumDecodeNullable(_$RoomStatusEnumMap, json['status']) ??
          RoomStatus.PENDING,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listComments: (json['listComments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listLikes: (json['listLikes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'roomType': _$RoomTypeEnumMap[instance.roomType]!,
      'capacity': instance.capacity,
      'gender': _$GenderEnumMap[instance.gender]!,
      'area': instance.area,
      'price': instance.price,
      'deposit': instance.deposit,
      'electricityCost': instance.electricityCost,
      'waterCost': instance.waterCost,
      'internetCost': instance.internetCost,
      'hasParking': instance.hasParking,
      'parkingFee': instance.parkingFee,
      'location': instance.location,
      'utilities':
          instance.utilities.map((e) => _$UtilitiesEnumMap[e]!).toList(),
      'createdByUid': instance.createdByUid,
      'dateTime': instance.dateTime,
      'isRented': instance.isRented,
      'status': _$RoomStatusEnumMap[instance.status]!,
      'images': instance.images,
      'listComments': instance.listComments,
      'listLikes': instance.listLikes,
    };

const _$RoomTypeEnumMap = {
  RoomType.DORMITORY_HOMESTAY: 'DORMITORY_HOMESTAY',
  RoomType.ROOM: 'ROOM',
  RoomType.WHOLE_HOUSE: 'WHOLE_HOUSE',
  RoomType.APARTMENT: 'APARTMENT',
};

const _$GenderEnumMap = {
  Gender.ALL: 'ALL',
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
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

const _$RoomStatusEnumMap = {
  RoomStatus.PENDING: 'PENDING',
  RoomStatus.APPROVED: 'APPROVED',
  RoomStatus.EXPIRED: 'EXPIRED',
  RoomStatus.DELETED: 'DELETED',
};
