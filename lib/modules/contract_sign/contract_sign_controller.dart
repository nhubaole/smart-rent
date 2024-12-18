// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_sign_model.dart';
import 'package:smart_rent/core/repositories/contract/contract_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_dialog.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class RenewContractArgument {
  ContractByIdModel? contractByIdModel;
  DateTime? startDate;
  DateTime? endDate;

  RenewContractArgument({
    this.contractByIdModel,
    this.startDate,
    this.endDate,
  });
}

class ContractSignController extends GetxController {
  late SignatureController signatureController;
  late int contractId;
  RenewContractArgument? renewContractArgument;
  @override
  void onInit() {
    _initController();
    _initData();
    super.onInit();
  }

  _initController() {
    signatureController = SignatureController(
      penStrokeWidth: 1,
      penColor: Colors.black,
      exportBackgroundColor: Colors.transparent,
      exportPenColor: Colors.black,
      onDrawStart: () => log('onDrawStart called!'),
      onDrawEnd: () => log('onDrawEnd called!'),
    );
  }

  _initData() {
    final args = Get.arguments;
    if (args != null) {
      if (args is Map<String, dynamic>) {
        contractId = args['contract_id'];
      } else if (args is RenewContractArgument) {
        renewContractArgument = args;
      }
    } else {
      Get.back();
      AlertSnackbar.show(title: 'Error', message: 'Error param', isError: true);
    }
  }

  onSignAgain() {
    signatureController.clear();
  }

  onConfirm() async {
    if (renewContractArgument != null) {
      Get.offNamedUntil(
        AppRoutes.tenantRequestRenewContractSuccess,
        (route) => route.settings.name == AppRoutes.root,
      );
    } else {
      onSubmitSignContract();
    }
  }

  onSubmitSignContract() {
    OverlayLoading.show();
    if (signatureController.isNotEmpty) {
      signatureController.toPngBytes().then((value) async {
        if (value != null) {
          final signatureBase64 = Helper.uint8ListToBase64(value);
          final rq = await ContractRepoImpl().signContract(
            ContractSignModel(
              contractID: contractId,
              signatureBase64: signatureBase64,
            ),
          );
          OverlayDialog.hide();
          if (rq.isSuccess()) {
            AlertSnackbar.show(
              isError: false,
              title: 'Success',
              message: 'Sign contract success',
            );
            Get.until((route) => route.settings.name == AppRoutes.root);
          } else {
            AlertSnackbar.show(
                title: 'Error', message: rq.message ?? 'Error', isError: true);
          }
        }
      });
    } else {
      OverlayDialog.hide();
      AlertSnackbar.show(
          title: 'Error', message: 'Please sign the contract', isError: true);
    }
  }
}
