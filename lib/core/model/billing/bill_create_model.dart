// {
//     "room_id": 154,
//     "month": 1,
//     "year": 2025,
//     "addition_fee": 1,
//     "addition_note": ""
// }

import 'dart:convert';

class BillCreateModel {
  int? roomId;
  int? month;
  int? year;
  int? additionFee;
  String? additionNote;

  BillCreateModel({
    this.roomId,
    this.month,
    this.year,
    this.additionFee,
    this.additionNote,
  });

  Map<String, dynamic> toMap() {
    return {
      'room_id': roomId,
      'month': month,
      'year': year,
      'addition_fee': additionFee,
      'addition_note': additionNote,
    };
  }

  String toJson() => json.encode(toMap());
}
