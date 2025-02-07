import 'dart:convert';

class TemplateModel {
  final List<String> address;
  final int? id;
  final int? partyA;
  final String? electricityMethod;
  final int? electricityCost;
  final String? waterMethod;
  final int? waterCost;
  final int? internetCost;
  final int? parkingFee;
  final String? responsibilityA;
  final String? responsibilityB;
  final String? generalResponsibility;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  TemplateModel({
    required this.address,
    this.id,
    this.partyA,
    this.electricityMethod,
    this.electricityCost,
    this.waterMethod,
    this.waterCost,
    this.internetCost,
    this.parkingFee,
    this.responsibilityA,
    this.responsibilityB,
    this.generalResponsibility,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory TemplateModel.fromMap(Map<String, dynamic> map) {
    return TemplateModel(
      address: List<String>.from(map['address'] ?? []),
      id: map['id'],
      partyA: map['party_a'],
      electricityMethod: map['electricity_method'],
      electricityCost: map['electricity_cost'],
      waterMethod: map['water_method'],
      waterCost: map['water_cost'],
      internetCost: map['internet_cost'],
      parkingFee: map['parking_fee'],
      responsibilityA: map['responsibility_a'],
      responsibilityB: map['responsibility_b'],
      generalResponsibility: map['general_responsibility'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'id': id,
      'party_a': partyA,
      'electricity_method': electricityMethod,
      'electricity_cost': electricityCost,
      'water_method': waterMethod,
      'water_cost': waterCost,
      'internet_cost': internetCost,
      'parking_fee': parkingFee,
      'responsibility_a': responsibilityA,
      'responsibility_b': responsibilityB,
      'general_responsibility': generalResponsibility,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory TemplateModel.fromJson(String source) => TemplateModel.fromMap(json.decode(source));
}
