import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/search/controllers/result_controller.dart';
import 'package:smart_rent/modules/search/views/result_item.dart';

import '../../../core/values/app_colors.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.location});

  final String location;
  ResultController controller = Get.put(ResultController());
  List<String> filterList = [
    "Giá cả",
    "Tiện ích",
    "Loại phòng",
    "Số người",
    "Sắp xếp"
  ];

  @override
  Widget build(BuildContext context) {
    controller.setLocation(location);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: MediaQuery.sizeOf(context).width - 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: primary60, width: 1),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/ic_location.svg'),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  controller.location,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primary60),
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
                        child: Text(
                          'Hủy',
                          style: TextStyle(
                              fontSize: 14,
                              color: primary60,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FilledButton.icon(
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: secondary90,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: secondary40,
                          ),
                          label: Text(
                            filterList[index],
                            style: TextStyle(
                                fontSize: 12,
                                color: secondary40,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                      itemCount: filterList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 8);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => Text(
                      controller.isLoaded.value
                          ? "${controller.results.value.length} Kết quả"
                          : "",
                      style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    color: primary95,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() => ListView.builder(
                          itemCount: controller.results.value.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: ResultItem(
                                room: controller.results.value[index],
                              ),
                            );
                          },
                        ))))
          ],
        )));
  }
}
