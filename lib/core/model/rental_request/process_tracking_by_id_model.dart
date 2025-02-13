// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//             "id": 65,
//             "actor": {
//                 "id": 76,
//                 "phone_number": "0987654321",
//                 "avatar_url": "https://smartrental.s3.ap-southeast-1.amazonaws.com/user-images/user_76/1736053807864.jpeg",
//                 "role": 0,
//                 "full_name": "Nguyễn Xuân Phương",
//                 "address": "Quận 2",
//                 "gender": 2,
//                 "dob": null,
//                 "wallet_address": "0xD79f89814d906FD927DCe8E6daf514aff3eF0C2D",
//                 "private_key_hex": "7a69b01c52afccd661efd8d9b98b9a596168f8cb519627e3e5fba76d7c35076e",
//                 "created_at": "2025-01-05T04:58:56.517627Z"
//             },
//             "action": "Người thuê tạo yêu cầu thuê phòng thành công",
//             "issued_at": "2025-01-13T14:03:00.060146Z",
//             "request_id": 61
//         },

import 'package:smart_rent/core/model/user/user_model.dart';

class ProcessTrackingByIdModel {
  int? id;
  UserModel? actor;
  String? action;
  DateTime? issuedAt;
  int? requestId;

  ProcessTrackingByIdModel({
    this.id,
    this.actor,
    this.action,
    this.issuedAt,
    this.requestId,
  });

  factory ProcessTrackingByIdModel.fromMap(Map<String, dynamic> map) {
    return ProcessTrackingByIdModel(
      id: map['id'],
      actor: UserModel.fromMap(map['actor']),
      action: map['action'],
      issuedAt:
          map['issued_at'] != null ? DateTime.parse(map['issued_at']) : null,
      requestId: map['request_id'],
    );
  }
}
