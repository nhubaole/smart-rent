import 'package:flutter/material.dart';

enum Utilities {
  WC,
  WINDOW,
  WIFI,
  KITCHEN,
  LAUNDRY,
  FRIDGE,
  PARKING,
  SECURITY,
  FLEXIBLE_HOURS,
  PRIVATE,
  LOFT,
  PET,
  BED,
  WARDROBE,
  AIR_CONDITIONER
}

extension InfoUtilities on Utilities {
  String getNameUtil() {
    switch (this) {
      case Utilities.WC:
        return "WC riêng";
      case Utilities.WINDOW:
        return "Cửa sổ";
      case Utilities.WIFI:
        return "Wifi";
      case Utilities.KITCHEN:
        return "Nhà bếp";
      case Utilities.LAUNDRY:
        return "Máy giặt";
      case Utilities.FRIDGE:
        return "Tủ lạnh";
      case Utilities.PARKING:
        return "Chỗ để xe";
      case Utilities.SECURITY:
        return "An ninh";
      case Utilities.FLEXIBLE_HOURS:
        return "Tự do";
      case Utilities.PRIVATE:
        return "Chủ riêng";
      case Utilities.LOFT:
        return "Gác lửng";
      case Utilities.PET:
        return "Thú cưng";
      case Utilities.BED:
        return "Giường";
      case Utilities.WARDROBE:
        return "Tủ đồ";
      case Utilities.AIR_CONDITIONER:
        return "Máy lạnh";
      default:
        return "";
    }
  }

  IconData getIconUtil() {
    switch (this) {
      case Utilities.WC:
        return Icons.bathtub_outlined;
      case Utilities.WINDOW:
        return Icons.width_full_outlined;
      case Utilities.WIFI:
        return Icons.wifi;
      case Utilities.KITCHEN:
        return Icons.countertops_outlined;
      case Utilities.LAUNDRY:
        return Icons.local_laundry_service_outlined;
      case Utilities.FRIDGE:
        return Icons.kitchen_outlined;
      case Utilities.PARKING:
        return Icons.two_wheeler_outlined;
      case Utilities.SECURITY:
        return Icons.security_outlined;
      case Utilities.FLEXIBLE_HOURS:
        return Icons.schedule_outlined;
      case Utilities.PRIVATE:
        return Icons.person_outline;
      case Utilities.LOFT:
        return Icons.foundation_outlined;
      case Utilities.PET:
        return Icons.pets_outlined;
      case Utilities.BED:
        return Icons.king_bed_outlined;
      case Utilities.WARDROBE:
        return Icons.door_sliding_outlined;
      case Utilities.AIR_CONDITIONER:
        return Icons.ac_unit_outlined;
      default:
        return Icons.disabled_by_default_outlined;
    }
  }
}
