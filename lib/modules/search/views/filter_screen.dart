import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:smart_rent/core/enums/filter_type.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/sort.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/room/util_item.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/search/controllers/filter_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key, required this.location});
  FilterController controller = Get.put(FilterController());

  final String location;

  RangeValues _currentRangeValues = const RangeValues(40, 80);

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
                                  location,
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
                        return Obx(() => FilledButton.icon(
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor:
                                    controller.selectedFilter.value ==
                                            controller.filterType[index]
                                        ? primary40
                                        : secondary90,
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
                                    : secondary40,
                              ),
                              label: Text(
                                controller.filterType[index]
                                    .getNameFilterType(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: controller.selectedFilter.value ==
                                            controller.filterType[index]
                                        ? Colors.white
                                        : secondary40,
                                    fontWeight: FontWeight.w500),
                              ),
                            ));
                      },
                      itemCount: controller.filterType.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 8);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 50,
                color: secondary90,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Bộ lọc",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: secondary20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.filterType[index]
                                        .getNameFilterType(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: secondary40),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.cancel,
                                      color: secondary40,
                                      size: 16,
                                    ),
                                  )
                                ],
                              ));
                        },
                        itemCount: controller.filterType.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 8);
                        },
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Obx(() => loadPageContent(controller.selectedFilter.value)),
                    SizedBox(
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
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: primary60, width: 1.5),
                                ),
                                child: const Text(
                                  'Xóa bộ lọc',
                                  style: TextStyle(
                                    color: primary60,
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
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: primary60,
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
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Vui lòng chọn yêu cầu, sau đó bấm áp dụng để tìm kiếm!",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: secondary20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        )));
  }

  Widget radioTypeItem(RoomType type) {
    return RadioListTile<RoomType>(
      activeColor: primary40,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      contentPadding: EdgeInsets.all(0),
      title: Text(
        type.getNameRoomType(),
        style: TextStyle(color: secondary20, fontSize: 16),
      ),
      value: type,
      groupValue: RoomType.WHOLE_HOUSE,
      onChanged: (RoomType? value) {
        //controller.onSelectRoomType(value!);
      },
    );
  }

  Widget radioSortItem(Sort sort) {
    return RadioListTile<Sort>(
      activeColor: primary40,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      contentPadding: EdgeInsets.all(0),
      title: Text(
        sort.getNameSort(),
        style: TextStyle(color: secondary20, fontSize: 16),
      ),
      value: sort,
      groupValue: Sort.MOST_RELATED,
      onChanged: (Sort? value) {
        //controller.onSelectRoomType(value!);
      },
    );
  }

  Widget priceFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Từ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: secondary20),
                ),
                SizedBox(
                  height: 4,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                    hintText: 'Nhập giá',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đến",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: secondary20),
                ),
                SizedBox(
                  height: 4,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                    hintText: 'Nhập giá',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                ),
              ],
            )),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        RangeSlider(
          activeColor: primary40,
          inactiveColor: primary95,
          values: _currentRangeValues,
          max: 100,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            // setState(() {
            //   _currentRangeValues = values;
            // });
          },
        ),
      ],
    );
  }

  Widget utilFilter() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: controller.utilList.length,
      itemBuilder: (context, index) {
        return FilledButton.icon(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.all(0),
            backgroundColor:
                controller.utilList[index].isChecked ? primary98 : secondary90,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            controller.utilList[index] = controller.utilList[index]
                .copyWith(isChecked: !controller.utilList[index].isChecked);
          },
          icon: Icon(
            controller.utilList[index].utility.getIconUtil(),
            size: 20,
            color:
                controller.utilList[index].isChecked ? primary40 : secondary40,
          ),
          label: Text(
            controller.utilList[index].utility.getNameUtil(),
            style: TextStyle(
                fontSize: 12,
                color: controller.utilList[index].isChecked
                    ? primary40
                    : secondary40,
                fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }

  Widget roomTypeFilter() {
    return Column(
      children: [
        radioTypeItem(RoomType.DORMITORY_HOMESTAY),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.ROOM),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.WHOLE_HOUSE),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.APARTMENT),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Widget capacityFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Số người",
                style: TextStyle(fontSize: 16, color: secondary20),
              ),
            ),
            QuantityInput(
                acceptsNegatives: false,
                acceptsZero: false,
                buttonColor: primary60,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary40, width: 2)),
                ),
                value: 1,
                onChanged: (value) {
                  //simpleIntInput = int.parse(value.replaceAll(',', ''));
                }),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Giới tính",
                style: TextStyle(fontSize: 16, color: secondary20),
              ),
            ),
            Container(
              width: 210,
              child: DefaultTabController(
                length: 3,
                child: TabBar(
                  indicatorColor: primary40,
                  labelColor: primary40,
                  unselectedLabelColor: secondary40,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  tabs: <Widget>[
                    Tab(
                      text: 'Nữ',
                    ),
                    Tab(
                      text: 'Nam',
                    ),
                    Tab(
                      text: 'Tất cả',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget sortFilter() {
    return Column(children: [
      radioSortItem(Sort.MOST_RELATED),
      Divider(
        thickness: 0.7,
      ),
      radioSortItem(Sort.LATEST),
      Divider(
        thickness: 0.7,
      ),
      radioSortItem(Sort.LOWEST_TO_HIGHEST),
      Divider(
        thickness: 0.7,
      ),
      radioSortItem(Sort.HIGHEST_TO_LOWEST),
      Divider(
        thickness: 0.7,
      ),
    ]);
  }

  Widget loadPageContent(FilterType? value) {
    switch (value) {
      case FilterType.PRICE:
        return priceFilter();
      case FilterType.UTIL:
        return utilFilter();
      case FilterType.ROOM_TYPE:
        return roomTypeFilter();
      case FilterType.CAPACITY:
        return capacityFilter();
      case FilterType.SORT:
        return sortFilter();
      default:
        return const SizedBox();
    }
  }
}
