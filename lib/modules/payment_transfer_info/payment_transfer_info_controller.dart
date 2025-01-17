import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/payment/payment_create_model.dart';
import 'package:smart_rent/core/model/payment/payment_detail_info_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/payment_transfer_info/widgets/upload_evidence_banking_sheet.dart';
import 'package:smart_rent/modules/success_page/success_controller.dart';

class PaymentTransferInfoController extends GetxController {

  late Timer timer;
  BillByIdModel? billByIdModel;
  PaymentDetailInfoModel? paymentDetailInfoModel;
  UserModel? tenant;
  String? type;
  int? id;

  final AppManager appManager = AppManager();
  final isLoadingData = LoadingType.INIT.obs;
  final isCompletedPaid = false.obs;
  final countDown = 0.obs;
  final proofImage = RxnString();

  UserModel get user => appManager.currentUser!;
  

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      billByIdModel = args['bill'];
      type = args['type'];
      id = args['id'];
      paymentDetailInfoModel = args['payment_detail_info'];
      tenant = args['tenant'];
      isLoadingData.value = LoadingType.LOADED;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (countDown.value == 0) {
            timer.cancel();
            isCompletedPaid.value = true;
          } else {
            countDown.value = countDown.value - 1;
          }
        },
      );
    } else {
      Get.back();
    }
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  onOpenUploadEvidenceSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      Obx(
        () => UploadEvidenceBankingSheet(
          proofImage: proofImage.value,
          onSelectImage: onPickImage,
          onSave: () async {
            if (proofImage.value == null) {
              AlertSnackbar.show(
                title: 'Lưu thông tin',
                message: 'Vui lòng chụp ảnh hoặc chọn ảnh để lưu thông tin',
                isError: true,
              );
              return;
            }
            final rq = await onCreatePayment();
            if (rq != null) {
              // Get.offNamedUntil(
              //   AppRoutes.landlordReturnSuccess,
              //   (route) => route.settings.name == AppRoutes.root,
              //   arguments: {
              //     // 'bill': billByIdModel,
              //     'payment_detail_info': paymentDetailInfoModel,
              //     'payment_id': rq,
              //     'tenant': tenant,
              //     'allow_review': false,
              //   },
              // );
              Get.offNamedUntil(
                AppRoutes.successPage,
                (route) => route.settings.name == AppRoutes.root,
                arguments: SuccessArgument(
                  firstText: 'Thanh toán thành công',
                  secondText:
                      'Cảm ơn bạn! Hóa đơn của bạn đã được thanh toán thành công.',
                  thirdText:
                      'Vui lòng chờ chủ nhà xác nhận để hoàn tất thủ tục.',
                  fourthText:
                      'Đừng quên thanh toán các hóa đơn tiếp theo đúng hạn để đảm bảo quyền lợi thuê trọ của bạn.',
                  fifthText:
                      'Bạn có thể xem lại chi tiết hóa đơn trong phần Quản lý hóa đơn của ứng dụng.',
                  leftButtonText: 'Trang chủ',
                  leftButtonOnTap: () {
                    Get.until((route) => route.settings.name == AppRoutes.root);
                  },
                  rightButtonText: 'Chi tiết giao dịch',
                  rightButtonOnTap: () {
                    Get.toNamed(
                      AppRoutes.paymentDetail,
                      arguments: {
                        'payment_id': rq,
                        'payment_detail_info': paymentDetailInfoModel,
                        'tenant': tenant,
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<int?> onCreatePayment() async {
    OverlayLoading.show(title: 'Vui lòng đợi');
    final compressedImage =
        await Helper.compressImage(imageFile: XFile(proofImage.value!));
    final data = PaymentCreateModel(
      billId: type == 'bill' ? billByIdModel!.id! : null,
      contractId: type == 'contract' ? id : null,
      returnRequestId: type == 'return' ? id : null,
      amount: paymentDetailInfoModel?.amount!,
      tranferContent: paymentDetailInfoModel?.tranferContent!,
      evidenceImage: proofImage.value,
    );
    print(data);
    final rq = await PaymentRepoImpl().createPayment(paymentCreateModel: data);
    OverlayLoading.hide();

    if (rq.isSuccess() && rq.data != null && rq.data!['errCode'] == 201) {
      AlertSnackbar.show(
        title: 'Tạo yêu cầu thanh toán',
        message: 'Tạo yêu cầu thanh toán thành công',
        isError: false,
      );
      return rq.data!['data'];
    } else {
      AlertSnackbar.show(
        title: 'Tạo yêu cầu thanh toán',
        message: 'Tạo yêu cầu thanh toán thất bại, vui lòng thử lại',
        isError: true,
      );
      return null;
    }
  }

  onPickImage() async {
    final rq = await Helper.pickImage();
    if (rq != null) {
      proofImage.value = rq;
    }
  }

  onSaveQRCode() async {
    OverlayLoading.show(title: 'Vui lòng đợi');
    final rq =
        await Helper.saveUrlImageToGallery(paymentDetailInfoModel!.qrUrl!);
    OverlayLoading.hide();

    if (rq != null) {
      AlertSnackbar.show(
        title: 'Lưu mã QRCode',
        message:
            'Đã lưu mã QRCode thanh toán thành công vào thư viện ảnh của bạn',
        isError: false,
      );
    } else {
      AlertSnackbar.show(
        title: 'Lưu mã QRCode',
        message: 'Lưu mã thật bại, vui lòng thử lại',
        isError: true,
      );
    }
  }

  onCopyText(String text) async {
    await Helper.copyToClipBoard(content: text);
    AlertSnackbar.show(
      title: 'Sao chép',
      message: 'Đã sao chép thành công',
      isError: false,
    );
  }
}
