class ContractTemplateAddressRequest {
  final List<String> address;

  ContractTemplateAddressRequest({required this.address});

  Map<String, dynamic> toJson() {
    return {
      "address": address,
    };
  }
}
