import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/manage_room/controllers/manage_room_controller.dart';
import '/core/values/image_assets.dart';
import '/modules/manage_room/views/widgets/button_category_room.dart';
import '/modules/manage_room/views/widgets/tracking_room.dart';
import 'widgets/button_manage_resource.dart';

// ignore: must_be_immutable
class ManageRoomScreen extends GetView<ManageRoomController> {
  const ManageRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: ScaffoldWidget(
        body: Stack(
          children: [
            _buildTopComponent(context),
            _buildTrackingComponent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingComponent() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      top: 200,
      child: Container(
        padding: EdgeInsets.only(
          top: 20.px,
          // right: 16.px,
          // left: 16.px,
          bottom: 8.px,
        ),
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.w),
            topRight: Radius.circular(8.w),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => SizedBox(
                height: 200.px,
                child: _buildWidgetStatus(),
              ),
            ),
            SizedBox(
              height: 32.px,
            ),
            Expanded(
              child: _buildManageResource(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetStatus() {
    switch (controller.isFetchingProcessTracking.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildTrackingList();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async => controller.fetchProcessTracking(),
          child: ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
    }
  }

  Column _buildManageResource() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          child: Text(
            'resource_management'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 16.px,
        ),
        Padding(
          padding: EdgeInsets.all(16.px),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ButtonManageResource(
                      title: 'rental_contract'.tr,
                      icon: ImageAssets.icContract,
                      onTap: () => Get.toNamed(AppRoutes.contract),
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      // counter: 1,
                      title: 'rental_request'.tr,
                      icon: ImageAssets.icRequestRent,
                      onTap: () {
                        Get.toNamed(AppRoutes.requestRentV2);
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      title: 'transaction_history'.tr,
                      icon: ImageAssets.icHistoryTransaction,
                      onTap: () {
                        Get.toNamed(AppRoutes.transactionHistory);
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      title: 'billing_invoice'.tr,
                      icon: ImageAssets.icInvoice,
                      onTap: () {
                        // Get.toNamed(AppRoutes.billCollection);
                        if (controller.user.role == 0) {
                          Get.toNamed(AppRoutes.billCollection);
                        } else {
                          Get.toNamed(AppRoutes.landlordBillCollection);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonManageResource(
                      title: 'utility_meter_reading'.tr,
                      icon: ImageAssets.icElectric,
                      onTap: () =>
                          Get.toNamed(AppRoutes.manageElectricityWaterIndex),
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      isCommingSoon: true,
                      title: 'tenant'.tr,
                      icon: ImageAssets.icCustomer,
                      onTap: () {
                        // Get.toNamed(AppRoutes.tenantReturnRating);
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      title: 'room_view_schedule'.tr,
                      icon: ImageAssets.icScheduleReview,
                      isCommingSoon: true,
                      onTap: () {
                        // TODO: Test
                        // final now = DateTime.now();
                        // final startTime =
                        //     now.add(Duration(hours: 1)); // 1 hour from now
                        // final endTime = startTime
                        //     .add(Duration(hours: 2)); // 2 hours duration

                        // SRMethodChannel.createReminder(
                        //   title: 'Meeting with Client',
                        //   description: 'Discuss project requirements',
                        //   location: 'Conference Room A',
                        //   startTime: startTime,
                        //   endTime: endTime,
                        // );
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: ButtonManageResource(
                  //     title: 'Test Button'.tr,
                  //     icon: ImageAssets.icCustomer,
                  //     onTap: () {
                  //       Get.to(FormContractWidget());
                  //     },
                  //   ),
                  // ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildTrackingList() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          child: Text(
            'lease_tracking'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15.px,
        ),
        SizedBox(
          height: 160.px,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.processTracking.length,
            padding: EdgeInsets.symmetric(horizontal: 16.px),
            itemBuilder: (context, index) {
              final item = controller.processTracking[index];
              return TrackingRoom(
                model: item,
                onDetail: () => controller.onDetailProcess(item),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _buildTopComponent(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary40,
            AppColors.primary80,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 6.h,
          left: 5.w,
          right: 8.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'your_room'.tr,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ButtonCategoryRoom(
                    onTap: () {
                      Get.toNamed(AppRoutes.likedRoom);
                    },
                    title: 'favorite_room'.tr,
                    icon: ImageAssets.icFavourite,
                    height: 120.px,
                  ),
                ),
                Expanded(
                  child: ButtonCategoryRoom(
                    onTap: () {
                      Get.toNamed(AppRoutes.postedRoom);
                    },
                    title: 'posted_room'.tr,
                    icon: ImageAssets.icVerified,
                    height: 120.px,
                  ),
                ),
                Expanded(
                  child: ButtonCategoryRoom(
                    onTap: () {
                      Get.toNamed(AppRoutes.waitApprove);
                    },
                    title: 'pending_room'.tr,
                    icon: ImageAssets.icTimer,
                    height: 120.px,
                  ),
                ),
                Expanded(
                  child: ButtonCategoryRoom(
                    isCommingSoon: true,
                    onTap: () {},
                    title: 'archive_storage'.tr,
                    icon: ImageAssets.icBox,
                    height: 120.px,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
