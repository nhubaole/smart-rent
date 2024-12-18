// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//   "id": 57,
//   "code": "YC693549",
//   "sender_id": 1,
//   "room_id": 161,
//   "suggested_price": 1500,
//   "num_of_person": 3,
//   "begin_date": "2006-01-02T22:04:05Z",
//   "end_date": "2006-01-02T22:04:05Z",
//   "addition_request": "Need extra bed and desk",
//   "status": 1,
//   "created_at": "2025-01-12T17:18:20.866499Z"
// }

class RentalRequestCreateResponseModel {
  int? id;
  String? code;
  int? senderId;
  int? roomId;
  double? suggestedPrice;
  int? numOfPerson;
  DateTime? beginDate;
  DateTime? endDate;
  String? additionRequest;
  int? status;
  DateTime? createdAt;

  RentalRequestCreateResponseModel({
    this.id,
    this.code,
    this.senderId,
    this.roomId,
    this.suggestedPrice,
    this.numOfPerson,
    this.beginDate,
    this.endDate,
    this.additionRequest,
    this.status,
    this.createdAt,
  });

  factory RentalRequestCreateResponseModel.fromMap(Map<String, dynamic> map) {
    return RentalRequestCreateResponseModel(
      id: map['id'],
      code: map['code'],
      senderId: map['sender_id'],
      roomId: map['room_id'],
      suggestedPrice:
          map['suggested_price'] != null ? map['suggested_price'] * 1.0 : null,
      numOfPerson: map['num_of_person'],
      beginDate:
          map['begin_date'] != null ? DateTime.parse(map['begin_date']) : null,
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      additionRequest: map['addition_request'],
      status: map['status'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
}
