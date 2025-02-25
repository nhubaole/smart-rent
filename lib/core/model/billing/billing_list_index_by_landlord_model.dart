// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//   "address": "97, Đường số 11, phường Trường Thọ, quận Thủ Đức, TP HCM",
//   "index_info": [
//       {
//           "new_index": 100,
//           "old_index": 10,
//           "room_number": 0,
//           "used": 90
//       }
//   ],
//   "room_id": 100
// }

class BillingListIndexByLandlordModel {
  BillingListIndexByLandlordModel({
    this.address,
    this.indexInfo,
    this.roomId,
  });

  final String? address;
  final List<IndexInfo>? indexInfo;
  final int? roomId;

  factory BillingListIndexByLandlordModel.fromMap(Map<String, dynamic> json) =>
      BillingListIndexByLandlordModel(
        address: json['address'],
        indexInfo: json['index_info'] != null
            ? List<IndexInfo>.from(
                json['index_info'].map((x) => IndexInfo.fromMap(x)))
            : null,
        roomId: json['room_id'],
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'index_info': List<dynamic>.from(indexInfo!.map((x) => x.toMap())),
        'room_id': roomId,
      };
}

class IndexInfo {
  int? newIndex;
  int? oldIndex;
  int? roomNumber;
  int? used;
  int? roomId;


  IndexInfo({
    this.newIndex,
    this.oldIndex,
    this.roomNumber,
    this.used,
    this.roomId,
  });

  factory IndexInfo.fromMap(Map<String, dynamic> json) => IndexInfo(
        newIndex: json['new_index'],
        oldIndex: json['old_index'],
        roomNumber: json['room_number'],
        used: json['used'],
        roomId: json['room_id'],
      );

  Map<String, dynamic> toMap() => {
        'new_index': newIndex,
        'old_index': oldIndex,
        'room_number': roomNumber,
        'used': used,
        'room_id': roomId,
      };
}
