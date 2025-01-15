// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//     "contract_id": 24,
//     "reason": "",
//     "return_date": "2024-01-08T15:04:05-07:00"
// }

class ReturnRequestCreateTenantModel {
  int? contractId;
  String? reason;
  DateTime? returnDate;

  ReturnRequestCreateTenantModel({
    this.contractId,
    this.reason,
    this.returnDate,
  });

  factory ReturnRequestCreateTenantModel.fromJson(Map<String, dynamic> json) {
    return ReturnRequestCreateTenantModel(
      contractId: json['contract_id'],
      reason: json['reason'],
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contract_id'] = contractId;
    data['reason'] = reason;
    data['return_date'] = returnDate?.toUtc().toIso8601String();
    return data;
  }
}
