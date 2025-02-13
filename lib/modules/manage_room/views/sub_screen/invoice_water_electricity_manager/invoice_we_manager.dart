import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/modules/manage_room/controllers/sub_screen_controller/invoice_water_electricity/invoice_we_manager_controller.dart';

// ignore: must_be_immutable
class InvoiceWEManager extends StatelessWidget {
  InvoiceWEManager({super.key});
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    final invoiceWEManagerController = Get.put(InvoiceWEManagerController());
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản lý hóa đơn điện nước',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.008,
          ),
          child: Obx(
            () => invoiceWEManagerController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary95,
                      backgroundColor: AppColors.primary40,
                    ),
                  )
                : invoiceWEManagerController.listTenant.value.isNotEmpty
                    ? ListView.builder(itemBuilder: (context, index) {
                        return Text(index.toString());
                      })
                    : Center(
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
                            Text(
                              '${invoiceWEManagerController.profileOwner.value!.username}\nchưa cho thuê phòng nào cạ!!!',
                              style: const TextStyle(
                                color: AppColors.secondary20,
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
                                    invoiceWEManagerController
                                        .getListTenant(false);
                                  },
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      const BorderSide(
                                        color: AppColors.primary40,
                                      ),
                                    ),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Tải lại',
                                    style: TextStyle(
                                      color: AppColors.primary40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
