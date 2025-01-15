// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';

import 'package:smart_rent/core/routes/app_routes.dart';

class ReturnRequestArgument {
  int? returnRequestID;

  ReturnRequestArgument({
    this.returnRequestID,
  });
}

class TenantRentReturnController extends GetxController {
  ReturnRequestArgument? returnRequestArgument;
  int? contractType;
  ContractByStatusModel? contractByStatusModel;
  ContractByIdModel? contractByIdModel;


  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is ReturnRequestArgument) {
        returnRequestArgument = args;
      } else if (args is Map<String, dynamic>) {
        contractByStatusModel = args['contract'];
        contractType = args['contract_type'];
        contractByIdModel = args['contract_by_id'];
      }
    }
    super.onInit();
  }

  onNavTenantSentReturnRequest() {
    if (returnRequestArgument != null) {
      Get.toNamed(AppRoutes.tenantSentReturnRequest,
          arguments: returnRequestArgument);
    } else if (contractByStatusModel != null &&
        contractType != null &&
        contractType == 1) {
      Get.toNamed(AppRoutes.tenantSentReturnRequest, arguments: {
        'contract': contractByStatusModel,
        'contract_type': contractType,
        'contract_by_id': contractByIdModel,
      });
    }
  }
}
