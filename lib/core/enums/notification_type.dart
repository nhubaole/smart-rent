import 'package:smart_rent/core/values/image_assets.dart';

enum NotificationType {
  RENTAL_REQUEST,
  RETURN_REQUEST,
  CONTRACT,
  NULL,
  PAYMENT,
  BILL,
}

extension NotificationTypeExtension on NotificationType {
  String get value {
    switch (this) {
      case NotificationType.RENTAL_REQUEST:
        return 'rental_request';
      case NotificationType.CONTRACT:
        return 'contract';
      case NotificationType.RETURN_REQUEST:
        return 'return_request';
      case NotificationType.NULL:
        return 'null';
      case NotificationType.PAYMENT:
      case NotificationType.BILL:
        return 'payment';
    }
  }

  String get name {
    switch (this) {
      case NotificationType.RENTAL_REQUEST:
        return 'Rental Request';
      case NotificationType.CONTRACT:
        return 'Contract';
      case NotificationType.RETURN_REQUEST:
        return 'Return Request';
      case NotificationType.NULL:
        return 'Null';
      case NotificationType.PAYMENT:
      case NotificationType.BILL:
        return 'Payment';
    }
  }

  static NotificationType fromString(String? value) {
    switch (value) {
      case 'rental_request':
        return NotificationType.RENTAL_REQUEST;
      case 'return_request':
        return NotificationType.RETURN_REQUEST;
      case 'contract':
        return NotificationType.CONTRACT;
      case 'payment':
        return NotificationType.PAYMENT;
      default:
        return NotificationType.NULL;
    }
  }

  String get icon {
    switch (this) {
      case NotificationType.RENTAL_REQUEST:
        return ImageAssets.icRequestRentNoti;
      case NotificationType.CONTRACT:
        return ImageAssets.lottiePayment;
      case NotificationType.RETURN_REQUEST:
        return ImageAssets.lottieBell;
      case NotificationType.NULL:
        return ImageAssets.lottieEmpty;
      case NotificationType.PAYMENT:
      case NotificationType.BILL:
        return ImageAssets.lottiePayment;
    }
  }
}
