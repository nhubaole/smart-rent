import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/core/widget/room_item_skeleton.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/map_location/map_location_controller.dart';

class MapLocationPage extends GetView<MapLocationController> {
  const MapLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: ScaffoldWidget(
        body: Obx(() => _buildWidgetState()),
      ),
    );
  }

  Widget _buildWidgetState() {
    return _buildBody();
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildBody();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async {},
          child: const ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildMap(),
        _buildSearchBarAndDistance(),
        _buildRooms(),
      ],
    );
  }

  Widget _buildRooms() {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, child) => SlideTransition(
        position: controller.offsetAnimation,
        child: child,
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: controller.toggleShowRooms,
                  icon: Obx(() => Icon(controller.isOpenRooms.value
                      ? Icons.arrow_downward
                      : Icons.arrow_upward)),
                ),
                SizedBox(width: 12.px),
                controller.isFetching.value
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
                    : IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: controller.fetchRooms,
                        icon: Icon(Icons.refresh),
                      ),
              ],
            ),
            Container(
              child: controller.isLoadingData.value == LoadingType.LOADED
                  ? controller.listRooms.isEmpty
                      ? _buildEmptyListRoom()
                      : _buildListRoom()
                  : _buildShimmerRooms(),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildEmptyListRoom() {
    return Container(
      height: 200.px,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            ImageAssets.lottieEmpty,
            repeat: true,
            reverse: true,
            height: 100.px,
            width: double.infinity,
          ),
          SizedBox(height: 8.px),
          Text('Chưa có phòng trọ cho địa chỉ này'),
        ],
      ),
    );
  }

  Widget _buildListRoom() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.px),
      height: controller.isOpenRooms.value ? 35.h : 25.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 8.px),
        itemBuilder: (context, index) {
          final room = controller.listRooms[index];
          return Container(
            width: 50.w,
            child: RoomItem(
              room: room,
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 8.px,
        ),
        itemCount: controller.listRooms.length,
      ),
    );
  }

  Widget _buildShimmerRooms() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.px),
      height: 200.px,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 8.px),
        itemBuilder: (context, index) {
          return RoomItemSkeleton();
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 8.px,
        ),
        itemCount: 3,
      ),
    );
  }

  Widget _buildSearchBarAndDistance() {
    return Positioned(
      top: 10.px,
      right: 16.px,
      left: 16.px,
      child: _buildSearchBar(),
    );
  }

  Row _buildSlider() {
    return Row(
      children: [
        Expanded(
          child: Slider(
            thumbColor: AppColors.primary60,
            activeColor: AppColors.primary40,
            value: controller.currentDistance.value,
            max: controller.maxDistance.value,
            divisions: 10,
            onChanged: controller.onChangeDistance,
            allowedInteraction: SliderInteraction.tapAndSlide,
          ),
        ),
        SizedBox(width: 8.px),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.px),
          ),
          child: Text(
            '${controller.currentDistance.value} km',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(2.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: controller.onBack,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            ),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.secondary40,
              size: 24.px,
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 100),
              height: controller.isShowDestination.value ? 100.px : 50.px,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.px),
                        decoration: BoxDecoration(
                          color: AppColors.primary40,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.px),
                      Expanded(
                        child: OutlineTextFiledWidget(
                          readOnly: true,
                          onTap: controller.onNavSearch,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          onValidate: (p0) => null,
                          textEditingController: controller.departureController,
                          maxlines: 1,
                          hintText: ' Tìm kiếm phòng trọ xung quanh bạn',
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: controller.isShowDestination.value,
                    child: Column(
                      children: [
                        Divider(
                          height: 1.px,
                          color: AppColors.secondary80.withOpacity(0.5),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.px),
                              decoration: BoxDecoration(
                                color: AppColors.secondary60,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4.px),
                            Expanded(
                              child: OutlineTextFiledWidget(
                                onTap: controller.showChoseScopeRadiusSheet,
                                readOnly: true,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                onValidate: (p0) => null,
                                textEditingController:
                                    controller.scopeRadiusController,
                                maxlines: 1,
                                hintText: ' Chọn phạm vi bán kính',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: controller.departureController.text.isEmpty
                ? null
                : controller.onSearch,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.px),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(AppColors.secondary80),
            ),
            icon: Icon(
              Icons.search,
              size: 24.px,
              color: AppColors.secondary40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: controller.onMapCreated,
      initialCameraPosition: CameraPosition(
        target: controller.currentPosition.value!,
        zoom: 11.0,
      ),
      myLocationEnabled: true,
      mapToolbarEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      // polylines: Set<Polyline>.of(
      //   mapController.listPolylines.value,
      // ),
      markers: controller.markers,
    );
  }
}
