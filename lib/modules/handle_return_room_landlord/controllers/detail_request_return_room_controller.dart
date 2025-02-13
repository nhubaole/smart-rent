import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '/core/model/account/Account.dart';
import '/core/model/invoice/invoice.dart';
import '/core/resources/auth_methods.dart';
import '/core/values/app_colors.dart';
import '/modules/payment/views/payment_info_screen.dart';

class DetailRequestReturnRoomScreenController extends GetxController {
  final String roomId;
  DetailRequestReturnRoomScreenController({required this.roomId});

  var detailTicket = Rx<Map<String, dynamic>>({});
  var isLoading = Rx<bool>(false);
  var profileOwner = Rx<Account?>(null);
  Invoice? invoice;
  late Map<String, dynamic> invoiceMap = {};
  var isGetInvoices = Rx<bool>(false);

  @override
  void onInit() {
    getDetailTicket(roomId);

    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getDetailTicket(String roomId) async {
    isLoading.value = true;

    await getProfile(detailTicket.value['uidTenant']);
    isLoading.value = false;
  }

  Future<void> showDialogLoading() async {
    Get.dialog(
      const PopScope(
        //canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary60,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Đang xử lý dữ liệu thanh toán...',
                  style: TextStyle(color: AppColors.primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );

    Get.offAll(
      () => PaymentInforScreen(
        invoice: invoice!,
        isReturn: true,
      ),
    );
  }

  Future<void> showDialogConfirm() async {
    Get.dialog(
      AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc chắn muốn hủy yêu cầu này không?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              await showDialogLoading();

              Get.back();
              Get.back();
            },
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
  }
}
