import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class PaymentInfoController extends GetxController {
  RxBool isChosenMethod = false.obs;
  RxInt selectedMethod = 1.obs;
  final scrollKey = GlobalKey();
  late int orderCode;
  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
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

  Invoice orderInvoice() {
    return Invoice(
      orderCode: orderCode,
      recieverId: 'x47CBjhEVvVD4sBVWMDkYHYgfcg1',
      recieverName: 'Le Bao Nhu',
      recieverPhoneNumber: '+84823306992',
      recieverNumberBank: 'recieverNumberBank',
      recieverBank: 'recieverBank',
      addressRoom: 'addressRoom',
      amountRoom: 5000,
      description: 'test coc phong tro',
      buyerId: FirebaseAuth.instance.currentUser!.uid,
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
      roomId: '7DogDiAfgjQqfItXyG6a',
    );
  }
}
