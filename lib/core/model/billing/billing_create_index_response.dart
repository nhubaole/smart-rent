// {
//         "id": 9,
//         "water_index": 20,
//         "electricity_index": 10,
//         "room_id": 125,
//         "month": 11,
//         "year": 2024
//     }

class BillingCreateIndexResponse {
  int? id;
  int? waterIndex;
  int? electricityIndex;
  int? roomId;
  int? month;
  int? year;

  BillingCreateIndexResponse({
    this.id,
    this.waterIndex,
    this.electricityIndex,
    this.roomId,
    this.month,
    this.year,
  });

  factory BillingCreateIndexResponse.fromMap(Map<String, dynamic> map) {
    return BillingCreateIndexResponse(
      id: map['id'],
      waterIndex: map['water_index'],
      electricityIndex: map['electricity_index'],
      roomId: map['room_id'],
      month: map['month'],
      year: map['year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'water_index': waterIndex,
      'electricity_index': electricityIndex,
      'room_id': roomId,
      'month': month,
      'year': year,
    };
  }
}
