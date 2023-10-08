import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/location/city.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/location/location.dart';
import 'package:smart_rent/core/model/location/ward.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const Room._();
  const factory Room({
    @Default('0') String id,
    @Default('') String title,
    @Default('') String description,
    @Default(RoomType.ROOM) RoomType roomType,
    @Default(0) int capacity,
    @Default(Gender.ALL) Gender gender,
    @Default(0.0) double area,
    @Default(0) int price,
    @Default(0) int deposit,
    @Default(0) int electricityCost,
    @Default(0) int waterCost,
    @Default(0) int internetCost,
    @Default(true) bool hasParking,
    @Default(0) int parkingFee,
    @Default(Location(
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
            path_with_type: 'phường Tân Định, quận 1, thành phố Hồ Chí Minh',
            code: 'code',
            parent_code: 'parent_code')))
    Location location,
    @Default([]) List<Utilities> utilities,
    @Default('') String createdByUid,
    @Default('') String dateTime,
    @Default(true) bool isRented,
    @Default('') String status,
    @Default([]) List<String> images,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
