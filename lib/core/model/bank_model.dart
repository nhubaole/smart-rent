// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//             "id": 17,
//             "bank_name": "Ngân hàng TMCP Công thương Việt Nam",
//             "bank_code": "ICB",
//             "short_name": "VietinBank",
//             "logo": "https://api.vietqr.io/img/ICB.png",
//             "created_at": "2024-11-23T08:36:03.381977Z",
//             "updated_at": "2024-11-23T08:36:03.381977Z"
//         },

class BankModel {
  int? id;
  String? bankName;
  String? bankCode;
  String? shortName;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;

  BankModel({
    this.id,
    this.bankName,
    this.bankCode,
    this.shortName,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  factory BankModel.fromMap(Map<String, dynamic> map) => BankModel(
        id: map['id'] as int?,
        bankName: map['bank_name'] as String?,
        bankCode: map['bank_code'] as String?,
        shortName: map['short_name'] as String?,
        logo: map['logo'] as String?,
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'] as String)
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'] as String)
            : null,
      );

  @override
  String toString() {
    return 'BankModel(id: $id, bankName: $bankName, bankCode: $bankCode, shortName: $shortName, logo: $logo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
