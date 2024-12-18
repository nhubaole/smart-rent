// {
//     "address": ["123 Main St","Ward 4","District 1","HCM City"],
//     "party_a": 1,
//     "party_b": 2,
//     "request_id": 35,
//     "room_id": 125,
//     "actual_price": 1000000,
//     "payment_method": "cash",
//     "electricity_method": "meter",
//     "electricity_cost": 1,
//     "water_method": "flat",
//     "water_cost": 10,
//     "internet_cost": 20,
//     "parking_fee": 5,
//     "deposit": 100,
//     "begin_date": "2024-01-02",
//     "end_date": "2024-01-02",
//     "responsibility_a": "Maintain property",
//     "responsibility_b": "Pay rent on time",
//     "general_responsibility": "Follow local regulations",
//     "signature_a": "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=",
//     "signed_time_a": "2024-01-02T15:04:05-07:00"
// }

import 'package:smart_rent/core/enums/electricity_payment_method.dart';
import 'package:smart_rent/core/enums/payment_method.dart';

class ContractCreateModel {
  List<String>? address;
  int? partyA;
  int? partyB;
  int? requestId;
  int? roomId;
  int? actualPrice;
  PaymentMethod? paymentMethod;
  ElectricityPaymentMethod? electricityMethod;
  int? electricityCost;
  String? waterMethod;
  int? waterCost;
  int? internetCost;
  int? parkingFee;
  int? deposit;
  DateTime? beginDate;
  DateTime? endDate;
  String? responsibilityA;
  String? responsibilityB;
  String? generalResponsibility;
  String? signatureA;
  DateTime? signedTimeA;

  ContractCreateModel({
    this.address,
    this.partyA,
    this.partyB,
    this.requestId,
    this.roomId,
    this.actualPrice,
    this.paymentMethod,
    this.electricityMethod,
    this.electricityCost,
    this.waterMethod,
    this.waterCost,
    this.internetCost,
    this.parkingFee,
    this.deposit,
    this.beginDate,
    this.endDate,
    this.responsibilityA,
    this.responsibilityB,
    this.generalResponsibility,
    this.signatureA,
    this.signedTimeA,
  });

  factory ContractCreateModel.fromJson(Map<String, dynamic> json) {
    return ContractCreateModel(
      address:
          json['address'] != null ? List<String>.from(json['address']) : null,
      partyA: json['party_a'],
      partyB: json['party_b'],
      requestId: json['request_id'],
      roomId: json['room_id'],
      actualPrice: json['actual_price'],
      paymentMethod: json['payment_method'],
      electricityMethod: json['electricity_method'],
      electricityCost: json['electricity_cost'],
      waterMethod: json['water_method'],
      waterCost: json['water_cost'],
      internetCost: json['internet_cost'],
      parkingFee: json['parking_fee'],
      deposit: json['deposit'],
      beginDate: json['begin_date'],
      endDate: json['end_date'],
      responsibilityA: json['responsibility_a'],
      responsibilityB: json['responsibility_b'],
      generalResponsibility: json['general_responsibility'],
      signatureA: json['signature_a'],
      signedTimeA: json['signed_time_a'],
    );
  }

  factory ContractCreateModel.fromMap(Map<String, dynamic> map) {
    return ContractCreateModel(
      address:
          map['address'] != null ? List<String>.from(map['address']) : null,
      partyA: map['party_a'],
      partyB: map['party_b'],
      requestId: map['request_id'],
      roomId: map['room_id'],
      actualPrice: map['actual_price'],
      paymentMethod: map['payment_method'] != null
          ? PaymentMethodExtension.fromString(map['payment_method'])
          : null,
      electricityMethod: map['electricity_method'] != null
          ? ElectricityPaymentMethodExtension.fromString(
              map['electricity_method'])
          : null,
      electricityCost: map['electricity_cost'],
      waterMethod: map['water_method'],
      waterCost: map['water_cost'],
      internetCost: map['internet_cost'],
      parkingFee: map['parking_fee'],
      deposit: map['deposit'],
      beginDate: map['begin_date'],
      endDate: map['end_date'],
      responsibilityA: map['responsibility_a'],
      responsibilityB: map['responsibility_b'],
      generalResponsibility: map['general_responsibility'],
      signatureA: map['signature_a'],
      signedTimeA: map['signed_time_a'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'party_a': partyA,
      'party_b': partyB,
      'request_id': requestId,
      'room_id': roomId,
      'actual_price': actualPrice,
      'payment_method': paymentMethod?.name,
      'electricity_method': electricityMethod?.name,
      'electricity_cost': electricityCost,
      'water_method': waterMethod,
      'water_cost': waterCost,
      'internet_cost': internetCost,
      'parking_fee': parkingFee,
      'deposit': deposit,
      'begin_date': beginDate,
      'end_date': endDate,
      'responsibility_a': responsibilityA,
      'responsibility_b': responsibilityB,
      'general_responsibility': generalResponsibility,
      'signature_a': signatureA,
      'signed_time_a': signedTimeA,
    };
  }
}
