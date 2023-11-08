import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailTransactionController extends GetxController {
  RxString statusTransaction = 'success'.obs;
  var _momoPay;

  @override
  void onInit() {
    super.onInit();
  }

  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));

    Get.snackbar('Thông báo', 'Đã sao chép vào bộ nhớ tạm $textToCopy',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black);
  }

  void payment() {}
}
