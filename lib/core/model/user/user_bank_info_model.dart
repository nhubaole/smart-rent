// {
//         "user_id": 1,
//         "bank_id": 43,
//         "bank_name": "Ngân hàng TMCP Ngoại Thương Việt Nam",
//         "short_name": "Vietcombank",
//         "account_number": "13565",
//         "account_name": "sbb đg",
//         "card_number": "",
//         "currency": "VND",
//         "created_at": "2024-11-21T11:16:58.716619Z",
//         "updated_at": "2025-01-01T11:02:17.15292Z"
//     }

class UserBankInfoModel {
  int? userId;
  int? bankId;
  String? bankName;
  String? shortName;
  String? accountNumber;
  String? accountName;
  String? cardNumber;
  String? currency;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserBankInfoModel({
    this.userId,
    this.bankId,
    this.bankName,
    this.shortName,
    this.accountNumber,
    this.accountName,
    this.cardNumber,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  UserBankInfoModel copyWith({
    int? userId,
    int? bankId,
    String? bankName,
    String? shortName,
    String? accountNumber,
    String? accountName,
    String? cardNumber,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserBankInfoModel(
      userId: userId ?? this.userId,
      bankId: bankId ?? this.bankId,
      bankName: bankName ?? this.bankName,
      shortName: shortName ?? this.shortName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      cardNumber: cardNumber ?? this.cardNumber,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserBankInfoModel.fromMap(Map<String, dynamic> map) {
    return UserBankInfoModel(
      userId: map['user_id'] as int,
      bankId: map['bank_id'] as int,
      bankName: map['bank_name'] as String,
      shortName: map['short_name'] as String,
      accountNumber: map['account_number'] as String,
      accountName: map['account_name'] as String,
      cardNumber: map['card_number'] as String,
      currency: map['currency'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'bank_id': bankId,
      'bank_name': bankName,
      'short_name': shortName,
      'account_number': accountNumber,
      'account_name': accountName,
      'card_number': cardNumber,
      'currency': currency,
      'created_at': createdAt?.microsecondsSinceEpoch,
      'updated_at': updatedAt?.microsecondsSinceEpoch,
    };
  }
}
