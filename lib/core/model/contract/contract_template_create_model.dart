import 'dart:convert';

class ContractTemplateCreateModel {
  final int partyA;
  final List<String> address;
  final String electricityMethod;
  final double electricityCost;
  final String waterMethod;
  final double waterCost;
  final double internetCost;
  final double parkingFee;
  final String responsibilityA;
  final String responsibilityB;
  final String generalResponsibility;

  ContractTemplateCreateModel({
    required this.partyA,
    required this.address,
    required this.electricityMethod,
    required this.electricityCost,
    required this.waterMethod,
    required this.waterCost,
    required this.internetCost,
    required this.parkingFee,
    required this.responsibilityA,
    required this.responsibilityB,
    required this.generalResponsibility,
  });

  /// Chuyển đổi từ JSON thành `ContractTemplateCreateModel`
  factory ContractTemplateCreateModel.fromJson(Map<String, dynamic> json) {
    return ContractTemplateCreateModel(
      partyA: json['party_a'] as int,
      address: List<String>.from(json['address']),
      electricityMethod: json['electricity_method'] as String,
      electricityCost: (json['electricity_cost'] as num).toDouble(),
      waterMethod: json['water_method'] as String,
      waterCost: (json['water_cost'] as num).toDouble(),
      internetCost: (json['internet_cost'] as num).toDouble(),
      parkingFee: (json['parking_fee'] as num).toDouble(),
      responsibilityA: json['responsibility_a'] as String,
      responsibilityB: json['responsibility_b'] as String,
      generalResponsibility: json['general_responsibility'] as String,
    );
  }

  /// Chuyển đổi `ContractTemplateCreateModel` thành JSON để gửi API
  Map<String, dynamic> toJson() {
    return {
      'party_a': partyA,
      'address': address,
      'electricity_method': electricityMethod,
      'electricity_cost': electricityCost,
      'water_method': waterMethod,
      'water_cost': waterCost,
      'internet_cost': internetCost,
      'parking_fee': parkingFee,
      'responsibility_a': responsibilityA,
      'responsibility_b': responsibilityB,
      'general_responsibility': generalResponsibility,
    };
  }
}
