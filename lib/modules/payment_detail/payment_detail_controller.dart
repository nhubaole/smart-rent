import 'dart:async';

import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/notification_model.dart';
import 'package:smart_rent/core/model/payment/payment_all_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/core/widget/view_image_dialog.dart';

class PaymentDetailController extends GetxController {
  late bool isFromHistoryTransaction;

  PaymentAllModel? paymentAllModel;
  UserModel? sender;
  int? paymentId;
  NotificationModel? notificationModel;

  final isLoadingData = LoadingType.INIT.obs;
  final AppManager appManager = AppManager.instance;

  UserModel get receivedUser => appManager.currentUser!;

  bool get isMustShowNav =>
      paymentAllModel!.contractId != null ||
      paymentAllModel!.billId != null ||
      paymentAllModel!.returnRequestId != null;

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  _initData() async {
    isLoadingData.value = LoadingType.LOADING;
    final arguments = Get.arguments;
    if (arguments != null) {
      if (arguments is NotificationModel) {
        notificationModel = arguments;
        fetchPatmentFromNoti(notificationModel!.referenceId!);
      } else 
      if (arguments is PaymentAllModel) {
        paymentAllModel = arguments;
        isFromHistoryTransaction = true;
        await getSender();
      } else {
        paymentId = arguments['payment_id'] as int;
        isLoadingData.value = LoadingType.LOADING;
        final rq = await PaymentRepoImpl().getAllPayment();
        isLoadingData.value = LoadingType.LOADING;
        if (rq.isSuccess()) {
          paymentAllModel =
              rq.data!.firstWhere((element) => element.id == paymentId);
          await getSender();
          isLoadingData.value = LoadingType.LOADED;
        } else {
          isLoadingData.value = LoadingType.ERROR;
          Get.until((route) => route.settings.name == AppRoutes.root);
        }
      }
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }

    // payment_id
  }

  fetchPatmentFromNoti(int id) async {
    isLoadingData.value = LoadingType.LOADING;
    final rq = await PaymentRepoImpl().getPaymentById(id: id);
    isLoadingData.value = LoadingType.LOADING;
    if (rq.isSuccess()) {
      paymentAllModel = rq.data!;
      await getSender();
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
      Get.until((route) => route.settings.name == AppRoutes.root);
    }
  }

  Future<void> getSender() async {
    final rq = await UserRepoIml().getUserById(id: paymentAllModel!.senderId!);
    if (rq.isSuccess()) {
      sender = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  onViewProod() async {
    // await Get.dialog(
    //   barrierDismissible: false,
    //   useSafeArea: true,
    //   GestureDetector(
    //     onTap: () {
    //       Get.back();
    //     },
    //     child: Container(
    //       margin: EdgeInsets.all(16.px),
    //       decoration: const BoxDecoration(
    //         color: AppColors.transparent,
    //       ),
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(10.px),
    //         child: CacheImageWidget(
    //           imageUrl: paymentAllModel!.evidenceImage ?? ImageAssets.demo,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    await ViewImageDialog.show(
      url: paymentAllModel?.evidenceImage ?? ImageAssets.demo,
    );
  }

  onCopyTransactionCode() async {
    if (paymentAllModel!.code == null || paymentAllModel!.code!.isEmpty) {
      AlertSnackbar.show(
        title: 'Lỗi',
        message: 'Không có mã giao dịch',
        isError: true,
      );
      return;
    }
    await Helper.copyToClipBoard(content: paymentAllModel!.code ?? '');
    AlertSnackbar.show(
      title: 'Sao chép',
      message: 'Đã sao chép thành công',
      isError: false,
    );
  }

  onNavTypeContract() async {
    // OverlayLoading.show();
    // final rq = await ContractRepoImpl().getContractByID(17);
    // if (rq.isSuccess()) {
    //   final contractByStatusModel = rq.data!;
    //   OverlayLoading.hide();
    //   await Future.delayed(const Duration(milliseconds: 500));
    //   Get.toNamed(AppRoutes.contractDetail, arguments: 17);
    // } else {
    //   OverlayLoading.hide();
    //   AlertSnackbar.show(
    //     title: 'Lỗi',
    //     message: 'Lỗi tải hợp đồng',
    //     isError: true,
    //   );
    // }
    Get.toNamed(AppRoutes.contractDetail,
        arguments: paymentAllModel!.contractId);
  }

  onNavTypeBill() {}

  onNavTypeReturn() {}

  onConfirmCompletedPayment() async {
    OverlayLoading.show();
    final rq = await PaymentRepoImpl().confirmPayment(
      id: paymentAllModel!.id!,
    );
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      AlertSnackbar.show(
        title: 'Xác nhận hoàn thành thanh toán',
        message: 'Xác nhận thanh toán thành công',
        isError: false,
      );
      Get.until((route) => route.settings.name == AppRoutes.root);
    } else {
      AlertSnackbar.show(
        title: 'Xác nhận thanh toán',
        message: 'Xác nhận thanh toán thất bại',
        isError: true,
      );
    }
  }
}
