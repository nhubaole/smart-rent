// {
//     "id": 37,
//     "code": "0025",
//     "sender": {
//         "id": 1,
//         "phone_number": "0123456789",
//         "avatar_url": "https://smartrental.s3.ap-southeast-1.amazonaws.com/user-images/user_1/1734768756230.jpg",
//         "role": 1,
//         "full_name": "là văn tã",
//         "address": "Quận 1",
//         "wallet_address": "0xae4228c40e0409E0fD61af9d41906ABE30072964",
//         "private_key_hex": "2da01a1b767463db18eabaf32a93bf8b0b8816e2b01a68e0c8e5e3baac2f2e61",
//         "created_at": "2024-09-06T14:21:03.964884Z"
//     },
//     "room": {
//         "id": 48,
//         "title": "Mia Home stay",
//         "address": [
//             "97",
//             "Đường số 11",
//             "phường Trường Thọ",
//             "quận Thủ Đức",
//             "TP HCM"
//         ],
//         "room_number": 0,
//         "room_images": [
//             "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/test/1727618511805.png",
//             "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/test/1727618511847.png",
//             "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/test/1727618511871.png",
//             "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/test/1727618511897.jpg",
//             "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/test/1727618511942.png"
//         ],
//         "utilities": [
//             "WiFi",
//             "Air Conditioning"
//         ],
//         "description": "Phòng đẹp, sạch sẽ, thoải mái, tiện nghi",
//         "room_type": "single",
//         "available_from": null,
//         "list_room_numbers": "{\"0\": 48, \"101\": 125}",
//         "owner": 1,
//         "capacity": 2,
//         "gender": 1,
//         "area": 25,
//         "total_price": 3000000,
//         "deposit": 1000000,
//         "electricity_cost": 12,
//         "water_cost": 3,
//         "internet_cost": 0,
//         "is_parking": false,
//         "parking_fee": 50,
//         "status": 0,
//         "is_rent": false,
//         "created_at": "2024-09-29T14:01:51.96323Z",
//         "updated_at": "2024-10-02T09:39:49.668355Z"
//     },
//     "suggested_price": 2000000,
//     "num_of_person": 0,
//     "begin_date": "2024-11-10T17:00:00Z",
//     "end_date": "2024-11-20T17:00:00Z",
//     "addition_request": "có máy lạnh",
//     "status": 1,
//     "created_at": "2024-11-11T10:04:38.388817Z",
//     "updated_at": "2024-11-11T10:04:38.388817Z",
//     "deleted_at": null
// }

import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class RentalRequestAllModel {
  int? id;
  String? code;
  UserModel? sender;
  RoomModel? room;
  int? suggestedPrice;
  int? numOfPerson;
  DateTime? beginDate;
  DateTime? endDate;
  String? additionRequest;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  RentalRequestAllModel({
    this.id,
    this.code,
    this.sender,
    this.room,
    this.suggestedPrice,
    this.numOfPerson,
    this.beginDate,
    this.endDate,
    this.additionRequest,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  RentalRequestAllModel copyWith({
    int? id,
    String? code,
    UserModel? sender,
    RoomModel? room,
    int? suggestedPrice,
    int? numOfPerson,
    DateTime? beginDate,
    DateTime? endDate,
    String? additionRequest,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return RentalRequestAllModel(
      id: id ?? this.id,
      code: code ?? this.code,
      sender: sender ?? this.sender,
      room: room ?? this.room,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
      numOfPerson: numOfPerson ?? this.numOfPerson,
      beginDate: beginDate ?? this.beginDate,
      endDate: endDate ?? this.endDate,
      additionRequest: additionRequest ?? this.additionRequest,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory RentalRequestAllModel.fromMap(Map<String, dynamic> map) {
    return RentalRequestAllModel(
      id: map['id'],
      code: map['code'],
      sender: UserModel.fromMap(map['sender']),
      room: RoomModel.fromMap(map['room']),
      suggestedPrice: map['suggested_price'],
      numOfPerson: map['num_of_person'],
      beginDate:
          map['begin_date'] != null ? DateTime.parse(map['begin_date']) : null,
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      additionRequest: map['addition_request'],
      status: map['status'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      deletedAt:
          map['deleted_at'] != null ? DateTime.parse(map['deleted_at']) : null,
    );
  }
}
