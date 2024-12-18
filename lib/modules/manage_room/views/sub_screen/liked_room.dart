import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/liked_room_controller.dart';

class LikedRoomScreen extends GetView<LikedRoomController> {
  const LikedRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text(
          'Phòng yêu thích',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(() => _buildBodyByStatus()),
    );
  }

  Widget _buildBodyByStatus() {
    switch (controller.statusLoading.value) {
      case LoadingType.INIT:
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary60,
          ),
        );
      case LoadingType.LOADING:
        return const Center(
          child: LoadingWidget(),
        );
      case LoadingType.LOADED:
        return _buildLikedRooms();
      case LoadingType.ERROR:
        return const ErrorCustomWidget();
      default:
        return const SizedBox();
    }
  }

  RefreshIndicator _buildLikedRooms() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getListRoom();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        child: controller.listRoom.value.isEmpty
            ? _buildEmptyList()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildGridList(),
                  SizedBox(height: 2.h),
                  SolidButtonWidget(
                      text: 'Xem thêm',
                      onTap: () {
                        controller.getListRoom();
                      }),
                ],
              ),
      ),
    );
  }

  Widget _buildGridList() {
    // return KeepAliveWrapper(
    //   wantKeepAlive: true,
    //   child: Container(
    //     alignment: Alignment.topCenter,
    //     child: Wrap(
    //       alignment: WrapAlignment.start,
    //       crossAxisAlignment: WrapCrossAlignment.start,
    //       runAlignment: WrapAlignment.spaceEvenly,
    //       runSpacing: 2.h,
    //       spacing: 2.w,
    //       direction: Axis.horizontal,
    //       verticalDirection: VerticalDirection.down,
    //       children: controller.listRoom.value.map<Widget>(
    //         (room) {
    //           return RoomItem(
    //             room: room,
    //             isLiked: false,
    //           );
    //         },
    //       ).toList(),
    //     ),
    //   ),
    // );
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.listRoom.value.length,
      itemBuilder: (context, index) {
        return RoomItem(
          room: controller.listRoom.value[index],
        );
      },
    );
  }

  Center _buildEmptyList() {
    return Center(
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
            '${controller.useName}\nchưa thích phòng nào hết!!!',
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
                  controller.getListRoom();
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
    );
  }
}
