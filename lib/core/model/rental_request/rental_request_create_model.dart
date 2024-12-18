// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//     "room_id": 100,
//     "suggested_price": 1500.00,
//     "num_of_person": 3,
//     "begin_date": "2006-01-02T15:04:05-07:00",
//     "end_date": "2006-01-02T15:04:05-07:00",
//     "addition_request": "Need extra bed and desk"
// }

import 'dart:convert';

class RentalRequestCreateModel {
  int? roomID;
  double? suggestedPrice;
  int? numOfPerson;
  DateTime? beginDate;
  DateTime? endDate;
  String? additionRequest;

  RentalRequestCreateModel({
    this.roomID,
    this.suggestedPrice,
    this.numOfPerson,
    this.beginDate,
    this.endDate,
    this.additionRequest,
  });

  Map<String, dynamic> toMap() => {
        'room_id': roomID,
        'suggested_price': suggestedPrice,
        'num_of_person': numOfPerson,
        'begin_date': beginDate?.toUtc().toIso8601String(),
        'end_date': endDate?.toUtc().toIso8601String(),
        'addition_request': additionRequest,
      };

  String toJson() => json.encode(toMap());
}
