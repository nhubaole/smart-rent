import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
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
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 2.h),
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ItemRequestRent(
                onNav: () => Get.toNamed(AppRoutes.requestRequestRoomV2));
          },
        ),
      ),
    );
  }
}
