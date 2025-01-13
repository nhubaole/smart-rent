import 'dart:convert';

class Info {
  final String address;
  final int month;
  final String phone_number;
  final int room_number;
  final String tenant_name;
  final int year;
  Info({
    required this.address,
    required this.month,
    required this.phone_number,
    required this.room_number,
    required this.tenant_name,
    required this.year,
  });

  Info copyWith({
    String? address,
    int? month,
    String? phone_number,
    int? room_number,
    String? tenant_name,
    int? year,
  }) {
    return Info(
      address: address ?? this.address,
      month: month ?? this.month,
      phone_number: phone_number ?? this.phone_number,
      room_number: room_number ?? this.room_number,
      tenant_name: tenant_name ?? this.tenant_name,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'month': month,
      'phone_number': phone_number,
      'room_number': room_number,
      'tenant_name': tenant_name,
      'year': year,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      address: map['address'] as String,
      month: map['month'].toInt() as int,
      phone_number: map['phone_number'] as String,
      room_number: map['room_number'].toInt() as int,
      tenant_name: map['tenant_name'] as String,
      year: map['year'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Info(address: $address, month: $month, phone_number: $phone_number, room_number: $room_number, tenant_name: $tenant_name, year: $year)';
  }

  @override
  bool operator ==(covariant Info other) {
    if (identical(this, other)) return true;
  
    return 
      other.address == address &&
      other.month == month &&
      other.phone_number == phone_number &&
      other.room_number == room_number &&
      other.tenant_name == tenant_name &&
      other.year == year;
  }

  @override
  int get hashCode {
    return address.hashCode ^
      month.hashCode ^
      phone_number.hashCode ^
      room_number.hashCode ^
      tenant_name.hashCode ^
      year.hashCode;
  }
}