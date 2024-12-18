// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContractModel {
  int? iD;
  String? code;
  int? landlord;
  int? tenant;
  int? roomID;
  int? actualPrice;
  int? deposit;
  int? beginDate;
  int? endDate;
  String? paymentMethod;
  String? electricityMethod;
  int? electricityCost;
  String? waterMethod;
  int? waterCost;
  int? internetCost;
  int? parkingFee;
  String? responsibilityA;
  String? responsibilityB;
  String? generalResponsibility;
  String? signatureA;
  int? signedTimeA;
  String? signatureB;
  int? signedTimeB;
  int? contractTemplateID;
  int? preRentalStatus;
  int? rentalProcessStatus;
  int? postRentalStatus;
  int? createdAt;
  int? updatedAt;
  ContractModel({
    this.iD,
    this.code,
    this.landlord,
    this.tenant,
    this.roomID,
    this.actualPrice,
    this.deposit,
    this.beginDate,
    this.endDate,
    this.paymentMethod,
    this.electricityMethod,
    this.electricityCost,
    this.waterMethod,
    this.waterCost,
    this.internetCost,
    this.parkingFee,
    this.responsibilityA,
    this.responsibilityB,
    this.generalResponsibility,
    this.signatureA,
    this.signedTimeA,
    this.signatureB,
    this.signedTimeB,
    this.contractTemplateID,
    this.preRentalStatus,
    this.rentalProcessStatus,
    this.postRentalStatus,
    this.createdAt,
    this.updatedAt,
  });

  ContractModel copyWith({
    int? iD,
    String? code,
    int? landlord,
    int? tenant,
    int? roomID,
    int? actualPrice,
    int? deposit,
    int? beginDate,
    int? endDate,
    String? paymentMethod,
    String? electricityMethod,
    int? electricityCost,
    String? waterMethod,
    int? waterCost,
    int? internetCost,
    int? parkingFee,
    String? responsibilityA,
    String? responsibilityB,
    String? generalResponsibility,
    String? signatureA,
    int? signedTimeA,
    String? signatureB,
    int? signedTimeB,
    int? contractTemplateID,
    int? preRentalStatus,
    int? rentalProcessStatus,
    int? postRentalStatus,
    int? createdAt,
    int? updatedAt,
  }) {
    return ContractModel(
      iD: iD ?? this.iD,
      code: code ?? this.code,
      landlord: landlord ?? this.landlord,
      tenant: tenant ?? this.tenant,
      roomID: roomID ?? this.roomID,
      actualPrice: actualPrice ?? this.actualPrice,
      deposit: deposit ?? this.deposit,
      beginDate: beginDate ?? this.beginDate,
      endDate: endDate ?? this.endDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      electricityMethod: electricityMethod ?? this.electricityMethod,
      electricityCost: electricityCost ?? this.electricityCost,
      waterMethod: waterMethod ?? this.waterMethod,
      waterCost: waterCost ?? this.waterCost,
      internetCost: internetCost ?? this.internetCost,
      parkingFee: parkingFee ?? this.parkingFee,
      responsibilityA: responsibilityA ?? this.responsibilityA,
      responsibilityB: responsibilityB ?? this.responsibilityB,
      generalResponsibility:
          generalResponsibility ?? this.generalResponsibility,
      signatureA: signatureA ?? this.signatureA,
      signedTimeA: signedTimeA ?? this.signedTimeA,
      signatureB: signatureB ?? this.signatureB,
      signedTimeB: signedTimeB ?? this.signedTimeB,
      contractTemplateID: contractTemplateID ?? this.contractTemplateID,
      preRentalStatus: preRentalStatus ?? this.preRentalStatus,
      rentalProcessStatus: rentalProcessStatus ?? this.rentalProcessStatus,
      postRentalStatus: postRentalStatus ?? this.postRentalStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': iD,
      'Code': code,
      'Landlord': landlord,
      'Tenant': tenant,
      'RoomID': roomID,
      'ActualPrice': actualPrice,
      'Deposit': deposit,
      'BeginDate': beginDate,
      'EndDate': endDate,
      'PaymentMethod': paymentMethod,
      'ElectricityMethod': electricityMethod,
      'ElectricityCost': electricityCost,
      'WaterMethod': waterMethod,
      'WaterCost': waterCost,
      'InternetCost': internetCost,
      'ParkingFee': parkingFee,
      'ResponsibilityA': responsibilityA,
      'ResponsibilityB': responsibilityB,
      'GeneralResponsibility': generalResponsibility,
      'SignatureA': signatureA,
      'SignedTimeA': signedTimeA,
      'SignatureB': signatureB,
      'SignedTimeB': signedTimeB,
      'ContractTemplateID': contractTemplateID,
      'PreRentalStatus': preRentalStatus,
      'RentalProcessStatus': rentalProcessStatus,
      'PostRentalStatus': postRentalStatus,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel(
      iD: map['ID'] != null ? map['ID'] as int : null,
      code: map['Code'] != null ? map['Code'] as String : null,
      landlord: map['Landlord'] != null ? map['Landlord'] as int : null,
      tenant: map['Tenant'] != null ? map['Tenant'] as int : null,
      roomID: map['RoomID'] != null ? map['RoomID'] as int : null,
      actualPrice:
          map['ActualPrice'] != null ? map['ActualPrice'] as int : null,
      deposit: map['Deposit'] != null ? map['Deposit'] as int : null,
      beginDate: map['BeginDate'] != null ? map['BeginDate'] as int : null,
      endDate: map['EndDate'] != null ? map['EndDate'] as int : null,
      paymentMethod:
          map['PaymentMethod'] != null ? map['PaymentMethod'] as String : null,
      electricityMethod: map['ElectricityMethod'] != null
          ? map['ElectricityMethod'] as String
          : null,
      electricityCost:
          map['ElectricityCost'] != null ? map['ElectricityCost'] as int : null,
      waterMethod:
          map['WaterMethod'] != null ? map['WaterMethod'] as String : null,
      waterCost: map['WaterCost'] != null ? map['WaterCost'] as int : null,
      internetCost:
          map['InternetCost'] != null ? map['InternetCost'] as int : null,
      parkingFee: map['ParkingFee'] != null ? map['ParkingFee'] as int : null,
      responsibilityA: map['ResponsibilityA'] != null
          ? map['ResponsibilityA'] as String
          : null,
      responsibilityB: map['ResponsibilityB'] != null
          ? map['ResponsibilityB'] as String
          : null,
      generalResponsibility: map['GeneralResponsibility'] != null
          ? map['GeneralResponsibility'] as String
          : null,
      signatureA:
          map['SignatureA'] != null ? map['SignatureA'] as String : null,
      signedTimeA:
          map['SignedTimeA'] != null ? map['SignedTimeA'] as int : null,
      signatureB:
          map['SignatureB'] != null ? map['SignatureB'] as String : null,
      signedTimeB:
          map['SignedTimeB'] != null ? map['SignedTimeB'] as int : null,
      contractTemplateID: map['ContractTemplateID'] != null
          ? map['ContractTemplateID'] as int
          : null,
      preRentalStatus:
          map['PreRentalStatus'] != null ? map['PreRentalStatus'] as int : null,
      rentalProcessStatus: map['RentalProcessStatus'] != null
          ? map['RentalProcessStatus'] as int
          : null,
      postRentalStatus: map['PostRentalStatus'] != null
          ? map['PostRentalStatus'] as int
          : null,
      createdAt: map['CreatedAt'] != null ? map['CreatedAt'] as int : null,
      updatedAt: map['UpdatedAt'] != null ? map['UpdatedAt'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContractModel.fromJson(String source) =>
      ContractModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContractModel(iD: $iD, code: $code, landlord: $landlord, tenant: $tenant, roomID: $roomID, actualPrice: $actualPrice, deposit: $deposit, beginDate: $beginDate, endDate: $endDate, paymentMethod: $paymentMethod, electricityMethod: $electricityMethod, electricityCost: $electricityCost, waterMethod: $waterMethod, waterCost: $waterCost, internetCost: $internetCost, parkingFee: $parkingFee, responsibilityA: $responsibilityA, responsibilityB: $responsibilityB, generalResponsibility: $generalResponsibility, signatureA: $signatureA, signedTimeA: $signedTimeA, signatureB: $signatureB, signedTimeB: $signedTimeB, contractTemplateID: $contractTemplateID, preRentalStatus: $preRentalStatus, rentalProcessStatus: $rentalProcessStatus, postRentalStatus: $postRentalStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ContractModel other) {
    if (identical(this, other)) return true;

    return other.iD == iD &&
        other.code == code &&
        other.landlord == landlord &&
        other.tenant == tenant &&
        other.roomID == roomID &&
        other.actualPrice == actualPrice &&
        other.deposit == deposit &&
        other.beginDate == beginDate &&
        other.endDate == endDate &&
        other.paymentMethod == paymentMethod &&
        other.electricityMethod == electricityMethod &&
        other.electricityCost == electricityCost &&
        other.waterMethod == waterMethod &&
        other.waterCost == waterCost &&
        other.internetCost == internetCost &&
        other.parkingFee == parkingFee &&
        other.responsibilityA == responsibilityA &&
        other.responsibilityB == responsibilityB &&
        other.generalResponsibility == generalResponsibility &&
        other.signatureA == signatureA &&
        other.signedTimeA == signedTimeA &&
        other.signatureB == signatureB &&
        other.signedTimeB == signedTimeB &&
        other.contractTemplateID == contractTemplateID &&
        other.preRentalStatus == preRentalStatus &&
        other.rentalProcessStatus == rentalProcessStatus &&
        other.postRentalStatus == postRentalStatus &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return iD.hashCode ^
        code.hashCode ^
        landlord.hashCode ^
        tenant.hashCode ^
        roomID.hashCode ^
        actualPrice.hashCode ^
        deposit.hashCode ^
        beginDate.hashCode ^
        endDate.hashCode ^
        paymentMethod.hashCode ^
        electricityMethod.hashCode ^
        electricityCost.hashCode ^
        waterMethod.hashCode ^
        waterCost.hashCode ^
        internetCost.hashCode ^
        parkingFee.hashCode ^
        responsibilityA.hashCode ^
        responsibilityB.hashCode ^
        generalResponsibility.hashCode ^
        signatureA.hashCode ^
        signedTimeA.hashCode ^
        signatureB.hashCode ^
        signedTimeB.hashCode ^
        contractTemplateID.hashCode ^
        preRentalStatus.hashCode ^
        rentalProcessStatus.hashCode ^
        postRentalStatus.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
