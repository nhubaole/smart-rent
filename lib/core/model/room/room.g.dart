// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Room _$$_RoomFromJson(Map<String, dynamic> json) => _$_Room(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      roomType: json['roomType'] as String,
      capacity: json['capacity'] as int,
      gender: json['gender'] as String,
      area: (json['area'] as num).toDouble(),
      price: json['price'] as int,
      deposit: json['deposit'] as int,
      electricityCost: json['electricityCost'] as int,
      waterCost: json['waterCost'] as int,
      internetCost: json['internetCost'] as int,
      hasParking: json['hasParking'] as bool,
      parkingFee: json['parkingFee'] as int,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      utilities:
          (json['utilities'] as List<dynamic>).map((e) => e as String).toList(),
      createdByUid: json['createdByUid'] as String,
      dateTime: json['dateTime'] as String,
      isRented: json['isRented'] as bool,
      status: json['status'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RoomToJson(_$_Room instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'roomType': instance.roomType,
      'capacity': instance.capacity,
      'gender': instance.gender,
      'area': instance.area,
      'price': instance.price,
      'deposit': instance.deposit,
      'electricityCost': instance.electricityCost,
      'waterCost': instance.waterCost,
      'internetCost': instance.internetCost,
      'hasParking': instance.hasParking,
      'parkingFee': instance.parkingFee,
      'location': instance.location,
      'utilities': instance.utilities,
      'createdByUid': instance.createdByUid,
      'dateTime': instance.dateTime,
      'isRented': instance.isRented,
      'status': instance.status,
      'images': instance.images,
    };
