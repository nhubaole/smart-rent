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
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/posted_room_controller.dart';

class PostedRoomScreen extends GetView<PostedRoomController> {
  const PostedRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text(
          'Phòng đã đăng',
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
        return _buildPostedRooms();
      case LoadingType.ERROR:
        return const ErrorCustomWidget();
      default:
        return const SizedBox();
    }
  }

  RefreshIndicator _buildPostedRooms() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getListRoom();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: controller.listRoom.value.isEmpty
              ? _buildEmptyScreen()
              : _buildGridList(),
        ),
      ),
    );
  }

  Column _buildGridList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        RefreshIndicator(
          onRefresh: () {
            return controller.getListRoom();
          },
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Get.width / 2,
              crossAxisSpacing: 5.px,
              mainAxisSpacing: 10.px,
              mainAxisExtent: 300.px,
            ),
            itemCount: controller.listRoom.value.length,
            itemBuilder: (context, index) {
              // if (index < controller.listRoom.value.length) {
              //   return RoomItem(
              //     room: controller.listRoom.value[index],
              //   );
              // } else {
              //   return Obx(
              //     () => controller.isLoadMore.value
              //         ? const Center(
              //             child: CircularProgressIndicator(
              //               color: AppColors.primary95,
              //               backgroundColor: Colors.white,
              //             ),
              //           )
              //         : Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Center(
              //               child: OutlinedButton(
              //                 onPressed: () {
              //                   controller.getListRoom();
              //                 },
              //                 style: ButtonStyle(
              //                   side: WidgetStateProperty.all(
              //                     const BorderSide(
              //                       color: AppColors.primary40,
              //                     ),
              //                   ),
              //                   shape: WidgetStateProperty.all(
              //                     RoundedRectangleBorder(
              //                       borderRadius:
              //                                     BorderRadius.circular(10),
              //                     ),
              //                   ),
              //                 ),
              //                 child: const Text(
              //                   'Xem thêm',
              //                   style: TextStyle(
              //                     color: AppColors.primary40,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //   );
              // }
              return RoomItem(
                  room: controller.listRoom.value[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Center _buildEmptyScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/empty_box.json',
            repeat: true,
            reverse: true,
            height: 300,
            width: double.infinity,
          ),
          Text(
            '${controller.fullName}\nchưa đăng phòng!!!',
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
