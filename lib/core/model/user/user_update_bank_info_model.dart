// {
//     "bank_id": 47,
//     "account_number": "10823306992",
//     "card_number": "",
//     "account_name": "LE BAO NHU",
//     "currency": "VND"
// }

class UserUpdateBankInfoModel {
  int? bankId;
  String? accountNumber;
  String? cardNumber;
  String? accountName;
  String? currency;

  UserUpdateBankInfoModel({
    this.bankId,
    this.accountNumber,
    this.cardNumber,
    this.accountName,
    this.currency,
  });

  UserUpdateBankInfoModel copyWith({
    int? bankId,
    String? accountNumber,
    String? cardNumber,
    String? accountName,
    String? currency,
  }) {
    return UserUpdateBankInfoModel(
      bankId: bankId ?? this.bankId,
      accountNumber: accountNumber ?? this.accountNumber,
      cardNumber: cardNumber ?? this.cardNumber,
      accountName: accountName ?? this.accountName,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bank_id': bankId,
      'account_number': accountNumber,
      'card_number': cardNumber,
      'account_name': accountName,
      'currency': currency,
    };
  }
}
