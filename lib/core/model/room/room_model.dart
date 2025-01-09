import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class RoomModel {
  final int id;
  String? image;
  String? title;
  String? address;
  List<String>? addresses;
  dynamic price;
  double? avgRating;
  String? typeRating;
  int? totalRating;
  int? status;
  int? availableFrom;
  int? roomNumber;
  Map<String, dynamic>? roomNumbers;
  RoomType? roomType;
  List<String>? images;
  List<Utilities>? utilities;
  String? description;
  dynamic owner;
  int? capacity;
  int? gender;
  double? area;
  double? totalPrice;
  int? deposit;
  double? electricityCost;
  double? waterCost;
  double? internetCost;
  bool? isParking;
  double? parkingFee;
  bool? isRent;
  DateTime? createAt;
  DateTime? updateAt;
  bool? isLike;

  RoomModel({
    required this.id,
    this.image,
    this.title,
    this.address,
    this.addresses,
    this.price,
    this.avgRating,
    this.typeRating,
    this.totalRating,
    this.status,
    this.availableFrom,
    this.roomNumber,
    this.roomNumbers,
    this.roomType,
    this.images,
    this.utilities,
    this.description,
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
    this.isRent,
    this.createAt,
    this.updateAt,
    this.isLike,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as int,
      image: json['image'] as String?,
      title: json['title'] as String?,
      address: json['address'] is String ? json['address'] as String : null,
      addresses:
          json['address'] is List ? List<String>.from(json['address']) : null,
      price: _handlePrice(json['price']),
      avgRating: double.tryParse(json['avg_rating'].toString()),
      typeRating: json['type_rating'] as String?,
      totalRating: json['total_rating'] as int?,
      status: json['status'] as int?,
      availableFrom: json['available_from'] as int?,
      roomNumber: json['room_number'] as int?,
      roomNumbers: json['list_room_numbers'] != null
          ? json['list_room_numbers'] as Map<String, dynamic>
          : null,
      images: json['room_images'] != null
          ? List<String>.from(json['room_images'])
          : null,
      utilities: json['utilities'] != null
          ? (json['utilities'] as List<dynamic>)
              .map((e) => InfoUtilities.fromString(e.toString().toUpperCase()))
              .toList()
          : null,
      roomType: json['room_type'] != null
          ? InfoRoomType.fromString(json['room_type'])
          : null,
      description: json['description'] as String?,
      owner: json['owner'] is Map<String, dynamic>
          ? UserModel.fromMap(json['owner'] as Map<String, dynamic>)
          : json['owner'] as int?,
      capacity: json['capacity'] as int?,
      gender: json['gender'] as int?,
      area: json['area'] != null
          ? double.tryParse(json['area'].toString())
          : null,
      totalPrice: json['total_price'] * 1.0 as double?,
      deposit: json['deposit'] as int?,
      electricityCost: json['electricity_cost']?.toDouble(),
      waterCost: json['water_cost']?.toDouble(),
      internetCost: json['internet_cost']?.toDouble(),
      isParking: json['is_parking'] as bool,
      parkingFee: json['parking_fee']?.toDouble(),
      isRent: json['is_rent'] as bool,
      isLike: json['is_liked'] as bool?,
      createAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updateAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as int,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      address: map['address'] != null && map['address'] is String
          ? map['address'] as String
          : null,
      addresses: map['address'] != null && map['address'] is List
          ? List<String>.from(map['address'])
          : null,
      price: map['price'] as dynamic,
      avgRating: map['avg_rating'] != null
          ? double.tryParse(map['avg_rating'].toString())
          : null,
      typeRating:
          map['typeRating'] != null ? map['typeRating'] as String : null,
      totalRating:
          map['total_rating'] != null ? map['total_rating'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
      availableFrom:
          map['available_from'] != null ? map['available_from'] as int : null,
      roomNumber: map['room_number'] != null ? map['room_number'] as int : null,
      // roomNumbers: map['list_room_numbers'] != null
      //     ? map['list_room_numbers'] as Map<String, dynamic>
      //     : null,
      roomNumbers: _handRoomNumbers(map['list_room_numbers']),
      roomType: map['room_type'] != null
          ? InfoRoomType.fromString(map['room_type'])
          : null,
      images: map['room_images'] != null
          ? List<String>.from(map['room_images'])
          : null,
      utilities: map['utilities'] != null
          ? (map['utilities'] as List<dynamic>)
              .map((e) => InfoUtilities.fromString(e as String))
              .toList()
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      owner: map['owner'] != null ? _handleOwner(map['owner']) : null,
      capacity: map['capacity'] != null ? map['capacity'] as int : null,
      gender: map['gender'] != null ? map['gender'] as int : null,
      area:
          map['area'] != null ? double.tryParse(map['area'].toString()) : null,
      totalPrice: map['total_price'] != null
          ? map['total_price'] * 1.0 as double
          : null,
      deposit: map['deposit'] != null ? map['deposit'] as int : null,
      electricityCost: map['electricity_cost']?.toDouble(),
      waterCost: map['water_cost']?.toDouble(),
      internetCost: map['internet_cost']?.toDouble(),
      isParking: map['is_parking'] != null ? map['is_parking'] as bool : null,
      parkingFee: map['parking_fee']?.toDouble(),
      isRent: map['is_rent'] != null ? map['is_rent'] as bool : null,
      isLike: map['is_liked'] != null ? map['is_liked'] as bool : null,
      createAt: map['created_at'] != null
          ? DatetimeExt.parseFormatddMMyyyy(map['created_at'].toString())
          : null,
      updateAt: map['updated_at'] != null
          ? DatetimeExt.parseFormatddMMyyyy(map['updated_at'].toString())
          : null,
    );
  }

  get electricPrice => null;

  static _handRoomNumbers(dynamic roomNumbers) {
    if (roomNumbers == null) {
      return null;
    }
    if (roomNumbers is Map<String, dynamic>) {
      return roomNumbers;
    } else if (roomNumbers is String) {
      return json.decode(roomNumbers);
    }
    return {};
  }
  

  static _handleOwner(dynamic owner) {
    if (owner is Map<String, dynamic>) {
      return UserModel.fromMap(owner);
    } else if (owner is int) {
      return owner;
    }
    return UserModel();
  }

  static _handlePrice(dynamic price) {
    if (price is int) {
      return price;
    } else if (price is String) {
      return '${'from'.tr}: $price/${'room'.tr}';
    }
    return 0;
  }

  RoomModel copyWith({
    int? id,
    String? image,
    String? title,
    String? address,
    List<String>? addresses,
    dynamic price,
    double? avgRating,
    String? typeRating,
    int? totalRating,
    int? status,
    int? availableFrom,
    int? roomNumber,
    Map<String, dynamic>? roomNumbers,
    RoomType? roomType,
    List<String>? images,
    List<Utilities>? utilities,
    String? description,
    dynamic owner,
    int? capacity,
    int? gender,
    double? area,
    double? totalPrice,
    int? deposit,
    double? electricityCost,
    double? waterCost,
    double? internetCost,
    bool? isParking,
    double? parkingFee,
    bool? isRent,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return RoomModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      address: address ?? this.address,
      addresses: addresses ?? this.addresses,
      price: price ?? this.price,
      avgRating: avgRating ?? this.avgRating,
      typeRating: typeRating ?? this.typeRating,
      totalRating: totalRating ?? this.totalRating,
      status: status ?? this.status,
      availableFrom: availableFrom ?? this.availableFrom,
      roomNumber: roomNumber ?? this.roomNumber,
      roomNumbers: roomNumbers ?? this.roomNumbers,
      roomType: roomType ?? this.roomType,
      images: images ?? this.images,
      utilities: utilities ?? this.utilities,
      description: description ?? this.description,
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
      isRent: isRent ?? this.isRent,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'address': address,
      'addresses': addresses,
      'price': price,
      'avg_rating': avgRating,
      'type_rating': typeRating,
      'total_rating': totalRating,
      'status': status,
      'available_from': availableFrom,
      'room_number': roomNumber,
      'list_room_numbers': roomNumbers,
      'room_type': roomType?.toString(),
      'room_images': images,
      'utilities': utilities?.map((e) => e.toString()).toList(),
      'description': description,
      'owner': owner is UserModel ? (owner as UserModel).toMap() : owner,
      'capacity': capacity,
      'gender': gender,
      'area': area,
      'total_price': totalPrice,
      'deposit': deposit,
      'electricity_cost': electricityCost,
      'water_cost': waterCost,
      'internet_cost': internetCost,
      'is_parking': isParking,
      'parking_fee': parkingFee,
      'is_rent': isRent,
      'created_at': createAt?.toIso8601String(),
      'updated_at': updateAt?.toIso8601String(),
      'is_liked': isLike,
    };
  }

  Future<dio.FormData> toFormData() async {
    return dio.FormData.fromMap({});
  }

  @override
  String toString() {
    return 'RoomModel(id: $id, image: $image, title: $title, address: $address, addresses: $addresses, price: $price, avgRating: $avgRating, typeRating: $typeRating, totalRating: $totalRating, status: $status, availableFrom: $availableFrom, roomNumber: $roomNumber, roomNumbers: $roomNumbers, roomType: $roomType, images: $images, utilities: $utilities, description: $description, owner: $owner, capacity: $capacity, gender: $gender, area: $area, totalPrice: $totalPrice, deposit: $deposit, electricityCost: $electricityCost, waterCost: $waterCost, internetCost: $internetCost, isParking: $isParking, parkingFee: $parkingFee, isRent: $isRent, createAt: $createAt, updateAt: $updateAt, isLike: $isLike)';
  }
}
