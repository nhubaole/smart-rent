// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//   "request_count": 2,
//   "request_info": [
//       {
//           "avatar": "https://smartrental.s3.ap-southeast-1.amazonaws.com/user-images/user_76/1736053807864.jpeg",
//           "created_at": "2025-01-05T06:16:03.744627+00:00",
//           "id": 47,
//           "name": "Nguyễn Xuân Phương",
//           "status": 2
//       },
//       {
//           "avatar": "https://smartrental.s3.ap-southeast-1.amazonaws.com/user-images/user_76/1736053807864.jpeg",
//           "created_at": "2025-01-05T05:47:39.569143+00:00",
//           "id": 45,
//           "name": "Nguyễn Xuân Phương",
//           "status": 3
//       }
//   ],
//   "room": {
//       "address": [
//           "32",
//           "Đường Tân Quý",
//           "Phường Tân Quý",
//           "Quận Tân Phú",
//           "Thành phố Hồ Chí Minh"
//       ],
//       "id": 155,
//       "price": 4000000,
//       "title": "Căn Hộ Có Gác Đầy Đủ Nội Thất Từ A -> Z Gần Aeon Mall"
//   }
// }

import 'package:smart_rent/core/model/room/room_model.dart';

class RentalRequestAllModel {
  int? requestCount;
  List<RequestInfo>? requestInfo;
  RoomModel? room;
  RentalRequestAllModel({
    this.requestCount,
    this.requestInfo,
    this.room,
  });

  factory RentalRequestAllModel.fromMap(Map<String, dynamic> map) =>
      RentalRequestAllModel(
        requestCount: map['request_count'],
        requestInfo: List<RequestInfo>.from(
          (map['request_info'] as List)
              .map((e) => RequestInfo.fromMap(e))
              .toList(),
        ),
        room: RoomModel.fromMap(map['room']),
      );
}

class RequestInfo {
  String? avatar;
  DateTime? createdAt;
  int? id;
  String? name;
  int? status;

  RequestInfo({
    this.avatar,
    this.createdAt,
    this.id,
    this.name,
    this.status,
  });

  factory RequestInfo.fromMap(Map<String, dynamic> map) => RequestInfo(
        avatar: map['avatar'],
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'])
            : null,
        id: map['id'],
        name: map['name'],
        status: map['status'],
      );
    
}
