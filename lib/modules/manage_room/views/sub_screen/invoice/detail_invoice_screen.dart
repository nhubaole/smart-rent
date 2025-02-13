import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/modules/manage_room/controllers/sub_screen_controller/invoice/detail_invoice_controller.dart';

// ignore: must_be_immutable
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
    Get.put(DetailInvoiceController(invoiceId: invoiceId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary98,
        title: const Text(
          'Gửi yêu cầu trả phòng',
          style: TextStyle(
            color: AppColors.primary40,
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
