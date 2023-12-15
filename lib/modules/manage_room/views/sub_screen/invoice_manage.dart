import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/invoice_manage_controller.dart';

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
    invoiceManageController.getInvoiceUnPaid();
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
            'Quản lí hóa đơn',
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
            tabs: const [
              Tab(
                text: 'Chưa thanh toán',
                icon: Icon(Icons.receipt),
              ),
              Tab(
                text: 'Đã thanh toán',
                icon: Icon(Icons.receipt_long_outlined),
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
    return Center(
      child: Obx(
        () => invoiceManageController.isLoading.value
            ? const CircularProgressIndicator(
                color: primary95,
                backgroundColor: Colors.white,
              )
            : invoiceManageController.listInvoice.value.isEmpty
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
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: invoiceManageController.listInvoice.value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: transactionElement(
                          invoiceManageController.listInvoice.value[index],
                          true,
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget paid() {
    return Center(
      child: Obx(
        () => invoiceManageController.isLoading.value
            ? const CircularProgressIndicator(
                color: primary95,
                backgroundColor: Colors.white,
              )
            : invoiceManageController.listInvoice.value.isEmpty
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
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: invoiceManageController.listInvoice.value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: transactionElement(
                          invoiceManageController.listInvoice.value[index],
                          false,
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget transactionElement(Map<String, dynamic> transaction, bool isUnPaid) {
    var date =
        DateTime.fromMillisecondsSinceEpoch(transaction['timeStamp'] * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.02,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/ic_money.svg',
              height: deviceHeight * 0.1,
              width: deviceWidth * 0.1,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chuyển tiền đến ${transaction['invoice']['recieverName']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
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
                      SizedBox(
                        width: deviceWidth * 0.4,
                        child: Text(
                          'Nội dung: ${transaction['invoice']['description']}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          ' ${transaction['invoice']['amountRoom']}đ',
                          style: TextStyle(
                            color: isUnPaid
                                ? Colors.red.withOpacity(0.7)
                                : Colors.green.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
