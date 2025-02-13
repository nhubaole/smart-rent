import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';

import '../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/core/widget/room_item.dart';
import 'recently_page_controller.dart';

class RecentlyRoomPage extends GetView<RecentlyRoomController> {
  const RecentlyRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary98,
        title: 'Đã xem gần đây',
        actions: [
          Obx(
            () => controller.listRoom.value.isNotEmpty
                ? IconButton(
                    onPressed: controller.onDeleteCache,
                    icon: const Icon(
                      Icons.delete,
                      color: red60,
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
      body: Obx(() => _buildWidgetStatus()),
    );
  }

  Widget _buildWidgetStatus() {
    switch (controller.isLoadingType.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildBody();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async => controller.getListRoom(),
          child: ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
    }
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: controller.listRoom.value.isEmpty
              ? _buildEmptyListRoom()
              : _buildListRoom(),
        ),
      ),
    );
  }

  Column _buildListRoom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Get.width / 2,
            crossAxisSpacing: 5.px,
            mainAxisSpacing: 10.px,
            mainAxisExtent: 300.px,
          ),
          itemCount: controller.listRoom.value.length + 1,
          itemBuilder: (context, index) {
            if (index < controller.listRoom.value.length) {
              return RoomItem(
                room: controller.listRoom.value[index],
              );
            } else {
              return Padding(
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
                          borderRadius: BorderRadius.circular(10.px),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(
                        color: AppColors.primary40,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildEmptyListRoom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          ImageAssets.lottieEmpty,
          repeat: true,
          reverse: true,
          height: Get.height * 0.3,
          width: double.infinity,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'Bạn chưa xem phòng nào gần đây!!!',
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: OutlinedButton(
              onPressed: () {
                Get.until((route) => route.settings.name == AppRoutes.root);
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
                'Khám phá phòng trọ ngay',
                style: TextStyle(
                  color: AppColors.primary40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
