import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/filter_type.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';

import '/modules/search/controllers/filter_controller.dart';
import '/modules/search/views/result_item.dart';

// ignore: must_be_immutable
class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Obx(() => _buildBody(context)),
      ),
    );
  }

  Widget _buildWidgetStatus(BuildContext context) {
    switch (controller.isLoadingType.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildListRoomResutl();
      case LoadingType.ERROR:
        return ErrorCustomWidget();
    }
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 24.px),
                // _buildSearchBar(context),
                _buildSearchBarField(context),
                SizedBox(height: 16.px),
                _buildSelectedFilter(),
              ],
            ),
          ),
          // Obx(() => controller.filterStringList.isNotEmpty
          //     ? _buildListFilter()
          //     : const SizedBox()),
          if (controller.filterStringList.isNotEmpty) _buildListFilter(),
          _buildHeaderTotalRoom(),
          // TODO: OLD CODE
          // Obx(() => controller.selectedFilter.value == null
          //     ? controller.results.value.isNotEmpty
          //         ? _buildWidgetStatus(context)
          //         : _buildListResultEmpty()
          //     : const SizedBox.shrink()),
          controller.results.value.isNotEmpty
              ? _buildWidgetStatus(context)
              : _buildListResultEmpty()
          // TODO: OLD CODE
          // Obx(() => controller.selectedFilter.value == null
          //     ? const SizedBox()
          //     : _buildPageFilter()),
        ],
      ),
    );
  }

  Row _buildSearchBarField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width - 80,
          child: Container(
            width: double.minPositive,
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary60),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4.px, left: 4.px),
                  padding: EdgeInsets.only(right: 2.px, left: 2.px),
                  child: SvgPicture.asset(
                    'assets/images/ic_location.svg',
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.locationNormal ?? "",
                    style: TextStyle(
                      color: AppColors.primary60,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.px),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const Text(
            'Hủy',
            style: TextStyle(
                fontSize: 14,
                color: AppColors.primary60,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Flexible _buildPageFilter() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height * 0.6,
            child: Column(
              children: [
                // Obx(() => loadPageContent(controller.selectedFilter.value)),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              controller.removeAllFilter();
                              controller.queryRoomByLocation();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.primary60, width: 1.5),
                            ),
                            child: const Text(
                              'Xóa bộ lọc',
                              style: TextStyle(
                                color: AppColors.primary60,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: () async {
                              // await controller
                              //     .queryRoomByLocation();
                              // controller.selectedFilter.value =
                              //     null;
                              controller.applyFilter();
                              controller.selectedFilter.value = null;
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary60,
                            ),
                            child: const Text(
                              'Áp dụng',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Vui lòng chọn yêu cầu, sau đó bấm áp dụng để tìm kiếm!',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.secondary20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListFilter() {
    return Container(
        height: 50.px,
        color: AppColors.secondary90,
        child: Row(
          children: [
            SizedBox(
              width: 16.px,
            ),
            Text(
              'Bộ lọc',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: AppColors.secondary20,
              ),
            ),
            SizedBox(
              width: 10.px,
            ),
            Expanded(
                child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => Text(
                                controller.filterStringList[index].keys.first,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.secondary40),
                              )),
                          SizedBox(width: 10.px),
                          InkWell(
                            onTap: () {
                              controller.removeFilter(
                                  controller.filterStringList[index]);
                              controller.queryRoomByLocation();
                            },
                            child: Icon(Icons.cancel,
                                color: AppColors.secondary40, size: 16.px),
                          )
                        ],
                      ));
                },
                itemCount: controller.itemFilterCount.value,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 8);
                },
              ),
            ))
          ],
        ));
  }

  Widget _buildListResultEmpty() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.queryRoomByLocation();
        },
        child: ErrorCustomWidget(
          title: 'Không tìm thấy kết quả',
          expandToCanPullToRefresh: true,
          imageWidget: Lottie.asset(
            ImageAssets.lottieEmpty,
            repeat: true,
            reverse: true,
            height: Get.height * 0.3,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildListRoomResutl() {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: AppColors.primary98,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async => controller.queryRoomByLocation(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16.px),
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(minHeight: Get.height * 0.6),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => SizedBox(height: 16.px),
                  itemCount: controller.results.value.length,
                  itemBuilder: (context, index) {
                    return ResultItem(
                      room: controller.results.value[index],
                      onTap: (room) {
                        Get.toNamed(
                          AppRoutes.detail,
                          arguments: {'id': room.id},
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFilter() {
    return SizedBox(
      height: 36.px,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = controller.filterType[index];
          return FilledButton.icon(
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              backgroundColor: controller.selectedFilter.value == item
                  ? AppColors.primary40
                  : AppColors.secondary90,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () => controller.onSelectedFilterItem(item),
            icon: Icon(
              controller.selectedFilter.value == item
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 20,
              color: controller.selectedFilter.value == item
                  ? Colors.white
                  : AppColors.secondary40,
              weight: 2,
            ),
            label: Text(
              controller.filterType[index].getNameFilterType,
              style: TextStyle(
                  fontSize: 12,
                  color: controller.selectedFilter.value == item
                      ? Colors.white
                      : AppColors.secondary40,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
        itemCount: controller.filterType.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildHeaderTotalRoom() {
    return Padding(
      padding: EdgeInsets.only(left: 16.px, bottom: 8.px),
      child: Text(
        controller.isLoadingType.value == LoadingType.LOADED
            ? '${controller.results.value.length} Kết quả'
            : '',
        style: const TextStyle(
          color: AppColors.secondary20,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  Row _buildSearchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width - 80,
          child: Container(
            width: double.minPositive,
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary60),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4.px, left: 4.px),
                  padding: EdgeInsets.only(right: 2.px, left: 2.px),
                  child: SvgPicture.asset(
                    'assets/images/ic_location.svg',
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.locationNormal ?? "",
                    style: TextStyle(
                      color: AppColors.primary60,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.px),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const Text(
            'Hủy',
            style: TextStyle(
                fontSize: 14,
                color: AppColors.primary60,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
