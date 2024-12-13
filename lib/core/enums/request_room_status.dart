import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';

enum RequestRoomStatus {
  pending,
  accepted,
  rejected,
  canceled,
  completed,
}

extension RequestRoomStatusExtension on RequestRoomStatus {
  String get value {
    switch (this) {
      case RequestRoomStatus.accepted:
        return 'accepted'.tr;
      case RequestRoomStatus.rejected:
        return 'rejected'.tr;
      case RequestRoomStatus.canceled:
        return 'canceled'.tr;
      case RequestRoomStatus.completed:
        return 'completed'.tr;
      case RequestRoomStatus.pending:
      default:
        return 'pending'.tr;
    }
  }

  IconData get icon {
    switch (this) {
      case RequestRoomStatus.accepted:
      case RequestRoomStatus.completed:
        return Icons.check;
      case RequestRoomStatus.rejected:
      case RequestRoomStatus.canceled:
        return Icons.close;
      case RequestRoomStatus.pending:
      default:
        return Icons.timer_outlined;
    }
  }

  Color get colorContent {
    switch (this) {
      case RequestRoomStatus.accepted:
      case RequestRoomStatus.completed:
        return AppColors.greenOrigin;
      case RequestRoomStatus.rejected:
      case RequestRoomStatus.canceled:
        return Colors.red;
      case RequestRoomStatus.pending:
      default:
        return AppColors.secondary40;
    }
  }

  Color get colorBackground {
    switch (this) {
      case RequestRoomStatus.accepted:
      case RequestRoomStatus.completed:
        return AppColors.successBackground;
      case RequestRoomStatus.rejected:
      case RequestRoomStatus.canceled:
        return AppColors.errorBackground;
      case RequestRoomStatus.pending:
      default:
        return AppColors.secondary90;
    }
  }
}
