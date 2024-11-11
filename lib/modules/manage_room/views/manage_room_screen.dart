import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
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
    return Scaffold(
      body: Stack(
        children: [
          _buildTopComponent(context),
          _buildTrackingComponent(),
        ],
      ),
    );
  }

  Widget _buildTrackingComponent() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
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
            _buildTrackingList(),
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
                      counter: 1,
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
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      title: 'billing_invoice'.tr,
                      icon: ImageAssets.icInvoice,
                      onTap: () {},
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
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      title: 'tenant'.tr,
                      icon: ImageAssets.icCustomer,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: ButtonManageResource(
                      title: 'room_view_schedule'.tr,
                      icon: ImageAssets.icScheduleReview,
                      onTap: () {},
                    ),
                  ),
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
            itemCount: 10,
            padding: EdgeInsets.symmetric(horizontal: 16.px),
            itemBuilder: (context, index) {
              return const TrackingRoom();
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppConstant.gradientColor,
          begin: Alignment.topCenter,
          end: Alignment(0.0, -0.45),
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
