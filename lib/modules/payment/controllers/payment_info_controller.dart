import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';

class PaymentInfoController extends GetxController {
  RxBool isChosenMethod = false.obs;
  RxInt selectedMethod = 1.obs;
  final scrollKey = GlobalKey();

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
    return const Invoice(
      orderCode: 13,
      recieverId: '88dO1ziekDTn3jflaopWQWeZPM12',
      recieverName: 'Le Bao Nhu',
      recieverPhoneNumber: '+84823306992',
      recieverNumberBank: 'recieverNumberBank',
      recieverBank: 'recieverBank',
      addressRoom: 'addressRoom',
      amountRoom: 5000,
      description: 'test coc phong tro',
      buyerId: 'x47CBjhEVvVD4sBVWMDkYHYgfcg1',
      buyerName: 'Pham Quoc Danh',
      buyerEmail: 'quocdanhmyker@gmail.com',
      buyerPhone: '+84373855259',
      buyerAddress: 'buyerAddress',
      items: [
        {
          'name': 'Phong tro',
          'quantity': 1,
          'price': 5000,
          'description': 'Phong tro',
        }
      ],
    );
  }
}
