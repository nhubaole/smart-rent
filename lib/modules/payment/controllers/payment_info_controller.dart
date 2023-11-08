import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentInfoController extends GetxController {
  RxBool isChosenMethod = false.obs;
  RxInt selectedMethod = 1.obs;
  final scrollKey = GlobalKey();

  String getSelectedMethod() {
    switch (selectedMethod) {
      case 1:
        return 'Credit Card';
      case 2:
        return 'Mobile Payment';
      case 3:
        return 'Cash';
    }
    return 'Credit Card';
  }
}
