import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/core/values/image_assets.dart';
import '/modules/manage_room/views/widgets/button_category_room.dart';
import '/modules/manage_room/views/widgets/tracking_room.dart';

import 'sub_screen/v2/request_rent_v2.dart';
import 'widgets/button_manage_resource.dart';

// ignore: must_be_immutable
class ManageRoomScreen extends StatelessWidget {
  ManageRoomScreen({super.key});
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    // final manageRoomController = Get.find<ManageRoomController>();

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
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
        padding: const EdgeInsets.only(
          top: 24,
          right: 16,
          left: 16,
          bottom: 8,
        ),
        height: Get.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTrackingList(),
            const SizedBox(
              height: 32,
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
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quản lý tài nguyên',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonManageResource(
                    title: 'Hợp đồng thuê trọ',
                    icon: ImageAssets.icContract,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: ButtonManageResource(
                    title: 'Yêu cầu thuê trọ',
                    icon: ImageAssets.icRequestRent,
                    onTap: () {
                      Get.to(() => const RequestRentV2Screen());
                    },
                  ),
                ),
                Expanded(
                  child: ButtonManageResource(
                    title: 'Lịch sử giao dịch',
                    icon: ImageAssets.icHistoryTransaction,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: ButtonManageResource(
                    title: 'Hóa đơn thu tiền',
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
                    title: 'Chỉ số điện nước',
                    icon: ImageAssets.icElectric,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: ButtonManageResource(
                    title: 'Khách thuê trọ',
                    icon: ImageAssets.icCustomer,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: ButtonManageResource(
                    title: 'Lịch xem phòng',
                    icon: ImageAssets.icScheduleReview,
                    onTap: () {},
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column _buildTrackingList() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Theo dõi quá tình thuê trọ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
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
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary40,
            AppColors.primary40,
            AppColors.primary40,
            AppColors.primary40,
            AppColors.primary40,
            AppColors.primary40,
            AppColors.primary40,
            AppColors.primary60,
            AppColors.primary95,
          ],
          begin: Alignment.topCenter,
          end: Alignment(0.0, -0.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: deviceHeight * 0.06,
          left: deviceWidth * 0.05,
          right: deviceWidth * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Phòng của bạn',
                style: TextStyle(
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
                    onTap: () {},
                    title: 'Phòng yêu thích',
                    icon: ImageAssets.icFavourite,
                    height: 120,
                  ),
                ),
                Expanded(
                  child: ButtonCategoryRoom(
                    onTap: () {},
                    title: 'Phòng đã đăng',
                    icon: ImageAssets.icVerified,
                    height: 120,
                  ),
                ),
                Expanded(
                  child: ButtonCategoryRoom(
                    onTap: () {},
                    title: 'Phòng chờ duyệt',
                    icon: ImageAssets.icTimer,
                    height: 120,
                  ),
                ),
                Expanded(
                  child: ButtonCategoryRoom(
                    onTap: () {},
                    title: 'Kho Lưu trữ',
                    icon: ImageAssets.icBox,
                    height: 120,
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
