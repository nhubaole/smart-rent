import 'package:smart_rent/core/values/image_assets.dart';

enum NotificationType { RENTAL_REQUEST, RETURN_REQUEST, CONSTRACT, NULL }

extension NotificationTypeExtension on NotificationType {
  String get value {
    switch (this) {
      case NotificationType.RENTAL_REQUEST:
        return 'rental_request';
      case NotificationType.CONSTRACT:
        return 'contract';
      case NotificationType.RETURN_REQUEST:
        return 'return_request';
      case NotificationType.NULL:
        return 'null';
    }
  }

  String get name {
    switch (this) {
      case NotificationType.RENTAL_REQUEST:
        return 'Rental Request';
      case NotificationType.CONSTRACT:
        return 'Contract';
      case NotificationType.RETURN_REQUEST:
        return 'Return Request';
      case NotificationType.NULL:
        return 'Null';
    }
  }

  static NotificationType fromString(String? value) {
    switch (value) {
      case 'rental_request':
        return NotificationType.RENTAL_REQUEST;
      case 'return_request':
        return NotificationType.RETURN_REQUEST;
      case 'contract':
        return NotificationType.CONSTRACT;
      default:
        return NotificationType.NULL;
    }
  }

  String get icon {
    switch (this) {
      case NotificationType.RENTAL_REQUEST:
        return ImageAssets.lottieHamster;
      case NotificationType.CONSTRACT:
        return ImageAssets.lottiePayment;
      case NotificationType.RETURN_REQUEST:
        return ImageAssets.lottieBell;
      case NotificationType.NULL:
        return ImageAssets.lottieEmpty;
    }
  }
}
