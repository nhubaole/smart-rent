import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_status.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const Room._();
  const factory Room({
    @Default('') String id,
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
    @Default('') String location,
    @Default([]) List<Utilities> utilities,
    @Default('') String createdByUid,
    @Default(0) int dateTime,
    @Default(true) bool isRented,
    @Default(RoomStatus.PENDING) RoomStatus status,
    @Default([]) List<String> images,
    @Default([]) List<String> listComments,
    @Default([]) List<String> listLikes,
    @Default('UNKNOWN') String rentBy,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
