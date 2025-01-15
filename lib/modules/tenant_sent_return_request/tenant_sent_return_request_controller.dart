import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/model/return_request/return_request_create_tenant_model.dart';
import 'package:smart_rent/core/repositories/return_request/return_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class TenantSentReturnRequestController extends GetxController {
  final isFollowPerContractTerm = true.obs;
  final isCheckboxSubmitStatement = false.obs;
  late final TextEditingController returnDateController;
  late final TextEditingController reasonController;
  int? contractType;
  ContractByStatusModel? contractByStatusModel;
  ContractByIdModel? contractByIdModel;

  @override
  void onInit() {
    _initData();
    _initController();
    super.onInit();
  }

  _initData() {
    final args = Get.arguments;
    if (args != null) {
      if (args is Map<String, dynamic>) {
        contractByStatusModel = args['contract'];
        contractType = args['contract_type'];
        contractByIdModel = args['contract_by_id'];
      }
    } else {
      Get.back();
    }
  }

  _initController() {
    returnDateController = TextEditingController(
      text: contractByIdModel?.endDate?.ddMMyyyy ?? '',
    );
    reasonController = TextEditingController();
  }

  onChangeFollowPerContractTerm(bool value) {
    isFollowPerContractTerm.value = value;
    if (value) {
      returnDateController.text = contractByIdModel?.endDate?.ddMMyyyy ?? '';
    } else {
      onTapTextFiledReturnDate();
    }
  }

  onTapTextFiledReturnDate() {
    if (isFollowPerContractTerm.value) {
      returnDateController.text = contractByIdModel?.endDate?.ddMMyyyy ?? '';
    } else {
      onTapChoseFromDate(Get.context!);
    }
  }

  onTapChoseFromDate(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final fromDataAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (fromDataAt != null) {
      returnDateController.text = fromDataAt.ddMMyyyy;
    }
  }

  onSubmit() async {
    if (!isCheckboxSubmitStatement.value) {
      AlertSnackbar.show(
        title: 'Thiếu thao tác',
        message: 'Bạn cần tích chọn cam kết trước khi gửi yếu cầu',
        isError: true,
      );
      return;
    }
    if (isFollowPerContractTerm.value) {
      if (contractByIdModel?.endDate?.isBefore(
              DateTime.tryParse(returnDateController.text) ?? DateTime.now()) ??
          false) {
        AlertSnackbar.show(
          title: 'Ngày trả phòng không hợp lệ',
          message: 'Ngày trả phòng không thể sau ngày hết hạn hợp đồng',
          isError: true,
        );
        return;
      }
    }

    OverlayLoading.show();

    final rq = await ReturnRequestRepoImpl().createReturnRequest(
      ReturnRequestCreateTenantModel(
        contractId: contractByStatusModel?.id,
        returnDate:
            DateTime.tryParse(returnDateController.text) ?? DateTime.now(),
        reason: reasonController.text,
      ),
    );
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      Get.offNamedUntil(
        AppRoutes.tenantRequestSuccess,
        (route) => route.settings.name == AppRoutes.root,
      );
    } else {
      AlertSnackbar.show(
        title: 'Error',
        message: 'sent_request_failed'.tr,
        isError: true,
      );
    }

  }


}
