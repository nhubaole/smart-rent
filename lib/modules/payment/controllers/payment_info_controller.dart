import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/core/model/invoice/invoice.dart';
import '/modules/payment/views/detail_transaction_screen.dart';

class PaymentInfoController extends GetxController {
  final Invoice invoice;
  final bool isReturn;
  PaymentInfoController({required this.isReturn, required this.invoice});
  RxBool isChosenMethod = false.obs;
  RxInt selectedMethod = 1.obs;
  final scrollKey = GlobalKey();
  late int orderCode;
  var isLoading = false.obs;
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  @override
  void onInit() async {
    isLoading.value = true;

    super.onInit();

    isLoading.value = false;
  }

  String getSelectedMethod() {
    switch (selectedMethod) {
      case 1:
        return 'Credit Card';
      case 2:
        return 'Mobile Payment';
      case 3:
        return 'Cash';
    }
    return 'Credit Card';
  }

  Invoice orderInvoice() {
    print(orderCode);
    print(invoice.items);
    return Invoice(
      orderCode: orderCode,
      recieverId: invoice.recieverId,
      recieverName: invoice.recieverName,
      recieverPhoneNumber: invoice.recieverPhoneNumber,
      recieverNumberBank: invoice.recieverNumberBank,
      recieverBank: invoice.recieverBank,
      addressRoom: invoice.addressRoom,
      amountRoom: invoice.amountRoom,
      description: invoice.description,
      buyerId: invoice.buyerId,
      buyerName: invoice.buyerName,
      buyerEmail: invoice.buyerEmail,
      buyerPhone: invoice.buyerPhone,
      buyerAddress: invoice.buyerAddress,
      items: invoice.items,
      roomId: invoice.roomId,
    );
  }

  void goToPayment() {
    Get.offAll(
      DetailTransactionScreen(
        invoice: orderInvoice(),
        isReturn: isReturn,
      ),
    );
  }
}
