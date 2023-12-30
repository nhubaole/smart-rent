import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/modules/payment/views/detail_transaction_screen.dart';

class PaymentInfoController extends GetxController {
  final Invoice invoice;
  final bool isReturn;
  PaymentInfoController({required this.isReturn, required this.invoice});
  RxBool isChosenMethod = false.obs;
  RxInt selectedMethod = 1.obs;
  final scrollKey = GlobalKey();
  late int orderCode;
  var isLoading = false.obs;
  late MoneyFormatterOutput fo;

  @override
  void onInit() async {
    isLoading.value = true;
    fo = MoneyFormatter(amount: double.parse(invoice.amountRoom.toString()))
        .output;
    orderCode = await FireStoreMethods().getNewestOrderCode() + 1;
    print(orderCode);
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

  Future<int> getOrderCode() async {
    return await FireStoreMethods().getNewestOrderCode();
  }

  // Invoice orderInvoice() {
  //   return Invoice(
  //     orderCode: orderCode,
  //     recieverId: 'x47CBjhEVvVD4sBVWMDkYHYgfcg1',
  //     recieverName: 'Le Bao Nhu',
  //     recieverPhoneNumber: '+84823306992',
  //     recieverNumberBank: 'recieverNumberBank',
  //     recieverBank: 'recieverBank',
  //     addressRoom: 'addressRoom',
  //     amountRoom: 5000,
  //     description: 'test coc phong tro',
  //     buyerId: FirebaseAuth.instance.currentUser!.uid,
  //     buyerName: 'Pham Quoc Danh',
  //     buyerEmail: 'quocdanhmyker@gmail.com',
  //     buyerPhone: '+84373855259',
  //     buyerAddress: 'buyerAddress',
  //     items: [
  //       {
  //         'name': 'Phong tro',
  //         'quantity': 1,
  //         'price': 5000,
  //         'description': 'Phong tro',
  //       }
  //     ],
  //     roomId: '7DogDiAfgjQqfItXyG6a',
  //   );
  // }

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
