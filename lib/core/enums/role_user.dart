import 'package:get/get.dart';

enum RoleUser {
  landlord,
  tenant,
}

extension RoleUserExtension on RoleUser {
  String get name {
    switch (this) {
      case RoleUser.landlord:
        return 'landlord'.tr;
      case RoleUser.tenant:
        return 'tenant'.tr;
    }
  }

  String get value {
    switch (this) {
      case RoleUser.landlord:
        return 'landlord';
      case RoleUser.tenant:
        return 'tenant';
    }
  }

  static RoleUser getRoleUser(String value) {
    switch (value) {
      case 'landlord':
        return RoleUser.landlord;
      case 'tenant':
        return RoleUser.tenant;
      default:
        return RoleUser.tenant;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }
}
