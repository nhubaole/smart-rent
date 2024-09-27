import 'dart:convert';

class UserModel {
  int? id;
  String? phoneNumber;
  String? fullName;
  String? password;
  String? address;
  int? role;
  String? createAt;
  String? deletedAt;
  UserModel({
    this.id,
    this.phoneNumber,
    this.fullName,
    this.password,
    this.address,
    this.role,
    this.createAt,
    this.deletedAt,
  });

  UserModel copyWith({
    int? id,
    String? phoneNumber,
    String? fullName,
    String? password,
    String? address,
    int? role,
    String? createAt,
    String? deletedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      address: address ?? this.address,
      role: role ?? this.role,
      createAt: createAt ?? this.createAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone_number': phoneNumber,
      'full_name': fullName,
      'password': password,
      'address': address,
      'role': role,
      'created_at': createAt,
      'deleted_at': deletedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      createAt: map['created_at'] != null ? map['created_at'] as String : null,
      deletedAt: map['deleted_at'] != null ? map['deleted_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, password: $password, address: $address, role: $role, createAt: $createAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.fullName == fullName &&
        other.password == password &&
        other.address == address &&
        other.role == role &&
        other.createAt == createAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phoneNumber.hashCode ^
        fullName.hashCode ^
        password.hashCode ^
        address.hashCode ^
        role.hashCode ^
        createAt.hashCode ^
        deletedAt.hashCode;
  }
}
