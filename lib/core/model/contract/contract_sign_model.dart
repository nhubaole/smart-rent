class ContractSignModel {
  final int contractID;
  final String signatureBase64;

  ContractSignModel({
    required this.contractID,
    required this.signatureBase64,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': contractID,
      'signature_b': signatureBase64,
    };
  }
}
