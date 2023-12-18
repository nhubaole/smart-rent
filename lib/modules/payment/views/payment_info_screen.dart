import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/payment/controllers/payment_info_controller.dart';

class PaymentInforScreen extends StatelessWidget {
  final Invoice invoice;
  final bool isReturn;
  const PaymentInforScreen({
    super.key,
    required this.invoice,
    required this.isReturn,
  });

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentInfoController(
      invoice: invoice,
      isReturn: isReturn,
    ));
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
      body: Obx(
        () => !paymentController.isLoading.value
            ? SingleChildScrollView(
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
                                Text(
                                  'Bạn đang ${isReturn ? 'trả cọc' : 'đặt cọc'} cho phòng trọ ở địa chỉ',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  child: Text(
                                    invoice.addressRoom,
                                    style: const TextStyle(
                                      color: primary40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'Sổ tiền: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: secondary20,
                                          )),
                                      TextSpan(
                                        text: '${invoice.amountRoom}!',
                                        style: const TextStyle(
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Người nhận',
                                      style: TextStyle(
                                        color: secondary40,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      invoice.recieverName,
                                      style: const TextStyle(
                                        color: secondary20,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                color: secondary80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Số điện thoại',
                                      style: TextStyle(
                                        color: secondary40,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      invoice.recieverPhoneNumber,
                                      style: const TextStyle(
                                        color: secondary20,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                color: secondary80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Số tháng ${isReturn ? 'trả' : 'đặt'} cọc',
                                      style: const TextStyle(
                                        color: secondary40,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
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
                              const Divider(
                                color: secondary80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Số tiền thanh toán',
                                      style: TextStyle(
                                        color: secondary40,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      invoice.amountRoom.toString(),
                                      style: const TextStyle(
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
                        Obx(
                          () => paymentController.isChosenMethod.value
                              ? Column(
                                  children: [
                                    RadioListTile(
                                      value: 1,
                                      groupValue: paymentController
                                          .selectedMethod.value,
                                      title: const Text('Qr Code'),
                                      secondary: const Icon(Icons.qr_code),
                                      onChanged: (value) {
                                        paymentController.selectedMethod.value =
                                            value!;
                                      },
                                      activeColor: primary60,
                                    ),
                                    RadioListTile(
                                      value: 2,
                                      groupValue: paymentController
                                          .selectedMethod.value,
                                      title: const Text('PayPal'),
                                      secondary:
                                          const Icon(Icons.mobile_friendly),
                                      onChanged: (value) {
                                        paymentController.selectedMethod.value =
                                            value!;
                                      },
                                      activeColor: primary60,
                                    ),
                                    RadioListTile(
                                      value: 3,
                                      groupValue: paymentController
                                          .selectedMethod.value,
                                      title: const Text('Cash'),
                                      secondary:
                                          const Icon(Icons.monetization_on),
                                      onChanged: (value) {
                                        paymentController.selectedMethod.value =
                                            value!;
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
                            // Get.offAll(
                            //   DetailTransactionScreen(
                            //     //invoice: paymentController.orderInvoice(),
                            //     invoice: invoice,
                            //   ),
                            // );
                            paymentController.goToPayment();
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
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
