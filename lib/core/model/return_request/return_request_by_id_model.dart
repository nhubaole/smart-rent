// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//         "id": 4,
//         "reason": "nha cui",
//         "contract_id": 17,
//         "room": {
//             "id": 125,
//             "title": "Test this room please",
//             "address": [
//                 "97",
//                 "Đường số 11",
//                 "phường Trường Thọ",
//                 "quận Thủ Đức",
//                 "TP HCM"
//             ],
//             "room_number": 101,
//             "room_images": [
//                 "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_125/1733052555789.png",
//                 "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_125/1733052555911.png"
//             ],
//             "utilities": [
//                 "WiFi",
//                 "Air Conditioning"
//             ],
//             "description": "A spacious room with modern amenities.",
//             "room_type": "single",
//             "available_from": null,
//             "list_room_numbers": "{\"0\": 139, \"101\": 138}",
//             "owner": 1,
//             "capacity": 2,
//             "gender": 1,
//             "area": 30,
//             "total_price": 1000,
//             "deposit": 100,
//             "electricity_cost": 0.5,
//             "water_cost": 0.3,
//             "internet_cost": 0.1,
//             "is_parking": true,
//             "parking_fee": 50,
//             "status": 1,
//             "is_rent": true,
//             "created_at": "2024-12-01T11:29:13.703378Z",
//             "updated_at": "2024-12-01T11:29:16.220779Z"
//         },
//         "return_date": "2024-01-02T15:04:05Z",
//         "status": 2,
//         "deduct_amount": 0,
//         "total_return_deposit": 2500,
//         "created_user": {
//             "id": 2,
//             "phone_number": "012345",
//             "avatar_url": null,
//             "role": 0,
//             "full_name": "khang1",
//             "address": "dia chi",
//             "gender": 1,
//             "dob": "2003-12-10",
//             "wallet_address": null,
//             "private_key_hex": null,
//             "created_at": "2024-09-09T08:51:33.839093Z"
//         },
//         "created_at": "2024-10-02T09:38:19.415701Z",
//         "updated_at": "2024-10-02T09:39:49.493601Z"
//     }

import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class ReturnRequestByIdModel {
  int? id;
  String? reason;
  int? contractId;
  RoomModel? room;
  DateTime? returnDate;
  int? status;
  double? deductAmount;
  double? totalReturnDeposit;
  UserModel? createdUser;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReturnRequestByIdModel({
    this.id,
    this.reason,
    this.contractId,
    this.room,
    this.returnDate,
    this.status,
    this.deductAmount,
    this.totalReturnDeposit,
    this.createdUser,
    this.createdAt,
    this.updatedAt,
  });

  factory ReturnRequestByIdModel.fromMap(Map<String, dynamic> map) {
    return ReturnRequestByIdModel(
      id: map['id'],
      reason: map['reason'],
      contractId: map['contract_id'],
      room: RoomModel.fromMap(map['room']),
      returnDate: map['return_date'] != null
          ? DateTime.parse(map['return_date'])
          : null,
      status: map['status'],
      deductAmount: map['deduct_amount'] * 1.0 as double,
      totalReturnDeposit: map['total_return_deposit'] * 1.0 as double,
      createdUser: UserModel.fromMap(map['created_user']),
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

}
