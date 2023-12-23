import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/invoice/detail_invoice_controller.dart';

class DetailInvoiceScreen extends StatelessWidget {
  DetailInvoiceScreen({
    super.key,
    required this.invoiceId,
  });
  final String invoiceId;
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    final detailInvoiceController =
        Get.put(DetailInvoiceController(invoiceId: invoiceId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary98,
        title: const Text(
          'Gửi yếu cầu trả phòng',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        ),
      ),
    );
  }
}
