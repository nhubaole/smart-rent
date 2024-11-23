import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ElectricityPaymentMethod {
  noPaid,
  byMeter,
  byMonth,
  byPerson,
}

extension ElectricityPaymentMethodExtension on ElectricityPaymentMethod {
  String get name {
    switch (this) {
      case ElectricityPaymentMethod.noPaid:
        return 'no_collection'.tr;
      case ElectricityPaymentMethod.byMeter:
        return 'by_meter'.tr;
      case ElectricityPaymentMethod.byMonth:
        return 'by_month'.tr;
      case ElectricityPaymentMethod.byPerson:
        return 'by_person'.tr;
    }
  }

  IconData get icon {
    switch (this) {
      case ElectricityPaymentMethod.noPaid:
        return Icons.no_backpack;
      case ElectricityPaymentMethod.byMeter:
        return Icons.electrical_services;
      case ElectricityPaymentMethod.byMonth:
        return Icons.calendar_today;
      case ElectricityPaymentMethod.byPerson:
        return Icons.person;
    }
  }
}
