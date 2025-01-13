// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//     "address_created": "Thành phố Hồ Chí Minh",
//     "date_created": 1734190056,
//     "deposit": 100,
//     "electric_cost": 1,
//     "end_date": 1704153600,
//     "general": "Follow local regulations",
//     "method": "cash",
//     "party_a": {
//         "cccd": "079304032010",
//         "dob": "2002-12-18 00:00:00 +0000 UTC",
//         "issue_by": "Cục cảnh sát quản lý hành chính và trật tự xã hội",
//         "issue_date": "06/09/2022",
//         "name": "là văn tã",
//         "phone": "0123456789",
//         "registered_place": "97 đường số 11, phường Trường Thọ, quận Thủ Đức, TP HCM"
//     },
//     "party_b": {
//         "cccd": "083405012453",
//         "dob": "2003-12-10 00:00:00 +0000 UTC",
//         "issue_by": "Cục cảnh sát quản lý hành chính và trật tự xã hội",
//         "issue_date": "12/10/2021",
//         "name": "khang1",
//         "phone": "012345",
//         "registered_place": "26 ấp Thị, xã Hương Mỹ, huyện Mỏ Cày Nam, tỉnh Bến Tre"
//     },
//     "responsibility_a": "Maintain property",
//     "responsibility_b": "Pay rent on time",
//     "room_address": [
//         "97",
//         "Đường số 11",
//         "phường Trường Thọ",
//         "quận Thủ Đức",
//         "TP HCM"
//     ],
//     "room_price": 1000,
//     "signature_a": "",
//     "signature_b": "",
//     "start_date": 1704153600,
//     "water_cost": 10
// }


import 'package:intl/intl.dart';

import 'package:smart_rent/core/enums/electricity_payment_method.dart';

class ContractByIdModel {
  int? id;
  String? addressCreated;
  DateTime? dateCreated;
  double? deposit;
  double? electricCost;
  DateTime? endDate;
  String? general;
  ElectricityPaymentMethod? method;
  PartyInfoModel? partyA;
  PartyInfoModel? partyB;
  String? responsibilityA;
  String? responsibilityB;
  List<String>? roomAddress;
  double? roomPrice;
  String? signatureA;
  String? signatureB;
  DateTime? startDate;
  double? waterCost;
  
  ContractByIdModel({
    this.addressCreated,
    this.dateCreated,
    this.deposit,
    this.electricCost,
    this.endDate,
    this.general,
    this.method,
    this.partyA,
    this.partyB,
    this.responsibilityA,
    this.responsibilityB,
    this.roomAddress,
    this.roomPrice,
    this.signatureA,
    this.signatureB,
    this.startDate,
    this.waterCost,
    this.id,
  });

  factory ContractByIdModel.fromMap(Map<String, dynamic> map) =>
      ContractByIdModel(
        id: map['id'] != null ? map['id'] as int : null,
        addressCreated: map['address_created'],
        dateCreated: map['date_created'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['date_created'] * 1000)
            : null,
        deposit: map['deposit'] != null ? map['deposit'] * 1.0 as double : null,
        electricCost: map['electric_cost'] != null
            ? map['electric_cost'] * 1.0 as double
            : null,
        endDate: map['end_date'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['end_date'] * 1000)
            : null,
        general: map['general'],
        method: map['method'] != null
            ? ElectricityPaymentMethodExtension.fromString(map['method'])
            : null,
        partyA: PartyInfoModel.fromMap(map['party_a']),
        partyB: PartyInfoModel.fromMap(map['party_b']),
        responsibilityA: map['responsibility_a'],
        responsibilityB: map['responsibility_b'],
        roomAddress: List<String>.from(map['room_address']),
        roomPrice: map['room_price'] != null
            ? map['room_price'] * 1.0 as double
            : null,
        signatureA: map['signature_a'],
        signatureB: map['signature_b'],
        startDate: map['start_date'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['start_date'] * 1000)
            : null,
        waterCost: map['water_cost'] != null
            ? map['water_cost'] * 1.0 as double
            : null,
      );

  ContractByIdModel copyWith({
    int? id,
    String? addressCreated,
    DateTime? dateCreated,
    double? deposit,
    double? electricCost,
    DateTime? endDate,
    String? general,
    ElectricityPaymentMethod? method,
    PartyInfoModel? partyA,
    PartyInfoModel? partyB,
    String? responsibilityA,
    String? responsibilityB,
    List<String>? roomAddress,
    double? roomPrice,
    String? signatureA,
    String? signatureB,
    DateTime? startDate,
    double? waterCost,
  }) {
    return ContractByIdModel(
      id: id ?? this.id,
      addressCreated: addressCreated ?? this.addressCreated,
      dateCreated: dateCreated ?? this.dateCreated,
      deposit: deposit ?? this.deposit,
      electricCost: electricCost ?? this.electricCost,
      endDate: endDate ?? this.endDate,
      general: general ?? this.general,
      method: method ?? this.method,
      partyA: partyA ?? this.partyA,
      partyB: partyB ?? this.partyB,
      responsibilityA: responsibilityA ?? this.responsibilityA,
      responsibilityB: responsibilityB ?? this.responsibilityB,
      roomAddress: roomAddress ?? this.roomAddress,
      roomPrice: roomPrice ?? this.roomPrice,
      signatureA: signatureA ?? this.signatureA,
      signatureB: signatureB ?? this.signatureB,
      startDate: startDate ?? this.startDate,
      waterCost: waterCost ?? this.waterCost,
    );
  }

  @override
  String toString() {
    return 'ContractByIdModel(id: $id, addressCreated: $addressCreated, dateCreated: $dateCreated, deposit: $deposit, electricCost: $electricCost, endDate: $endDate, general: $general, method: $method, partyA: $partyA, partyB: $partyB, responsibilityA: $responsibilityA, responsibilityB: $responsibilityB, roomAddress: $roomAddress, roomPrice: $roomPrice, signatureA: $signatureA, signatureB: $signatureB, startDate: $startDate, waterCost: $waterCost)';
  }
}

class PartyInfoModel {
  String? cccd;
  DateTime? dob;
  String? issueBy;
  DateTime? issueDate;
  String? name;
  String? phone;
  String? registeredPlace;

  PartyInfoModel({
    this.cccd,
    this.dob,
    this.issueBy,
    this.issueDate,
    this.name,
    this.phone,
    this.registeredPlace,
  });


  factory PartyInfoModel.fromMap(Map<String, dynamic> map) {
    final dateFormat = DateFormat('MM/dd/yyyy');
    return PartyInfoModel(
      cccd: map['cccd'],
      dob: DateTime.tryParse(map['dob'].replaceAll(' +0000 UTC', '')),
      issueBy: map['issue_by'],
      issueDate: map['issue_date'] != null
          ? dateFormat.parse(map['issue_date'])
          : null,
      name: map['name'],
      phone: map['phone'],
      registeredPlace: map['registered_place'],
    );
  }
  

}
