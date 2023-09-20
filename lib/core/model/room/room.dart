import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_rent/core/model/location/location.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const Room._();
  const factory Room({
    required String id,
    required String title,
    required String description,
    required String roomType,
    required int capacity,
    required String gender,
    required double area,
    required int price,
    required int deposit,
    required int electricityCost,
    required int waterCost,
    required int internetCost,
    required bool hasParking,
    required int parkingFee,
    required Location location,
    required List<String> utilities,
    required String createdByUid,
    required String dateTime,
    required bool isRented,
    required String status,
    @Default([]) List<String> images,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}