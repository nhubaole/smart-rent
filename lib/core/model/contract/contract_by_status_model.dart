// ignore_for_file: public_member_api_docs, sort_constructors_first
// "code": "ABC123",
// "created_at": 1734190056,
// "expired_at": 1734794856,
// "id": 17,
// "landlord_name": "là văn tã",
// "room_address": "97, Đường số 11, phường Trường Thọ, quận Thủ Đức, TP HCM",
// "room_number": 101,
// "signature_time_a": 1704233045,
// "signature_time_b": 0,
// "tenant_name": "khang1"

class ContractByStatusModel {
  String? code;
  DateTime? createdAt;
  DateTime? expiredAt;
  int? id;
  String? landlordName;
  String? roomAddress;
  int? roomNumber;
  DateTime? signatureTimeA;
  DateTime? signatureTimeB;
  String? tenantName;

  ContractByStatusModel({
    this.code,
    this.createdAt,
    this.expiredAt,
    this.id,
    this.landlordName,
    this.roomAddress,
    this.roomNumber,
    this.signatureTimeA,
    this.signatureTimeB,
    this.tenantName,
  });

  factory ContractByStatusModel.fromJson(Map<String, dynamic> json) {
    return ContractByStatusModel(
      code: json['code'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
      expiredAt: DateTime.fromMillisecondsSinceEpoch(json['expired_at'] * 1000),
      id: json['id'],
      landlordName: json['landlord_name'],
      roomAddress: json['room_address'],
      roomNumber: json['room_number'],
      signatureTimeA:
          DateTime.fromMillisecondsSinceEpoch(json['signature_time_a'] * 1000),
      signatureTimeB:
          DateTime.fromMillisecondsSinceEpoch(json['signature_time_b'] * 1000),
      tenantName: json['tenant_name'],
    );
  }

  factory ContractByStatusModel.fromMap(Map<String, dynamic> map) {
    return ContractByStatusModel(
      code: map['code'] != null ? map['code'] as String : null,
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] * 1000)
          : null,
      expiredAt: map['expired_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expired_at'] * 1000)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      landlordName:
          map['landlord_name'] != null ? map['landlord_name'] as String : null,
      roomAddress:
          map['room_address'] != null ? map['room_address'] as String : null,
      roomNumber: map['room_number'] != null ? map['room_number'] as int : null,
      signatureTimeA: map['signature_time_a'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['signature_time_a'] * 1000)
          : null,
      signatureTimeB: map['signature_time_a'] != null &&
              map['signature_time_b'] != 0
          ? DateTime.fromMillisecondsSinceEpoch(map['signature_time_a'] * 1000)
          : null,
      tenantName:
          map['tenant_name'] != null ? map['tenant_name'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ContractByStatusModel(code: $code, createdAt: $createdAt, expiredAt: $expiredAt, id: $id, landlordName: $landlordName, roomAddress: $roomAddress, roomNumber: $roomNumber, signatureTimeA: $signatureTimeA, signatureTimeB: $signatureTimeB, tenantName: $tenantName)';
  }
}
