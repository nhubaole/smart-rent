import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '/core/enums/filter_type.dart';
import '/core/values/app_colors.dart';
import '/modules/search/controllers/filter_controller.dart';
import '/modules/search/views/capacity_filter_page.dart';
import '/modules/search/views/price_filter_page.dart';
import '/modules/search/views/result_item.dart';
import '/modules/search/views/room_type_filter_page.dart';
import '/modules/search/views/sort_filter_page.dart';
import '/modules/search/views/util_filter_page.dart';

// ignore: must_be_immutable
class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    FilterController controller = Get.put(FilterController(location: location));

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 24,
                  ),
                  _buildSearchBar(context, controller),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Obx(() => FilledButton.icon(
                              style: FilledButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor:
                                    controller.selectedFilter.value ==
                                            controller.filterType[index]
                                        ? AppColors.primary40
                                        : AppColors.primary98,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {
                                controller.selectedFilter.value =
                                    controller.filterType[index];
                              },
                              icon: Icon(
                                controller.selectedFilter.value ==
                                        controller.filterType[index]
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 20,
                                color: controller.selectedFilter.value ==
                                        controller.filterType[index]
                                    ? Colors.white
                                    : AppColors.secondary40,
                                weight: 2,
                              ),
                              label: Text(
                                controller.filterType[index]
                                    .getNameFilterType(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: controller.selectedFilter.value ==
                                            controller.filterType[index]
                                        ? Colors.white
                                        : AppColors.secondary40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ));
                      },
                      itemCount: controller.filterType.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 8);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => controller.filterStringList.isNotEmpty
                ? Container(
                    height: 50,
                    color: AppColors.secondary90,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Bộ lọc",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.secondary20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Obx(
                          () => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Obx(() => Text(
                                            controller.filterStringList[index]
                                                .keys.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: AppColors.secondary40),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.removeFilter(controller
                                              .filterStringList[index]);
                                          controller.queryRoomByLocation();
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: AppColors.secondary40,
                                          size: 16,
                                        ),
                                      )
                                    ],
                                  ));
                            },
                            itemCount: controller.itemFilterCount.value,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 8);
                            },
                          ),
                        ))
                      ],
                    ))
                : const SizedBox()),
            Obx(() => SizedBox(
                  height: controller.filterStringList.isNotEmpty ? 16 : 0,
                )),
            Obx(() => controller.selectedFilter.value == null
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 16),
                    child: Text(
                      controller.isLoaded.value
                          ? "${controller.results.value.length} Kết quả"
                          : "",
                      style: const TextStyle(
                          color: AppColors.secondary20,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  )
                : const SizedBox()),
            Obx(() => controller.selectedFilter.value == null
                ? Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppColors.primary95,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(
                        () => ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: controller.results.value.length,
                          itemBuilder: (context, index) {
                            return ResultItem(
                              room: controller.results.value[index],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
            Obx(() => controller.selectedFilter.value == null
                ? const SizedBox()
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: Get.height * 0.6,
                          child: Column(
                            children: [
                              Obx(() => loadPageContent(
                                  controller.selectedFilter.value)),
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
                                                color: AppColors.primary60,
                                                width: 1.5),
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
                                            controller.selectedFilter.value =
                                                null;
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primary60,
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
                                    "Vui lòng chọn yêu cầu, sau đó bấm áp dụng để tìm kiếm!",
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
                  )),
          ],
        )));
  }

  Row _buildSearchBar(BuildContext context, FilterController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.sizeOf(context).width - 80,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary60, width: 1),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/ic_location.svg'),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    controller.location,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary60),
                  ),
                ),
              ],
            )),
        const SizedBox(
          width: 16,
        ),
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

  Widget loadPageContent(FilterType? value) {
    switch (value) {
      case FilterType.PRICE:
        return PriceFilterPage();
      case FilterType.UTIL:
        return UtilFilterPage();
      case FilterType.ROOM_TYPE:
        return RoomTypeFilterPage();
      case FilterType.CAPACITY:
        return CapacityFilterPage();
      case FilterType.SORT:
        return SortFilterPage();
      default:
        return const SizedBox();
    }
  }
}
