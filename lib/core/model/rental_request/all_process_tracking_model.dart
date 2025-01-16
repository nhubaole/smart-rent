// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//             "id": 61,
//             "code": "YC864505",
//             "sender": {
//                 "id": 0,
//                 "phone_number": "",
//                 "avatar_url": null,
//                 "role": 0,
//                 "full_name": "",
//                 "address": null,
//                 "gender": null,
//                 "dob": null,
//                 "wallet_address": null,
//                 "private_key_hex": null,
//                 "created_at": null
//             },
//             "room": {
//                 "id": 163,
//                 "title": "Phòng Thủ Đức giá rẻ",
//                 "address": [
//                     "43",
//                     "Cây Keo",
//                     "Phường Tam Bình",
//                     "Quận Thủ Đức",
//                     "Thành phố Hồ Chí Minh"
//                 ],
//                 "room_number": 10,
//                 "room_images": [
//                     "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_163/1736776902247.jpg",
//                     "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_163/1736776902368.jpg",
//                     "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_163/1736776902461.jpg",
//                     "https://smartrental.s3.ap-southeast-1.amazonaws.com/room-images/room_163/1736776902486.jpg"
//                 ],
//                 "utilities": [
//                     "An ninh",
//                     "Thú cưng",
//                     "Cửa sổ"
//                 ],
//                 "description": "Mô tả",
//                 "room_type": "Phòng cho thuê",
//                 "available_from": null,
//                 "list_room_numbers": "{\"10\": 163}",
//                 "owner": 1,
//                 "capacity": 2,
//                 "gender": 2,
//                 "area": 100,
//                 "total_price": 4000000,
//                 "deposit": 4000000,
//                 "electricity_cost": 10,
//                 "water_cost": 20,
//                 "internet_cost": 0,
//                 "is_parking": true,
//                 "parking_fee": 0,
//                 "status": 0,
//                 "is_rent": false,
//                 "created_at": "2025-01-13T14:01:40.539196Z",
//                 "updated_at": "2025-01-15T17:07:04.517673Z"
//             },
//             "suggested_price": 3500000,
//             "num_of_person": 2,
//             "begin_date": "2025-01-13T17:00:00Z",
//             "end_date": "2026-01-01T17:00:00Z",
//             "addition_request": null,
//             "status": 0,
//             "created_at": "2025-01-13T14:03:00.056313Z",
//             "updated_at": null,
//             "deleted_at": null
//         },
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class AllProcessTrackingModel {
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

  AllProcessTrackingModel({
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

  factory AllProcessTrackingModel.fromMap(Map<String, dynamic> json) {
    return AllProcessTrackingModel(
      id: json['id'],
      code: json['code'],
      sender: json['sender'] != null ? UserModel.fromMap(json['sender']) : null,
      room: json['room'] != null ? RoomModel.fromMap(json['room']) : null,
      suggestedPrice: json['suggested_price'],
      numOfPerson: json['num_of_person'],
      beginDate: json['begin_date'] != null
          ? DateTime.parse(json['begin_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      additionRequest: json['addition_request'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}
