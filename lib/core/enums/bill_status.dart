import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';

enum BillStatus {
  not_yet_created,
  pending,
  unpaid,
  paid,
  failed,
  cancelled,
  refunded,
  expired,
  unknown,
}

extension BillStatusExtension on BillStatus {
  String get value {
    switch (this) {
      case BillStatus.not_yet_created:
        return 'not yet created'.tr;
      case BillStatus.unpaid:
        return 'unpaid'.tr;
      case BillStatus.pending:
        return 'pending'.tr;
      case BillStatus.paid:
        return 'paid'.tr;
      case BillStatus.failed:
        return 'failed'.tr;
      case BillStatus.cancelled:
        return 'cancelled'.tr;
      case BillStatus.refunded:
        return 'refunded'.tr;
      case BillStatus.expired:
        return 'expired'.tr;
      case BillStatus.unknown:
        return 'unknown'.tr;
    }
  }

  static BillStatus fromString(String s) {
    return BillStatus.values.firstWhere(
      (status) => status.value == s,
      orElse: () => BillStatus.unknown,
    );
  }

  Color get colorContent {
    switch (this) {
      case BillStatus.not_yet_created:
        return AppColors.primary40;
      case BillStatus.unpaid:
        return AppColors.red70;
      case BillStatus.pending:
        return AppColors.secondary20;
      case BillStatus.paid:
        return Colors.green;
      case BillStatus.failed:
        return Colors.red;
      case BillStatus.cancelled:
        return Colors.red;
      case BillStatus.refunded:
        return Colors.red;
      case BillStatus.expired:
        return Colors.red;
      case BillStatus.unknown:
        return Colors.grey;
    }
  }
}
