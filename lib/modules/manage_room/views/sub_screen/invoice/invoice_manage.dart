import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/invoice/invoice_manage_controller.dart';

class InvoiceManage extends StatefulWidget {
  const InvoiceManage({super.key});

  @override
  State<InvoiceManage> createState() => _InvoiceManageState();
}

class _InvoiceManageState extends State<InvoiceManage>
    with SingleTickerProviderStateMixin {
  final invoiceManageController = Get.put(InvoiceManageController());
  late double deviceHeight;
  late double deviceWidth;
  @override
  void initState() {
    invoiceManageController.tabController =
        TabController(length: 2, vsync: this);
    invoiceManageController.tabController.addListener(() {
      invoiceManageController
          .stateChangeIndex(invoiceManageController.tabController.index);
    });
    invoiceManageController.getInvoiceUnPaid(false);
    invoiceManageController.getInvoicePaid(false);
    super.initState();
  }

  @override
  void dispose() {
    invoiceManageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hóa đơn tiền cọc',
            style: TextStyle(
              color: primary40,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: TabBar(
            controller: invoiceManageController.tabController,
            labelColor: primary40,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primary40,
            tabs: [
              Obx(
                () => Tab(
                  text:
                      'Chưa thanh toán (${invoiceManageController.listInvoiceUnPaid.value.length})',
                ),
              ),
              Obx(
                () => Tab(
                  text:
                      'Đã thanh toán (${invoiceManageController.listInvoicePaid.value.length})',
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: TabBarView(
            controller: invoiceManageController.tabController,
            children: [
              unPaid(),
              paid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget unPaid() {
    return RefreshIndicator(
      onRefresh: () {
        return invoiceManageController.getInvoiceUnPaid(true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Center(
          child: Obx(
            () => invoiceManageController.isLoading.value
                ? const CircularProgressIndicator(
                    color: primary95,
                    backgroundColor: Colors.white,
                  )
                : invoiceManageController.listInvoiceUnPaid.value.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/empty.json',
                              repeat: true,
                              reverse: true,
                              height: 300,
                              width: double.infinity,
                            ),
                            const Text(
                              'Bạn chưa có hóa đơn phải thanh toán',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: OutlinedButton(
                                  onPressed: () {
                                    invoiceManageController
                                        .getInvoiceUnPaid(false);
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color: primary40,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Tải lại',
                                    style: TextStyle(
                                      color: primary40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: invoiceManageController
                                .listInvoiceUnPaid.value.length +
                            1,
                        itemBuilder: (context, index) {
                          if (index <
                              invoiceManageController
                                  .listInvoiceUnPaid.value.length) {
                            return GestureDetector(
                              onTap: () {},
                              child: transactionElement(
                                invoiceManageController
                                    .listInvoiceUnPaid.value[index],
                                true,
                                false,
                              ),
                            );
                          } else {
                            return Obx(
                              () => invoiceManageController.isLoadMore.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: primary95,
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            invoiceManageController
                                                .getInvoiceUnPaid(true);
                                          },
                                          style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                              const BorderSide(
                                                color: primary40,
                                              ),
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'Xem thêm',
                                            style: TextStyle(
                                              color: primary40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          }
                        },
                      ),
          ),
        ),
      ),
    );
  }

  Widget paid() {
    return RefreshIndicator(
      onRefresh: () {
        return invoiceManageController.getInvoicePaid(true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Center(
          child: Obx(
            () => invoiceManageController.isLoading.value
                ? const CircularProgressIndicator(
                    color: primary95,
                    backgroundColor: Colors.white,
                  )
                : invoiceManageController.listInvoicePaid.value.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/empty.json',
                              repeat: true,
                              reverse: true,
                              height: 300,
                              width: double.infinity,
                            ),
                            const Text(
                              'Bạn chưa có hóa đơn đã thanh toán',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: OutlinedButton(
                                  onPressed: () {
                                    invoiceManageController
                                        .getInvoicePaid(false);
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color: primary40,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Tải lại',
                                    style: TextStyle(
                                      color: primary40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: invoiceManageController
                                .listInvoicePaid.value.length +
                            1,
                        itemBuilder: (context, index) {
                          if (index <
                              invoiceManageController
                                  .listInvoicePaid.value.length) {
                            return GestureDetector(
                              onTap: () {},
                              child: transactionElement(
                                invoiceManageController
                                    .listInvoicePaid.value[index],
                                false,
                                false,
                              ),
                            );
                          } else {
                            return Obx(
                              () => invoiceManageController.isLoadMore.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: primary95,
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            invoiceManageController
                                                .getInvoicePaid(true);
                                          },
                                          style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                              const BorderSide(
                                                color: primary40,
                                              ),
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'Xem thêm',
                                            style: TextStyle(
                                              color: primary40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          }
                        },
                      ),
          ),
        ),
      ),
    );
  }

  Widget transactionElement(
      Map<String, dynamic> transaction, bool isUnPaid, bool isReceiveMoney) {
    var date =
        DateTime.fromMillisecondsSinceEpoch(transaction['timeStamp'] * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return Container(
      decoration: BoxDecoration(
          color: primary98, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/payment.png',
            height: deviceHeight * 0.12,
            width: deviceWidth * 0.12,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isReceiveMoney
                      ? 'Nhận tiền từ ${transaction['invoice']['recieverName']}'
                      : 'Chuyển tiền đến ${transaction['invoice']['recieverName']}',
                  style: const TextStyle(
                    color: secondary20,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: secondary40,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        //width: deviceWidth * 0.5,
                        child: Text(
                          'Nội dung: ${transaction['invoice']['description']}',
                          style: TextStyle(
                            color: secondary40,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        isUnPaid
                            ? ' ~ ${transaction['invoice']['amountRoom']}đ'
                            : isReceiveMoney
                                ? ' + ${transaction['invoice']['amountRoom']}đ'
                                : ' - ${transaction['invoice']['amountRoom']}đ',
                        style: TextStyle(
                          color: isUnPaid
                              ? red50
                              : isReceiveMoney
                                  ? Colors.green.withOpacity(0.7)
                                  : red50,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
