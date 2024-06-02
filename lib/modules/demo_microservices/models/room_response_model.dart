// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoomResponseModel {
  final int id;
  final String roomType;
  final int capacity;
  final String gender;
  final int price;
  final int deposit;
  final int electricityCost;
  final int waterCost;
  final int internetCost;
  final bool hasParking;
  final int parkingFee;
  final String location;
  final String title;
  final String description;
  final String utilities;
  final String createdBy;
  final int area;
  RoomResponseModel({
    required this.id,
    required this.roomType,
    required this.capacity,
    required this.gender,
    required this.price,
    required this.deposit,
    required this.electricityCost,
    required this.waterCost,
    required this.internetCost,
    required this.hasParking,
    required this.parkingFee,
    required this.location,
    required this.title,
    required this.description,
    required this.utilities,
    required this.createdBy,
    required this.area,
  });

  RoomResponseModel copyWith({
    int? id,
    String? roomType,
    int? capacity,
    String? gender,
    int? price,
    int? deposit,
    int? electricityCost,
    int? waterCost,
    int? internetCost,
    bool? hasParking,
    int? parkingFee,
    String? location,
    String? title,
    String? description,
    String? utilities,
    String? createdBy,
    int? area,
  }) {
    return RoomResponseModel(
      id: id ?? this.id,
      roomType: roomType ?? this.roomType,
      capacity: capacity ?? this.capacity,
      gender: gender ?? this.gender,
      price: price ?? this.price,
      deposit: deposit ?? this.deposit,
      electricityCost: electricityCost ?? this.electricityCost,
      waterCost: waterCost ?? this.waterCost,
      internetCost: internetCost ?? this.internetCost,
      hasParking: hasParking ?? this.hasParking,
      parkingFee: parkingFee ?? this.parkingFee,
      location: location ?? this.location,
      title: title ?? this.title,
      description: description ?? this.description,
      utilities: utilities ?? this.utilities,
      createdBy: createdBy ?? this.createdBy,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'roomType': roomType,
      'capacity': capacity,
      'gender': gender,
      'price': price,
      'deposit': deposit,
      'electricityCost': electricityCost,
      'waterCost': waterCost,
      'internetCost': internetCost,
      'hasParking': hasParking,
      'parkingFee': parkingFee,
      'location': location,
      'title': title,
      'description': description,
      'utilities': utilities,
      'createdBy': createdBy,
      'area': area,
    };
  }

  factory RoomResponseModel.fromMap(Map<String, dynamic> map) {
    return RoomResponseModel(
      id: map['id'] as int,
      roomType: map['roomType'] as String,
      capacity: map['capacity'] as int,
      gender: map['gender'] as String,
      price: map['price'] as int,
      deposit: map['deposit'] as int,
      electricityCost: map['electricityCost'] as int,
      waterCost: map['waterCost'] as int,
      internetCost: map['internetCost'] as int,
      hasParking: map['hasParking'] as bool,
      parkingFee: map['parkingFee'] as int,
      location: map['location'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      utilities: map['utilities'] as String,
      createdBy: map['createdBy'] as String,
      area: map['area'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomResponseModel.fromJson(String source) =>
      RoomResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomResponseModel(id: $id, roomType: $roomType, capacity: $capacity, gender: $gender, price: $price, deposit: $deposit, electricityCost: $electricityCost, waterCost: $waterCost, internetCost: $internetCost, hasParking: $hasParking, parkingFee: $parkingFee, location: $location, title: $title, description: $description, utilities: $utilities, createdBy: $createdBy, area: $area)';
  }

  @override
  bool operator ==(covariant RoomResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roomType == roomType &&
        other.capacity == capacity &&
        other.gender == gender &&
        other.price == price &&
        other.deposit == deposit &&
        other.electricityCost == electricityCost &&
        other.waterCost == waterCost &&
        other.internetCost == internetCost &&
        other.hasParking == hasParking &&
        other.parkingFee == parkingFee &&
        other.location == location &&
        other.title == title &&
        other.description == description &&
        other.utilities == utilities &&
        other.createdBy == createdBy &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roomType.hashCode ^
        capacity.hashCode ^
        gender.hashCode ^
        price.hashCode ^
        deposit.hashCode ^
        electricityCost.hashCode ^
        waterCost.hashCode ^
        internetCost.hashCode ^
        hasParking.hashCode ^
        parkingFee.hashCode ^
        location.hashCode ^
        title.hashCode ^
        description.hashCode ^
        utilities.hashCode ^
        createdBy.hashCode ^
        area.hashCode;
  }
}
