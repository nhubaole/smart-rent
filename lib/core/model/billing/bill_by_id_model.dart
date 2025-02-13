// ignore_for_file: public_member_api_docs, sort_constructors_first
class BillByIdModel {
  int? additionFee;
  String? additionNote;
  String? code;
  DateTime? createdAt;
  int? electricityCost;
  int? id;
  Info? info;
  int? internetCost;
  int? newElectricityIndex;
  int? newWaterIndex;
  int? oldElectricityIndex;
  int? oldWaterIndex;
  DateTime? paidAt;
  int? parkingFee;
  int? roomPrice;
  int? status;
  int? totalAmount;
  int? waterCost;

  BillByIdModel({
    this.additionFee,
    this.additionNote,
    this.code,
    this.createdAt,
    this.electricityCost,
    this.id,
    this.info,
    this.internetCost,
    this.newElectricityIndex,
    this.newWaterIndex,
    this.oldElectricityIndex,
    this.oldWaterIndex,
    this.paidAt,
    this.parkingFee,
    this.roomPrice,
    this.status,
    this.totalAmount,
    this.waterCost,
  });

  factory BillByIdModel.fromJson(Map<String, dynamic> json) {
    return BillByIdModel(
      additionFee: json['addition_fee'],
      additionNote: json['addition_note'],
      code: json['code'],
      createdAt: json['created_at'],
      electricityCost: json['electricity_cost'],
      id: json['id'],
      info: Info.fromJson(json['info']),
      internetCost: json['internet_cost'],
      newElectricityIndex: json['new_electricity_index'],
      newWaterIndex: json['new_water_index'],
      oldElectricityIndex: json['old_electricity_index'],
      oldWaterIndex: json['old_water_index'],
      paidAt: DateTime.parse(json['paid_at']),
      parkingFee: json['parking_fee'],
      roomPrice: json['room_price'],
      status: json['status'],
      totalAmount: json['total_amount'],
      waterCost: json['water_cost'],
    );
  }

  factory BillByIdModel.fromMap(Map<String, dynamic> map) {
    return BillByIdModel(
      additionFee: map['addition_fee'] as int?,
      additionNote: map['addition_note'] as String?,
      code: map['code'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      electricityCost: map['electricity_cost'] as int?,
      id: map['id'] as int?,
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      internetCost: map['internet_cost'] as int?,
      newElectricityIndex: map['new_electricity_index'] as int?,
      newWaterIndex: map['new_water_index'] as int?,
      oldElectricityIndex: map['old_electricity_index'] as int?,
      oldWaterIndex: map['old_water_index'] as int?,
      paidAt: map['paid_at'] != null
          ? DateTime.parse(map['paid_at'] as String)
          : null,
      parkingFee: map['parking_fee'] as int?,
      roomPrice: map['room_price'] as int?,
      status: map['status'] as int?,
      totalAmount: map['total_amount'] as int?,
      waterCost: map['water_cost'] as int?,
    );
  }
}

class Info {
  String? address;
  int? month;
  String? phoneNumber;
  int? roomNumber;
  String? tenantName;
  int? year;

  Info(
      {this.address,
      this.month,
      this.phoneNumber,
      this.roomNumber,
      this.tenantName,
      this.year});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        address: json['address'],
        month: json['month'],
        phoneNumber: json['phone_number'],
        roomNumber: json['room_number'],
        tenantName: json['tenant_name'],
        year: json['year']);
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      address: map['address'] as String?,
      month: map['month'] as int?,
      phoneNumber: map['phone_number'] as String?,
      roomNumber: map['room_number'] as int?,
      tenantName: map['tenant_name'] as String?,
      year: map['year'] as int?,
    );
  }
}
