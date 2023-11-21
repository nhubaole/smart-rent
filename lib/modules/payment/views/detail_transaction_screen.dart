import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/payment/controllers/detail_transaction_controller.dart';
import 'package:smart_rent/modules/payment/views/review_room.dart';
import 'package:smart_rent/modules/payment/views/widgets/status_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailTransactionScreen extends StatelessWidget {
  final Invoice invoice;
  const DetailTransactionScreen({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final detailTransactionController = Get.put(
      DetailTransactionController(
        invoice: invoice,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết giao dịch',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/ic_logo_login.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Thanh toán hóa đơn',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Trạng thái',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Obx(
                              () => StatusWidget(
                                status: detailTransactionController
                                    .statusTransaction.value,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Mã giao dịch',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              child: Obx(
                                () => Text(
                                  detailTransactionController
                                      .rxInvoice.value!.paymentLinkId,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                detailTransactionController.copyToClipboard(
                                    detailTransactionController
                                        .rxInvoice.value!.paymentLinkId);
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Thời gian',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('yy-MM-dd HH:mm:ss')
                                  .format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Người giao dịch',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Obx(
                              () => Text(
                                detailTransactionController
                                    .rxInvoice.value!.buyerName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Tổng thanh toán',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Obx(
                              () => Text(
                                detailTransactionController
                                    .rxInvoice.value!.amountRoom
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Phương thức thanh toán',
                              style: TextStyle(
                                color: secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Thanh toán QR',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => detailTransactionController.statusTransaction.value !=
                          'success'
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height,
                          child: WebViewWidget(
                            controller:
                                detailTransactionController.webViewController,
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => detailTransactionController.statusTransaction.value ==
                          'success'
                      ? GestureDetector(
                          onTap: () {
                            Get.to(const ReviewRoom());
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
                                'Đánh giá phòng đã thuê',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
