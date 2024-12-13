import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';

class TenantSentReturnRequestController extends GetxController {
  final isFollowPerContractTerm = true.obs;
  final isCheckboxSubmitStatement = false.obs;
  late final TextEditingController returnDateController;
  late final TextEditingController reasonController;
  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  _initData() {
    _initController();
  }

  _initController() {
    returnDateController = TextEditingController(
      text: DateTime.now().ddMMyyyy,
    );
    reasonController = TextEditingController(
      text: 'Hàng xóm ồn ào, chuyển chỗ ở mới...',
    );
  }

  onTapTextFiledReturnDate() {}
}
