import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PaymentMethod {
  no,
  cash,
  card,
  paypal,
  stripe,
  applePay,
  googlePay,
  samsungPay,
  other,
}

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.no:
        return 'cash'.tr;
      case PaymentMethod.cash:
        return 'cash'.tr;
      case PaymentMethod.card:
        return 'card'.tr;
      case PaymentMethod.paypal:
        return 'paypal'.tr;
      case PaymentMethod.stripe:
        return 'stripe'.tr;
      case PaymentMethod.applePay:
        return 'applePay'.tr;
      case PaymentMethod.googlePay:
        return 'googlePay'.tr;
      case PaymentMethod.samsungPay:
        return 'samsungPay'.tr;
      case PaymentMethod.other:
        return 'other'.tr;
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethod.no:
        return Icons.no_backpack;
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.paypal:
        return Icons.payment;
      case PaymentMethod.stripe:
        return Icons.payment;
      case PaymentMethod.applePay:
        return Icons.payment;
      case PaymentMethod.googlePay:
        return Icons.payment;
      case PaymentMethod.samsungPay:
        return Icons.payment;
      case PaymentMethod.other:
        return Icons.payment;
    }
  }
}
