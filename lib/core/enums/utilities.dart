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
  static Utilities fromString(String value) {
    switch (value) {
      case "WC":
        return Utilities.WC;
      case "WINDOW":
        return Utilities.WINDOW;
      case "WIFI":
        return Utilities.WIFI;
      case "KITCHEN":
        return Utilities.KITCHEN;
      case "LAUNDRY":
        return Utilities.LAUNDRY;
      case "FRIDGE":
        return Utilities.FRIDGE;
      case "PARKING":
        return Utilities.PARKING;
      case "SECURITY":
        return Utilities.SECURITY;
      case "FLEXIBLE_HOURS":
        return Utilities.FLEXIBLE_HOURS;
      case "PRIVATE":
        return Utilities.PRIVATE;
      case "LOFT":
        return Utilities.LOFT;
      case "PET":
        return Utilities.PET;
      case "BED":
        return Utilities.BED;
      case "WARDROBE":
        return Utilities.WARDROBE;
      case "AIR_CONDITIONER":
        return Utilities.AIR_CONDITIONER;
      default:
        return Utilities.WC;
    }
  }

  String get toValue {
    switch (this) {
      case Utilities.WC:
        return "WC";
      case Utilities.WINDOW:
        return "WINDOW";
      case Utilities.WIFI:
        return "WIFI";
      case Utilities.KITCHEN:
        return "KITCHEN";
      case Utilities.LAUNDRY:
        return "LAUNDRY";
      case Utilities.FRIDGE:
        return "FRIDGE";
      case Utilities.PARKING:
        return "PARKING";
      case Utilities.SECURITY:
        return "SECURITY";
      case Utilities.FLEXIBLE_HOURS:
        return "FLEXIBLE_HOURS";
      case Utilities.PRIVATE:
        return "PRIVATE";
      case Utilities.LOFT:
        return "LOFT";
      case Utilities.PET:
        return "PET";
      case Utilities.BED:
        return "BED";
      case Utilities.WARDROBE:
        return "WARDROBE";
      case Utilities.AIR_CONDITIONER:
        return "AIR_CONDITIONER";
      default:
        return "WC";
    }
  }



  String get getNameUtil {
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

  IconData get getIconUtil {
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
