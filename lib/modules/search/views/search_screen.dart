import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import '/modules/search/controllers/search_room_controller.dart';
import '/modules/search/views/filter_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchRoomController controller = Get.put(SearchRoomController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      width: MediaQuery.sizeOf(context).width - 80,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.primary60, width: 1),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/ic_location.svg'),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              style: const TextStyle(fontSize: 12),
                              controller: controller.textController,
                              decoration: const InputDecoration(
                                  hintText: 'Tìm theo phường/xã, địa điểm,...',
                                  border: InputBorder.none),
                              onChanged: controller.onSearchTextChanged,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.cancel,
                              size: 16,
                              color: AppColors.secondary40,
                            ),
                            onTap: () {
                              controller.textController.clear();
                              controller.onSearchTextChanged('');
                            },
                          )
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
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() => Text(
                    controller.textfieldString.isEmpty
                        ? "Tìm kiếm gần đây"
                        : "Gợi ý",
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.secondary20,
                        fontWeight: FontWeight.bold),
                  )),
              Obx(
                () => Expanded(
                    child: controller.textfieldString.isNotEmpty
                        ? controller.searchResult.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.secondary80,
                                                width: 1))),
                                    child: InkWell(
                                      onTap: () {
                                        controller.saveRecent(
                                            controller.searchResult[index]);
                                        Get.to(FilterScreen(
                                            location: controller
                                                .searchResult[index]));
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
                                                  color: AppColors.secondary20,
                                                  fontSize: 14),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 16),
                                width: double.infinity,
                                child: const Text(
                                  "Không tìm thấy kết quả",
                                  textAlign: TextAlign.center,
                                ),
                              )
                        : ListView.builder(
                            itemCount: controller.searchRecently.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.secondary80,
                                            width: 1))),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(FilterScreen(
                                        location:
                                            controller.searchRecently[index]));
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
                                      Expanded(
                                        child: Text(
                                          controller.searchRecently[index],
                                          style: const TextStyle(
                                              color: AppColors.secondary20,
                                              fontSize: 14),
                                          softWrap: true,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.removeRecent(
                                              controller.searchRecently[index]);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: AppColors.secondary20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
              )
            ],
          ),
        )));
  }
}
