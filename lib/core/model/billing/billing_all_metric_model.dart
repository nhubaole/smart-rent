// {
//   "actual_price": 1000,
//   "electricity_cost": 1,
//   "info": {
//       "address": "97, Đường số 11, phường Trường Thọ, quận Thủ Đức, TP HCM",
//       "month": 10,
//       "phone_number": "012345",
//       "room_number": 0,
//       "tenant_name": "khang1",
//       "year": 2024
//   },
//   "internet_cost": 20,
//   "new_electricity_index": 100,
//   "new_water_index": 12,
//   "old_electricity_index": 10,
//   "old_water_index": 10,
//   "parking_fee": 5,
//   "total_amount": 1135,
//   "water_cost": 10
// }

import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';

class BillingAllMetricModel {
  int? actualPrice;
  int? electricityCost;
  Info? info;
  int? internetCost;
  int? newElectricityIndex;
  int? newWaterIndex;
  int? oldElectricityIndex;
  int? oldWaterIndex;
  int? parkingFee;
  int? totalAmount;
  int? waterCost;

  BillingAllMetricModel(
      {this.actualPrice,
      this.electricityCost,
      this.info,
      this.internetCost,
      this.newElectricityIndex,
      this.newWaterIndex,
      this.oldElectricityIndex,
      this.oldWaterIndex,
      this.parkingFee,
      this.totalAmount,
      this.waterCost});

  factory BillingAllMetricModel.fromMap(Map<String, dynamic> json) {
    return BillingAllMetricModel(
      actualPrice: json['actual_price'] as int?,
      electricityCost: json['electricity_cost'] as int?,
      info: Info.fromMap(json['info'] as Map<String, dynamic>),
      internetCost: json['internet_cost'] as int?,
      newElectricityIndex: json['new_electricity_index'] as int?,
      newWaterIndex: json['new_water_index'] as int?,
      oldElectricityIndex: json['old_electricity_index'] as int?,
      oldWaterIndex: json['old_water_index'] as int?,
      parkingFee: json['parking_fee'] as int?,
      totalAmount: json['total_amount'] as int?,
      waterCost: json['water_cost'] as int?,
    );
  }
}
