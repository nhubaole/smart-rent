import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';

class ContractSignController extends GetxController {
  late SignatureController signatureController;
  @override
  void onInit() {
    signatureController = SignatureController(
      penStrokeWidth: 1,
      penColor: Colors.black,
      exportBackgroundColor: Colors.transparent,
      exportPenColor: Colors.black,
      onDrawStart: () => log('onDrawStart called!'),
      onDrawEnd: () => log('onDrawEnd called!'),
    );
    super.onInit();
  }

  onSignAgain() {
    signatureController.clear();
  }

  onConfirm() {
    if (signatureController.isNotEmpty) {
      Get.back(result: signatureController.toPngBytes());
      signatureController.clear();
    } else {
      AlertSnackbar.show(
          title: 'Error', message: 'Please sign the contract', isError: true);
    }
  }
}
