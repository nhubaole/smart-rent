// {
//   "bank_name": "Ngân hàng TMCP Việt Nam Thịnh Vượng",
//   "account_name": "LE BAO NHU",
//   "account_number": "10823306992",
//   "amount": 1000,
//   "tranfer_content": "SR3645212",
//   "qr_url": "https://img.vietqr.io/image/VPB-10823306992-compact2.png?amount=1000&addInfo=SR3645212&accountName=LE+BAO+NHU"
// }

class PaymentDetailInfoModel {
  String? bankName;
  String? accountName;
  String? accountNumber;
  int? amount;
  String? tranferContent;
  String? qrUrl;

  PaymentDetailInfoModel(
      {this.bankName,
      this.accountName,
      this.accountNumber,
      this.amount,
      this.tranferContent,
      this.qrUrl});

  factory PaymentDetailInfoModel.fromMap(Map<String, dynamic> json) {
    return PaymentDetailInfoModel(
      bankName: json['bank_name'] != null ? json['bank_name'] as String : null,
      accountName:
          json['account_name'] != null ? json['account_name'] as String : null,
      accountNumber: json['account_number'] != null
          ? json['account_number'] as String
          : null,
      amount: json['amount'] != null ? json['amount'] as int : null,
      tranferContent: json['tranfer_content'] != null
          ? json['tranfer_content'] as String
          : null,
      qrUrl: json['qr_url'] != null ? json['qr_url'] as String : null,
    );
  }
}
