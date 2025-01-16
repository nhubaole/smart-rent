import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class ContractInfoController extends GetxController {
  late ContractByStatusModel contract;
  late int contractType;

  UserModel get currentUser => AppManager().currentUser!;
  bool get isLandlord => currentUser.role == 0;
  bool get isPendingContract => contractType == 0;
  bool get showButtonSignContract =>
      (isLandlord && isPendingContract) ||
      (!isLandlord && contract.signatureTimeB == null);

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  String getContractType() {
    switch (contractType) {
      case 0:
        return 'Đang chờ ký';
      case 1:
        return 'Đang hoạt động';
      case 2:
        return 'Đã hết hạn';
      default:
        return 'Đang chờ ký';
    }
  }

  _initData() async {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      contract = args['contract'];
      print(contract);
      contractType = args['contract_type'];
    }
  }

  onNavContractDetail() {
    print('onNavContractDetail');
    if (contractType == 2) {
      Get.toNamed(AppRoutes.contractDetail, arguments: contract.id);
      return;
    }
    Get.toNamed(AppRoutes.contractDetail, arguments: {
      'contract': contract,
      'contract_type': contractType,
    });
  }

  onNavPayment() {
    Get.toNamed(
      AppRoutes.paymentDeposit,
      arguments: {
        'type': 'contract',
        'id': contract.id,
      },
    );
  }
}
