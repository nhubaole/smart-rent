import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/payment/views/payment_info_screen.dart';

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

  Future<void> getInvoiceMap() async {
    invoiceMap = await FireStoreMethods().getpOneNewestInvoice(
      roomId,
      profileOwner.value!.uid,
      true,
    );
  }

  Future<void> getDetailTicket(String roomId) async {
    isLoading.value = true;
    detailTicket.value = await FireStoreMethods().getTicketRequestReturnRent(
      FirebaseAuth.instance.currentUser!.uid,
      roomId,
      'PENDING',
    );
    await getProfile(detailTicket.value['uidTenant']);
    await getInvoiceMap();
    isLoading.value = false;
  }

  Future<Invoice> createInvoice() async {
    Room room = await FireStoreMethods().getRoomById(roomId);
    Account accountSender = await AuthMethods.getUserDetails(
        FirebaseAuth.instance.currentUser!.uid);

    return Invoice(
      orderCode: 0,
      recieverId: profileOwner.value!.uid,
      recieverName: profileOwner.value!.username,
      recieverPhoneNumber: profileOwner.value!.phoneNumber,
      recieverNumberBank: 'recieverNumberBank',
      recieverBank: 'recieverBank',
      roomId: room.id,
      addressRoom: room.location,
      amountRoom: invoiceMap['invoice']['amountRoom'],
      description: 'Tra tien coc',
      buyerId: accountSender.uid,
      buyerName: accountSender.username,
      buyerEmail: accountSender.email,
      buyerPhone: accountSender.phoneNumber,
      buyerAddress: accountSender.address,
      items: [
        {
          'name': 'Tra tien phong tro',
          'quantity': 1,
          'price': invoiceMap['invoice']['amountRoom'],
          'description': 'tra tien hoc cho nguoi thue',
        }
      ],
    );
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
                  color: primary60,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Đang xử lý dữ liệu thanh toán...',
                  style: TextStyle(color: primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    invoice = await createInvoice();
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
