import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/modules/map_location/map_search_controller.dart';
import 'package:smart_rent/modules/search/widgets/item_hint_address.dart';

class MapSearchPage extends GetView<MapSearchController> {
  const MapSearchPage({super.key});

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

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 24.px),
          _buildSearchBar(context),
          SizedBox(height: 8.px),
          Text(
            controller.label.isEmpty ? 'Tìm kiếm gần đây' : 'Gợi ý',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondary20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: controller.textController.value.text.trim().isNotEmpty
                ? controller.searchResult.isNotEmpty
                    ? _buildListHintAddress()
                    : _buildNotFound()
                : _buildRecent(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecent() {
    return ValueListenableBuilder(
      valueListenable: controller.searchMapRecently,
      builder: (context, value, _) => ListView.builder(
        itemCount: controller.searchMapRecently.value.length,
        itemBuilder: (context, index) {
          final String address = controller.searchMapRecently.value[index];
          return ItemHintAddress(
            onPressed: () {
              // Get.toNamed(AppRoutes.filter, arguments: {
              //   'location': controller.searchRecently.value[index],
              // });
              Get.back(result: address);
            },
            onRemove: () {
              // controller
              //     .removeRecent(controller.searchMapRecently.value[index]);
            },
            title: address,
          );
        },
      ),
    );
  }

  Container _buildNotFound() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      width: double.infinity,
      child: const Text(
        'Không tìm thấy kết quả',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildListHintAddress() {
    return ValueListenableBuilder<List<String>>(
      valueListenable: controller.searchMapRecently,
      builder: (context, value, _) {
        return ListView.builder(
          itemCount: controller.searchResult.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.secondary80, width: 1))),
              child: InkWell(
                onTap: () {
                  // controller.saveRecent(controller.searchResult[index]);
                  Get.back(result: controller.searchResult[index]);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.secondary40,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        controller.searchResult[index],
                        style: const TextStyle(
                            color: AppColors.secondary20, fontSize: 14),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Row _buildSearchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            width: MediaQuery.sizeOf(context).width - 80,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary60, width: 1),
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    style: const TextStyle(fontSize: 12),
                    controller: controller.textController,
                    decoration: InputDecoration(
                      hintText: 'Tìm phòng trọ gần nơi học tập, làm việc,...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.secondary40,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onChanged: controller.onSearchTextChanged,
                    onSubmitted: (value) {
                      // controller.saveRecent(value);
                      Get.back(result: value);
                    },
                  ),
                ),
                SizedBox(width: 4.px),
                InkWell(
                  child: Icon(
                    Icons.cancel,
                    size: 16.px,
                    color: AppColors.secondary40,
                  ),
                  onTap: () {
                    controller.textController.clear();
                    controller.onSearchTextChanged('');
                  },
                )
              ],
            )),
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
