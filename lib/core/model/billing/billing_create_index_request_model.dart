// {
//     "water_index": 20,
//     // "electricity_index": 10, --optional
//     "room_id": 125,
//     "month": 11,
//     "year": 2024
// }

class BillingCreateIndexRequestModel {
  int? waterIndex;
  int? electricityIndex;
  int? roomId;
  int? month;
  int? year;

  BillingCreateIndexRequestModel({
    this.waterIndex,
    this.electricityIndex,
    this.roomId,
    this.month,
    this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'water_index': waterIndex,
      'electricity_index': electricityIndex,
      'room_id': roomId,
      'month': month,
      'year': year,
    };
  }
}
