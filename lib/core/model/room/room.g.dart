// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Room _$$_RoomFromJson(Map<String, dynamic> json) => _$_Room(
      id: json['id'] as String? ?? '0',
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
      location: json['location'] == null
          ? const Location(
              street: '1',
              address: '1',
              city: City(
                  name: 'name',
                  slug: 'slug',
                  type: 'type',
                  name_with_type: 'name_with_type',
                  code: 'code'),
              district: District(
                  name: 'name',
                  type: 'type',
                  slug: 'slug',
                  name_with_type: 'name_with_type',
                  path: 'path',
                  path_with_type: 'Quận 1, Thành phố Hồ Chí Minh',
                  code: 'code',
                  parent_code: 'parent_code'),
              ward: Ward(
                  name: 'name',
                  type: 'type',
                  slug: 'slug',
                  name_with_type: 'name_with_type',
                  path: 'path',
                  path_with_type:
                      'phường Tân Định, quận 1, thành phố Hồ Chí Minh',
                  code: 'code',
                  parent_code: 'parent_code'))
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      utilities: (json['utilities'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$UtilitiesEnumMap, e))
              .toList() ??
          const [],
      createdByUid: json['createdByUid'] as String? ?? '',
      dateTime: json['dateTime'] as String? ?? '',
      isRented: json['isRented'] as bool? ?? true,
      status: json['status'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RoomToJson(_$_Room instance) => <String, dynamic>{
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
      'status': instance.status,
      'images': instance.images,
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
