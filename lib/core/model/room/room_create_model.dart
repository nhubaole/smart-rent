// ignore_for_file: public_member_api_docs, sort_constructors_first
// 'files': [
//   await MultipartFile.fromFile('postman-cloud:///1ef6dc0d-fd6f-4610-b4c7-85019085f643', filename: 'postman-cloud:///1ef6dc0d-fd6f-4610-b4c7-85019085f643'),
//   await MultipartFile.fromFile('postman-cloud:///1ef6dbc6-f048-40a0-9e44-cdb1ea2d77d3', filename: 'postman-cloud:///1ef6dbc6-f048-40a0-9e44-cdb1ea2d77d3')
// ],
// 'title': 'Deluxe Room For Couple',
// 'address': '97',
// 'address': 'Đường số 11',
// 'room_number': '101',
// 'utilities': 'WiFi',
// 'utilities': 'Air Conditioning',
// 'description': 'A spacious room with modern amenities.',
// 'room_type': 'single',
// 'owner': '1',
// 'capacity': '2',
// 'gender': '1',
// 'area': '500',
// 'total_price': '500',
// 'deposit': '100',
// 'electricity_cost': '0.5',
// 'water_cost': '0.3',
// 'internet_cost': '0.1',
// 'is_parking': 'true',
// 'parking_fee': '50',
// 'status': '1',
// 'is_rent': 'true',
// 'address': 'phường Trường Thọ',
// 'address': 'quận Thủ Đức',
// 'address': 'TP HCM'

import 'package:dio/dio.dart';

import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';

class RoomCreateModel {
  String? title;
  List<String>? addresses;
  int? roomNumber;
  List<String>? roomImages;
  List<Utilities>? utilities;
  String? description;
  RoomType? roomType;
  int? owner;
  int? capacity;
  Gender? gender;
  double? area;
  double? totalPrice;
  double? deposit;
  double? electricityCost;
  double? waterCost;
  double? internetCost;
  bool? isParking;
  double? parkingFee;
  int? status;
  bool? isRent;

  RoomCreateModel({
    this.title,
    this.addresses,
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
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData();

    if (roomImages != null) {
      for (var imagePath in roomImages!) {
        formData.files.add(
          MapEntry(
            'room_images',
            await MultipartFile.fromFile(
              imagePath,
              filename: imagePath.split('/').last,
            ),
          ),
        );
      }
    }

    if (addresses != null) {
      for (var addressPart in addresses!) {
        formData.fields.add(MapEntry('address', addressPart));
      }
    }

    if (utilities != null) {
      for (var utility in utilities!) {
        formData.fields.add(MapEntry('utilities', utility.toValue));
      }
    }

    formData.fields
      ..add(MapEntry('title', title ?? ''))
      ..add(MapEntry('description', description ?? ''))
      ..add(MapEntry('room_type', roomType!.name))
      ..add(MapEntry('owner', owner.toString()))
      ..add(MapEntry('capacity', capacity?.toString() ?? ''))
      ..add(MapEntry('gender', gender?.getNameGenderInt.toString() ?? ''))
      ..add(MapEntry('area', area?.toString() ?? ''))
      ..add(MapEntry('total_price', totalPrice?.toString() ?? ''))
      ..add(MapEntry('deposit', deposit?.toString() ?? ''))
      ..add(MapEntry('electricity_cost', electricityCost?.toString() ?? ''))
      ..add(MapEntry('water_cost', waterCost?.toString() ?? ''))
      ..add(MapEntry('internet_cost', internetCost?.toString() ?? ''))
      ..add(MapEntry('is_parking', isParking!.toString()))
      ..add(MapEntry('parking_fee', parkingFee?.toString() ?? ''))
      ..add(MapEntry('status', status?.toString() ?? ''))
      ..add(MapEntry('is_rent', isRent.toString()));

    return formData;
  }

  bool get hasData {
    final properties = [
      title,
      addresses,
      roomNumber,
      roomImages,
      utilities,
      description,
      roomType,
      owner,
      capacity,
      gender,
      area,
      totalPrice,
      deposit,
      electricityCost,
      waterCost,
      internetCost,
      isParking,
      parkingFee,
      status,
      isRent,
    ];

    return properties.any((property) => property != null);
  }

  RoomCreateModel copyWith({
    String? title,
    List<String>? addresses,
    int? roomNumber,
    List<String>? roomImages,
    List<Utilities>? utilities,
    String? description,
    RoomType? roomType,
    int? owner,
    int? capacity,
    Gender? gender,
    double? area,
    double? totalPrice,
    double? deposit,
    double? electricityCost,
    double? waterCost,
    double? internetCost,
    bool? isParking,
    double? parkingFee,
    int? status,
    bool? isRent,
  }) {
    return RoomCreateModel(
      title: title ?? this.title,
      addresses: addresses ?? this.addresses,
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
    );
  }

  @override
  String toString() {
    return 'RoomCreateModel(title: $title, addresses: $addresses, roomNumber: $roomNumber, roomImages: $roomImages, utilities: $utilities, description: $description, roomType: $roomType, owner: $owner, capacity: $capacity, gender: $gender, area: $area, totalPrice: $totalPrice, deposit: $deposit, electricityCost: $electricityCost, waterCost: $waterCost, internetCost: $internetCost, isParking: $isParking, parkingFee: $parkingFee, status: $status, isRent: $isRent)';
  }
}
