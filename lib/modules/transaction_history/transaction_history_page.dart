import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/transaction_history/transaction_history_controller.dart';
import 'package:smart_rent/modules/transaction_history/widgets/transaction_item_widget.dart';

class TransactionHistoryPage extends GetView<TransactionHistoryController> {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'transaction_history'.tr,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 4.w,
          right: 4.w,
        ),
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              await controller.fetchTransactions();
            },
            child: _buildListByStatus(),
          ),
        ),
      ),
    );
  }

  Widget _buildListByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildListTransactions();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildListTransactions() {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.topCenter,
          constraints: BoxConstraints(minHeight: Get.height),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: AppColors.secondary80.withOpacity(0.5),
              thickness: 1,
              height: 16.px,
            ),
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.historyTransactions!.length,
            itemBuilder: (context, index) {
              final transaction = controller.historyTransactions![index];
              return TransactionItemWidget(
                transaction: transaction,
                onTap: () => controller.onNavPaymentDetail(transaction),
              );
            },
          ),
        ),
      ),
    );
  }
}
