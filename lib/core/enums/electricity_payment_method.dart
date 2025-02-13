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

  String get value {
    switch (this) {
      case ElectricityPaymentMethod.noPaid:
        return 'no_collection';
      case ElectricityPaymentMethod.byMeter:
        return 'by_meter';
      case ElectricityPaymentMethod.byMonth:
        return 'by_month';
      case ElectricityPaymentMethod.byPerson:
        return 'by_person';
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

static ElectricityPaymentMethod fromString(String value) {
    switch (value) {
      case 'no_collection':
        return ElectricityPaymentMethod.noPaid;
      case 'by_meter':
      case 'meter':
        return ElectricityPaymentMethod.byMeter;
      case 'by_month':
      case 'month':
        return ElectricityPaymentMethod.byMonth;
      case 'by_person':
      case 'person':
        return ElectricityPaymentMethod.byPerson;
      default:
        return ElectricityPaymentMethod.noPaid;
    }
  }
}
