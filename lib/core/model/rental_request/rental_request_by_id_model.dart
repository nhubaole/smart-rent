// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//   "id": 47,
//   "code": "YC854559",
//   "sender": {
//       "id": 76,
//       "phone_number": "0987654321",
//       "avatar_url": "https://smartrental.s3.ap-southeast-1.amazonaws.com/user-images/user_76/1736053807864.jpeg",
//       "role": 0,
//       "full_name": "Nguyễn Xuân Phương",
//       "address": "Quận 2",
//       "gender": 2,
//       "dob": null,
//       "wallet_address": "0xD79f89814d906FD927DCe8E6daf514aff3eF0C2D",
//       "private_key_hex": "7a69b01c52afccd661efd8d9b98b9a596168f8cb519627e3e5fba76d7c35076e",
//       "created_at": "2025-01-05T04:58:56.517627Z"
//   },
//   "room": {
//       "id": 155,
//       "title": "Căn Hộ Có Gác Đầy Đủ Nội Thất Từ A -> Z Gần Aeon Mall",
//       "address": [
//           "32",
//           "Đường Tân Quý",
//           "Phường Tân Quý",
//           "Quận Tân Phú",
//           "Thành phố Hồ Chí Minh"
//       ],
//       "room_number": 2,
//       "room_images": [
//           "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_155/1736006347783.jpg",
//           "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_155/1736006349150.jpg",
//           "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_155/1736006349662.jpg",
//           "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_155/1736006350197.jpg"
//       ],
//       "utilities": [
//           "WC riêng",
//           "Cửa sổ",
//           "Nhà bếp",
//           "Tự do",
//           "Thú cưng",
//           "An ninh"
//       ],
//       "description": "Căn hộ Q1 GẦN BITEXCO, Chợ bến thành, Phố đi bộ - Diện Tích từ 30m2- CỬA SỔ 4 CÁNH LỚN THOÁNG MÁT- KỆ BẾP LỚN- toilet riêg - ở đc 3-4 người - ( Cho thuê ngắn & dài hạn )\r\n💥KÍ HĐ 1 NĂM TRONG THÁNG 12💥\r\n🎄ƯU ĐÃI GIẢM NGAY 1.000.000 THÁNG ĐẦU 🎄\r\n\r\n✨ FREE GIỮ XE - FREE MÁY GIẶT 🧺\r\n✨ FREE WIFI - BẢO VỆ CAMERA 24/7\r\n🎁 THANG MÁY- bãi xe trong nhà- GIỜ GIẤC TỰ DO- gần siêu thị Vmart khu ăn uống. Hẻm xe hơi an ninh yên tĩnh",
//       "room_type": "Căn hộ",
//       "available_from": null,
//       "list_room_numbers": "{\"1\": 154, \"2\": 155}",
//       "owner": 1,
//       "capacity": 2,
//       "gender": 1,
//       "area": 0,
//       "total_price": 4000000,
//       "deposit": 0,
//       "electricity_cost": 0,
//       "water_cost": 0,
//       "internet_cost": 0,
//       "is_parking": false,
//       "parking_fee": 0,
//       "status": 0,
//       "is_rent": false,
//       "created_at": "2025-01-04T15:59:05.103007Z",
//       "updated_at": "2025-01-08T18:09:34.426908Z"
//   },
//   "suggested_price": 4500000,
//   "num_of_person": 1,
//   "begin_date": "2025-01-06T17:00:00Z",
//   "end_date": "2025-01-22T17:00:00Z",
//   "addition_request": "cho nuôi pet",
//   "status": 2,
//   "created_at": "2025-01-05T06:16:03.744627Z",
//   "updated_at": "2025-01-05T06:16:03.744627Z",
//   "deleted_at": null
// }
import 'dart:convert';

import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class RentalRequestByIdModel {
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

  RentalRequestByIdModel({
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

  factory RentalRequestByIdModel.fromMap(Map<String, dynamic> map) {
    return RentalRequestByIdModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      sender: map['sender'] != null
          ? UserModel.fromMap(map['sender'] as Map<String, dynamic>)
          : null,
      room: map['room'] != null
          ? RoomModel.fromMap(map['room'] as Map<String, dynamic>)
          : null,
      suggestedPrice:
          map['suggested_price'] != null ? map['suggested_price'] as int : null,
      numOfPerson:
          map['num_of_person'] != null ? map['num_of_person'] as int : null,
      beginDate: map['begin_date'] != null
          ? DateTime.tryParse(map['begin_date'])
          : null,
      endDate:
          map['end_date'] != null ? DateTime.tryParse(map['end_date']) : null,
      additionRequest: map['addition_request'] != null
          ? map['addition_request'] as String
          : null,
      status: map['status'] != null ? map['status'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
      deletedAt: map['deleted_at'] != null
          ? DateTime.tryParse(map['deleted_at'])
          : null,
    );
  }

  @override
  String toString() {
    return 'RentalRequestByIdModel(id: $id, code: $code, sender: $sender, room: $room, suggestedPrice: $suggestedPrice, numOfPerson: $numOfPerson, beginDate: $beginDate, endDate: $endDate, additionRequest: $additionRequest, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
