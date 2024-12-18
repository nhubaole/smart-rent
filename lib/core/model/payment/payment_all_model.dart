// {
//   "id": 9,
//   "code": "",
//   "sender_id": 1,
//   "bill_id": 4,
//   "contract_id": null,
//   "amount": 100,
//   "status": 1,
//   "return_request_id": null,
//   "transfer_content": "Payment for rent",
//   "evidence_image": "https://smartrental.s3.ap-southeast-1.amazonaws.com/evidence_image/payment/1733240552781.png",
//   "paid_time": "2024-12-03T15:42:33.035448Z"
// }

class PaymentAllModel {
  int? id;
  String? code;
  int? senderId;
  int? billId;
  int? contractId;
  double? amount;
  int? status;
  int? returnRequestId;
  String? transferContent;
  String? evidenceImage;
  DateTime? paidTime;

  PaymentAllModel({
    this.id,
    this.code,
    this.senderId,
    this.billId,
    this.contractId,
    this.amount,
    this.status,
    this.returnRequestId,
    this.transferContent,
    this.evidenceImage,
    this.paidTime,
  });

  PaymentAllModel copyWith({
    int? id,
    String? code,
    int? senderId,
    int? billId,
    int? contractId,
    double? amount,
    int? status,
    int? returnRequestId,
    String? transferContent,
    String? evidenceImage,
    DateTime? paidTime,
  }) {
    return PaymentAllModel(
      id: id ?? this.id,
      code: code ?? this.code,
      senderId: senderId ?? this.senderId,
      billId: billId ?? this.billId,
      contractId: contractId ?? this.contractId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      returnRequestId: returnRequestId ?? this.returnRequestId,
      transferContent: transferContent ?? this.transferContent,
      evidenceImage: evidenceImage ?? this.evidenceImage,
      paidTime: paidTime ?? this.paidTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'sender_id': senderId,
      'bill_id': billId,
      'contract_id': contractId,
      'amount': amount,
      'status': status,
      'return_request_id': returnRequestId,
      'transfer_content': transferContent,
      'evidence_image': evidenceImage,
      'paid_time': paidTime?.toIso8601String(),
    };
  }

  factory PaymentAllModel.fromMap(Map<String, dynamic> map) {
    return PaymentAllModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      senderId: map['sender_id'] != null ? map['sender_id'] as int : null,
      billId: map['bill_id'] != null ? map['bill_id'] as int : null,
      contractId: map['contract_id'] != null ? map['contract_id'] as int : null,
      amount: map['amount'] != null ? map['amount'] * 1.0 as double : null,
      status: map['status'] != null ? map['status'] as int : null,
      returnRequestId: map['return_request_id'] != null
          ? map['return_request_id'] as int
          : null,
      transferContent: map['transfer_content'] != null
          ? map['transfer_content'] as String
          : null,
      evidenceImage: map['evidence_image'] != null
          ? map['evidence_image'] as String
          : null,
      paidTime: map['paid_time'] != null
          ? DateTime.parse(map['paid_time'] as String)
          : null,
    );
  }
}
