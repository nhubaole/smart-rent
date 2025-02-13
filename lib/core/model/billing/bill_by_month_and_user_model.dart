// {
//   "address": "97, Đường số 11, phường Trường Thọ, quận Thủ Đức, TP HCM",
//   "list_bill": [
//       {
//           "avatar": null,
//           "created_at": "2024-09-27T15:03:09.293416+00:00",
//           "id": 3,
//           "payment_id": 6,
//           "room_number": 0,
//           "status": 1,
//           "tenant_name": null,
//           "total_amount": 1000
//       }
//   ]
// }

import 'package:smart_rent/core/values/image_assets.dart';

class BillByMonthAndUserModel {
  String? address;
  List<BillByMonthAndUserItemModel>? listBill;

  BillByMonthAndUserModel({this.address, this.listBill});

  factory BillByMonthAndUserModel.fromMap(Map<String, dynamic> json) {
    return BillByMonthAndUserModel(
      address: json['address'] != null ? json['address'] as String : null,
      listBill: json['list_bill'] != null
          ? (json['list_bill'] as List)
              .map((i) => BillByMonthAndUserItemModel.fromMap(i))
              .toList()
          : [],
    );
  }
}

class BillByMonthAndUserItemModel {
  String? avatar;
  DateTime? createdAt;
  int? id;
  int? paymentId;
  int? roomNumber;
  int? roomId;
  int? status;
  String? tenantName;
  int? totalAmount;

  BillByMonthAndUserItemModel(
      {this.avatar,
      this.createdAt,
      this.id,
      this.paymentId,
      this.roomNumber,
      this.roomId,
      this.status,
      this.tenantName,
      this.totalAmount});

  factory BillByMonthAndUserItemModel.fromMap(Map<String, dynamic> json) {
    return BillByMonthAndUserItemModel(
      avatar: json['avatar'] != null && (json['avatar'] as String).isNotEmpty
          ? json['avatar'] as String
          : ImageAssets.demo,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      id: json['id'] != null ? json['id'] as int : null,
      paymentId: json['payment_id'] != null ? json['payment_id'] as int : null,
      roomNumber:
          json['room_number'] != null ? json['room_number'] as int : null,
      status: json['status'] != null ? json['status'] as int : null,
      tenantName:
          json['tenant_name'] != null ? json['tenant_name'] as String : null,
      totalAmount:
          json['total_amount'] != null ? json['total_amount'] as int : null,
      roomId: json['room_id'] != null ? json['room_id'] as int : null,
    );
  }
}
