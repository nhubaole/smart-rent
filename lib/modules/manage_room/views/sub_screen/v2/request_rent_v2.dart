import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/request_rent_controller.dart';
import 'package:smart_rent/modules/manage_room/widgets/item_request_rent.dart';

class RequestRentV2Screen extends GetView<RequestRentController> {
  const RequestRentV2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(
        title: 'rental_request'.tr,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 4.w,
          right: 4.w,
        ),
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              await controller.fetchRequestRent();
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
        return _buildListRequest();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildListRequest() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 2.h),
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.rentalRequests!.length,
          itemBuilder: (context, index) {
          final request = controller.rentalRequests![index];
            return ItemRequestRent(
            isLandlord: controller.isLandlord,
            rentalRequest: request,
            onNav: () => controller.onDetailRequestRoomV2(request),
          );
        },
      ),
    );
  }
}
