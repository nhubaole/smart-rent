import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/repositories/contract/contract_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/contract_detail/widgets/confirm_end_contract_and_return_room_widget.dart';
import 'package:smart_rent/modules/tenant_rent_return/tenant_rent_return_controller.dart';

class NotiArgument {
  int? contractID;
  NotiArgument({
    this.contractID,
  });
}

class ContractDetailController extends GetxController {
  ContractByStatusModel? contractByStatusModel;
  ContractByIdModel? contractByIdModel;
  NotiArgument? notiArgument;
  int? contractType;
  // late int contractType;
  PartyInfoModel? get partyA => contractByIdModel?.partyA;
  PartyInfoModel? get partyB => contractByIdModel?.partyB;

  final isLoading = LoadingType.INIT.obs;
  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  _initData() async {
    final args = Get.arguments;
    if (args != null) {
      if (args is Map<String, dynamic>) {
        contractByStatusModel = args['contract'];
        contractType = args['contract_type'];
        await fetchContractById();
      } else if (args is int) {
        final id = args;
        await fetchContractById(id: id);
      } else if (args is NotiArgument) {
        notiArgument = args;
        await fetchContractById(id: args.contractID);
      }
    } else {
      Get.back();
      AlertSnackbar.show(title: 'Error', message: 'Error param', isError: true);
    }
  }

  Future<void> fetchContractById({int? id}) async {
    isLoading(LoadingType.LOADING);
    try {
      final contractResponse = await ContractRepoImpl()
          .getContractByID(id ?? contractByStatusModel!.id!);

      if (!contractResponse.isSuccess()) {
        isLoading(LoadingType.ERROR);
        return;
      }

      contractByIdModel = contractResponse.data!;
      contractByIdModel = contractByIdModel?.copyWith(id: id);
      isLoading(LoadingType.LOADED);

      // final userResponses = await Future.wait([
      //   UserRepoIml().getUserById(id: contractByIdModel!.landlordId!),
      //   UserRepoIml().getUserById(id: contractByIdModel!.tenantId!),
      // ]);
    } catch (e) {
      isLoading(LoadingType.ERROR);
    }
  }

  onRightButtonClick() {
    if (notiArgument != null) {
      Get.toNamed(AppRoutes.tenantRequestRenewContract, arguments: {
        'contract_by_id': contractByIdModel,
      });
    } else {
      onNavContractSign();
    }
  }

  onNavContractSign() async {
    Get.toNamed(AppRoutes.contractSign, arguments: {
      'contract_id': contractByStatusModel!.id,
    });
  }

  onLeftButtonClick() async {
    if (contractType != null && contractType == 1) {
      //  contractByStatusModel = args['contract'];
      //   contractType = args['contract_type'];
      Get.bottomSheet(
        ConfirmEndContractAndReturnRoom(
          onCancel: () {},
          onConfirm: () {
            Get.toNamed(
              AppRoutes.tenantRentReturn,
              arguments: {
                'contract': contractByStatusModel,
                'contract_type': contractType,
                'contract_by_id': contractByIdModel,
              },
            );
          },
        ),
      );
    } else if (notiArgument != null) {
      Get.bottomSheet(
        ConfirmEndContractAndReturnRoom(
          onCancel: () {},
          onConfirm: () {
            Get.toNamed(
              AppRoutes.tenantRentReturn,
              arguments: ReturnRequestArgument(
                returnRequestID: notiArgument?.contractID,
              ),
            );
          },
        ),
      );
    } else {
      await onDeclineContract();
    }
  }

  onDeclineContract() async {
    OverlayLoading.show();
    final rq =
        await ContractRepoImpl().declineContract(contractByStatusModel!.id!);
    if (rq.isSuccess()) {
      OverlayLoading.hide();
      Get.until((route) => route.settings.name == AppRoutes.root);
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Error',
        message: 'sent_request_failed'.tr,
        isError: true,
      );
    }
  }
}

