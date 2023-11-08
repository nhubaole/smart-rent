import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/payment/controllers/payment_info_controller.dart';
import 'package:smart_rent/modules/payment/views/detail_transaction_screen.dart';

class PaymentInforScreen extends StatelessWidget {
  const PaymentInforScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentInfoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin giao dịch',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 30,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: primary98,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset('assets/images/ic_payment.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Bạn đang đặt cọc cho phòng trọ ở địa chỉ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: Text(
                            '97 đường số 11, phường Trường Thọ, TP Thủ Đức, TP HCM ',
                            style: TextStyle(
                              color: primary40,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Sổ tiền: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: secondary20,
                                  )),
                              TextSpan(
                                text: '2.000.000đ!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: secondary20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: secondary80,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Người nhận',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Nguyễn Văn A',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: secondary80,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Số điện thoại',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '0915355488',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: secondary80,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Số tháng đặt cọc',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '1',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: secondary80,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Số tiền thanh toán',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '2.000.000đ',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                GestureDetector(
                  onTap: () {
                    paymentController.isChosenMethod.value =
                        !paymentController.isChosenMethod.value;
                    paymentController.scrollKey.currentContext!
                        .findRenderObject()!
                        .showOnScreen();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Chọn phương thức thanh toán',
                          style: TextStyle(
                            color: primary40,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // Obx(
                //   () => paymentController.isChosenMethod.value
                //       ? const Column(
                //           children: [
                //             ListTile(
                //               leading: Icon(Icons.payment),
                //               title: Text('Credit Card'),
                //             ),
                //             ListTile(
                //               leading: Icon(Icons.mobile_friendly),
                //               title: Text('Mobile Payment'),
                //             ),
                //             ListTile(
                //               leading: Icon(Icons.account_balance_wallet),
                //               title: Text('Cash'),
                //             )
                //           ],
                //         )
                //       : const SizedBox(
                //           height: 18,
                //         ),
                // ),
                Obx(
                  () => paymentController.isChosenMethod.value
                      ? Column(
                          children: [
                            RadioListTile(
                              value: 1,
                              groupValue:
                                  paymentController.selectedMethod.value,
                              title: const Text('Credit Card'),
                              secondary: const Icon(Icons.credit_card),
                              onChanged: (value) {
                                paymentController.selectedMethod.value = value!;
                              },
                              activeColor: primary60,
                            ),
                            RadioListTile(
                              value: 2,
                              groupValue:
                                  paymentController.selectedMethod.value,
                              title: const Text('PayPal'),
                              secondary: const Icon(Icons.mobile_friendly),
                              onChanged: (value) {
                                paymentController.selectedMethod.value = value!;
                              },
                              activeColor: primary60,
                            ),
                            RadioListTile(
                              value: 3,
                              groupValue:
                                  paymentController.selectedMethod.value,
                              title: const Text('Cash'),
                              secondary: const Icon(Icons.monetization_on),
                              onChanged: (value) {
                                paymentController.selectedMethod.value = value!;
                              },
                              activeColor: primary60,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 18,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const DetailTransactionScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: primary60),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Thanh toán ngay',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
