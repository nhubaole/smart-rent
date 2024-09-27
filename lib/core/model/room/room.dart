// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Room {
  int? id;
  String? title;
  List<String>? address;
  int? roomNumber;
  List<String>? roomImages;
  List<String>? utilities;
  String? description;
  String? roomType;
  int? owner;
  int? capacity;
  int? gender;
  double? area;
  int? totalPrice;
  int? deposit;
  double? electricityCost;
  double? waterCost;
  double? internetCost;
  bool? isParking;
  int? parkingFee;
  int? status;
  bool? isRent;
  String? createdAt;
  String? updatedAt;
  Room({
    this.id,
    this.title,
    this.address,
    this.roomNumber,
    this.roomImages,
    this.utilities,
    this.description,
    this.roomType,
    this.owner,
    this.capacity,
    this.gender,
    this.area,
    this.totalPrice,
    this.deposit,
    this.electricityCost,
    this.waterCost,
    this.internetCost,
    this.isParking,
    this.parkingFee,
    this.status,
    this.isRent,
    this.createdAt,
    this.updatedAt,
  });

  Room copyWith({
    int? id,
    String? title,
    List<String>? address,
    int? roomNumber,
    List<String>? roomImages,
    List<String>? utilities,
    String? description,
    String? roomType,
    int? owner,
    int? capacity,
    int? gender,
    double? area,
    int? totalPrice,
    int? deposit,
    double? electricityCost,
    double? waterCost,
    double? internetCost,
    bool? isParking,
    int? parkingFee,
    int? status,
    bool? isRent,
    String? createdAt,
    String? updatedAt,
  }) {
    return Room(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      roomNumber: roomNumber ?? this.roomNumber,
      roomImages: roomImages ?? this.roomImages,
      utilities: utilities ?? this.utilities,
      description: description ?? this.description,
      roomType: roomType ?? this.roomType,
      owner: owner ?? this.owner,
      capacity: capacity ?? this.capacity,
      gender: gender ?? this.gender,
      area: area ?? this.area,
      totalPrice: totalPrice ?? this.totalPrice,
      deposit: deposit ?? this.deposit,
      electricityCost: electricityCost ?? this.electricityCost,
      waterCost: waterCost ?? this.waterCost,
      internetCost: internetCost ?? this.internetCost,
      isParking: isParking ?? this.isParking,
      parkingFee: parkingFee ?? this.parkingFee,
      status: status ?? this.status,
      isRent: isRent ?? this.isRent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'address': address,
      'roomNumber': roomNumber,
      'roomImages': roomImages,
      'utilities': utilities,
      'description': description,
      'roomType': roomType,
      'owner': owner,
      'capacity': capacity,
      'gender': gender,
      'area': area,
      'totalPrice': totalPrice,
      'deposit': deposit,
      'electricityCost': electricityCost,
      'waterCost': waterCost,
      'internetCost': internetCost,
      'isParking': isParking,
      'parkingFee': parkingFee,
      'status': status,
      'isRent': isRent,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      address:
          map['address'] != null ? List<String>.from(map['address']) : null,
      roomNumber: map['room_number'] != null ? map['room_number'] as int : null,
      roomImages: map['room_images'] != null
          ? List<String>.from(map['room_images'])
          : null,
      utilities:
          map['utilities'] != null ? List<String>.from(map['utilities']) : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      roomType: map['room_type'] != null ? map['room_type'] as String : null,
      owner: map['owner'] != null ? map['owner'] as int : null,
      capacity: map['capacity'] != null ? map['capacity'] as int : null,
      gender: map['gender'] != null ? map['gender'] as int : null,
      area: map['area'] != null ? map['area'] * 1.0 as double : null,
      totalPrice: map['total_price'] != null ? map['total_price'] as int : null,
      deposit: map['deposit'] != null ? map['deposit'] as int : null,
      electricityCost: map['electricity_cost'] != null
          ? map['electricity_cost'] * 1.0 as double
          : null,
      waterCost:
          map['water_cost'] != null ? map['water_cost'] * 1.0 as double : null,
      internetCost: map['internet_cost'] != null
          ? map['internet_cost'] * 1.0 as double
          : null,
      isParking: map['is_parking'] != null ? map['is_parking'] as bool : null,
      parkingFee: map['parking_fee'] != null ? map['parking_fee'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
      isRent: map['is_rent'] != null ? map['is_rent'] as bool : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(id: $id, title: $title, address: $address, roomNumber: $roomNumber, roomImages: $roomImages, utilities: $utilities, description: $description, roomType: $roomType, owner: $owner, capacity: $capacity, gender: $gender, area: $area, totalPrice: $totalPrice, deposit: $deposit, electricityCost: $electricityCost, waterCost: $waterCost, internetCost: $internetCost, isParking: $isParking, parkingFee: $parkingFee, status: $status, isRent: $isRent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.address, address) &&
        other.roomNumber == roomNumber &&
        listEquals(other.roomImages, roomImages) &&
        listEquals(other.utilities, utilities) &&
        other.description == description &&
        other.roomType == roomType &&
        other.owner == owner &&
        other.capacity == capacity &&
        other.gender == gender &&
        other.area == area &&
        other.totalPrice == totalPrice &&
        other.deposit == deposit &&
        other.electricityCost == electricityCost &&
        other.waterCost == waterCost &&
        other.internetCost == internetCost &&
        other.isParking == isParking &&
        other.parkingFee == parkingFee &&
        other.status == status &&
        other.isRent == isRent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        address.hashCode ^
        roomNumber.hashCode ^
        roomImages.hashCode ^
        utilities.hashCode ^
        description.hashCode ^
        roomType.hashCode ^
        owner.hashCode ^
        capacity.hashCode ^
        gender.hashCode ^
        area.hashCode ^
        totalPrice.hashCode ^
        deposit.hashCode ^
        electricityCost.hashCode ^
        waterCost.hashCode ^
        internetCost.hashCode ^
        isParking.hashCode ^
        parkingFee.hashCode ^
        status.hashCode ^
        isRent.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
