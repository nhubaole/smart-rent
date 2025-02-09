import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/room_fetch.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/core/widget/room_item_skeleton.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/home/controllers/home_controller.dart';
import 'package:smart_rent/modules/map/views/map_screen.dart';
import 'package:smart_rent/modules/map_location/map_location_controller.dart';

import 'package:transparent_image/transparent_image.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        wantKeepAlive: true,
        child: ScaffoldWidget(
          body: _buildContent(),
          floatingActionButton: _buildFloatingButton(),
      ),
    );
  }

  SingleChildScrollView _buildContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // top widget
          _buildTopComponent(),
          // pho bien
          _buildRoomByAreasComponent(),
          //list room
          _buildPopularRoom(),
        ],
      ),
    );
  }

  Stack _buildTopComponent() {
    return Stack(
      children: [
        _buildBackground(),
        _buildNameLocationNav(),
      ],
    );
  }

  Positioned _buildNameLocationNav() {
    return Positioned(
      child: Column(
        children: [
          SizedBox(height: 12.h),
          _buildNameAndLocation(),
          SizedBox(height: 1.6.h),
          _buildSearchComponent(),
          SizedBox(height: 2.4.h),
          _buildNavButtons(),
        ],
      ),
    );
  }

  Widget _buildNavButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 205, 203, 203), // Màu của bóng mờ
            blurRadius: 9.0, // Độ mờ của bóng
            spreadRadius: 3.0, // Độ lan rộng của bóng
            offset: Offset(0, 2), // Vị trí độ lệch của bóng
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 4.w,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              // if (Get.isRegistered<MapLocationController>()) {
              //   await Get.find<MapLocationController>().fetchRooms();
              //   Get.toNamed(AppRoutes.mapLocation);
              // }
              if (controller.currLatLon.value != null) {
                Get.toNamed(AppRoutes.mapLocation);
              } else {
                await controller.getCurrentLocation();
                Get.toNamed(AppRoutes.mapLocation);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary98,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 25,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.map,
                    color: AppColors.primary40,
                  ),
                  Text('Bản đồ'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // Get.to(() => const PostRoomPage());
              if (controller.currentUser.role == 0) {
                controller.onAskToUpgradeToLandlord();
                return;
              }
              await Get.toNamed(AppRoutes.postRoom);
              await controller.getListRoom(false);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary98,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 25,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.add_box,
                    color: AppColors.primary40,
                  ),
                  Text('Đăng bài'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.recentlyRoom);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary98,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 15,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.history,
                    color: AppColors.primary40,
                  ),
                  Text('Đã xem\ngần đây'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell _buildSearchComponent() {
    return InkWell(
      onTap: () async {
        // Get.to(() => const SearchPage());
        await Get.toNamed(AppRoutes.searchRoom);
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 18,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.secondary40,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Tìm theo quận, tên đường, địa điểm',
              style: TextStyle(
                color: AppColors.secondary40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildNameAndLocation() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 1.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUsername(),
                SizedBox(height: 0.8.h),
                _buildLocation(),
              ],
            ),
          ),
          _buildButtonNotifications(),
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return RichText(
      maxLines: 1,
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Xin chào ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: controller.fullName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Obx(
      () => Row(
        children: [
          const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(
            width: 2.w,
          ),
          controller.currenLocation.value.isEmpty
              ? SizedBox(
                  width: 12.px,
                  height: 12.px,
                  child: CircularProgressIndicator(
                    color: AppColors.primary60,
                    backgroundColor: Colors.white,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 2.px,
                  ),
                )
              : Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: controller.currenLocation.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container _buildButtonNotifications() {
    return Container(
      width: 13.w,
      height: 13.w,
      decoration: BoxDecoration(
        color: AppColors.primary95,
        borderRadius: BorderRadius.circular(13.w),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.notification);
        },
        child: Lottie.asset('assets/lottie/bell.json',
            repeat: true, reverse: true, height: 50, width: double.infinity),
      ),
    );
  }

  Padding _buildPopularRoom() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 2.h,
      ),
      child: Column(
        children: [
          _buildTextPopularRoom(),
          SizedBox(height: 8.px),
          Obx(() => _buildGridViewPopularRoom()),
          SizedBox(height: 16.px),
          _buildSeeMore()
        ],
      ),
    );
  }

  Widget _buildSeeMore() {
    return controller.listRoom.value.isEmpty
        ? const SizedBox()
        : controller.isLoadMore.value
            ? _buildLoadingWidget()
            : _buildButtonSeeMore();
  }

  Container _buildButtonSeeMore() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          controller.getListRoom(true);
        },
        style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary60,
            padding: const EdgeInsets.symmetric(vertical: 12)),
        child: const Text(
          'Xem thêm',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildGridViewPopularRoom() {
    return controller.isFetchingRoom.value == RoomFetch.LOADING
        ? _buildLoadingEffectListRoom()
        : controller.listRoom.value.isEmpty
            ? _buildGridPopularRoomEmpty()
            : _buildGridPopularRoomNotEmpty();
  }

  Widget _buildGridPopularRoomNotEmpty() {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.getListRoom(false);
        },
        child: Container(
          alignment: Alignment.topCenter,
          // child: Wrap(
          //   alignment: WrapAlignment.start,
          //   crossAxisAlignment: WrapCrossAlignment.start,
          //   runAlignment: WrapAlignment.spaceEvenly,
          //   runSpacing: 2.h,
          //   spacing: 2.w,
          //   children: controller.listRoom.value.map<Widget>(
          //     (room) {
          //       return RoomItem(
          //         room: room,
          //       );
          //     },
          //   ).toList(),
          // ),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Get.width / 2,
              crossAxisSpacing: 5.px,
              mainAxisSpacing: 10.px,
              mainAxisExtent: 300.px,
            ),
            itemCount: controller.listRoom.value.length,
            itemBuilder: (context, index) {
              final room = controller.listRoom.value[index];
              return RoomItem(
                  room: room,
                );
            },
          ),
        ),
      ),
    );
  }

  Center _buildGridPopularRoomEmpty() {
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
          const Text(
            'Hệ thống đang cập nhật phòng',
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 18,
              fontWeight: FontWeight.w200,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(1.w),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  controller.getListRoom(false);
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

  Center _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary95,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildLoadingEffectListRoom() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.spaceEvenly,
      runSpacing: 2.h,
      spacing: 2.w,
      children: List.generate(
        14,
        (index) => const RoomItemSkeleton(),
      ),
    );
  }

  Row _buildTextPopularRoom() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Phòng nổi bật',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Column _buildRoomByAreasComponent() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildTextRoomByAreas(),
        // list Pho Bien
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.dataList.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 1.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    Get.closeAllSnackbars();
                    // Get.to(
                    //   FilterScreen(
                    //       location:
                    //           controller.dataList[index]['address'] as String),
                    // );
                    Get.toNamed(AppRoutes.filter, arguments: {
                      'location':
                          controller.dataList[index]['address'] as String,
                    });
                  },
                  child: Stack(
                    children: [
                      Hero(
                        tag: index,
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: CachedNetworkImageProvider(
                            controller.dataList[index]['photoUrl'] as String,
                          ),
                          fit: BoxFit.cover,
                          height: 200,
                          width: 112,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 6,
                            right: 20,
                            left: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.dataList[index]['address']
                                      as String,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  //softWrap: true,
                                  // overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 3.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildTextRoomByAreas() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'Phổ biến',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Container _buildBackground() {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary40,
            AppColors.primary80,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(1.w),
          bottomRight: Radius.circular(1.w),
        ),
      ),
    );
  }

  Widget _buildFloatingButton() {
    return !controller.isScrollingUp.value
        ? FloatingActionButton(
            child: const Icon(Icons.search),
            onPressed: () {
              Get.toNamed(AppRoutes.searchRoom, preventDuplicates: true);
            })
        : FloatingActionButton.extended(
            label: const Row(
              children: [
                Icon(Icons.search),
                Text('Tìm phòng trọ ngay'),
              ],
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.searchRoom
              );
            },
          );
  }
}
