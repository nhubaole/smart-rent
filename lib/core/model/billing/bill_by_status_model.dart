// {
//   "id": 3,
//   "code": "1234",
//   "address": [
//       "97",
//       "Đường số 11",
//       "phường Trường Thọ",
//       "quận Thủ Đức",
//       "TP HCM"
//   ],
//   "room_number": 0,
//   "contract_id": 16,
//   "addition_fee": 0,
//   "addition_note": null,
//   "total_amount": 1000,
//   "month": 10,
//   "year": 2023,
//   "old_water_index": 1,
//   "old_electricity_index": 2,
//   "new_water_index": 3,
//   "new_electricity_index": 4,
//   "total_water_cost": 200,
//   "total_electricity_cost": 450,
//   "status": 1,
//   "created_at": "2024-09-27T15:03:09.293416Z",
//   "updated_at": "2024-09-27T15:03:09.293416Z",
//   "deadline": "2024-10-07T15:03:09.293416Z"
// }

class BillByStatusModel {
  int? id;
  String? code;
  List<String>? address;
  int? roomNumber;
  int? contractId;
  int? additionFee;
  String? additionNote;
  int? totalAmount;
  int? month;
  int? year;
  int? oldWaterIndex;
  int? oldElectricityIndex;
  int? newWaterIndex;
  int? newElectricityIndex;
  int? totalWaterCost;
  int? totalElectricityCost;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deadline;

  BillByStatusModel(
      {this.id,
      this.code,
      this.address,
      this.roomNumber,
      this.contractId,
      this.additionFee,
      this.additionNote,
      this.totalAmount,
      this.month,
      this.year,
      this.oldWaterIndex,
      this.oldElectricityIndex,
      this.newWaterIndex,
      this.newElectricityIndex,
      this.totalWaterCost,
      this.totalElectricityCost,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deadline});

  factory BillByStatusModel.fromMap(Map<String, dynamic> json) {
    return BillByStatusModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      address:
          json['address'] != null ? List<String>.from(json['address']) : null,
      roomNumber: json['room_number'] as int?,
      contractId: json['contract_id'] as int?,
      additionFee: json['addition_fee'] as int?,
      additionNote: json['addition_note'] as String?,
      totalAmount: json['total_amount'] as int?,
      month: json['month'] as int?,
      year: json['year'] as int?,
      oldWaterIndex: json['old_water_index'] as int?,
      oldElectricityIndex: json['old_electricity_index'] as int?,
      newWaterIndex: json['new_water_index'] as int?,
      newElectricityIndex: json['new_electricity_index'] as int?,
      totalWaterCost: json['total_water_cost'] as int?,
      totalElectricityCost: json['total_electricity_cost'] as int?,
      status: json['status'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
    );
  }
}
