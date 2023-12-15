import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/search/controllers/filter_controller.dart';

// ignore: must_be_immutable
class RoomTypeFilterPage extends StatelessWidget {
  RoomTypeFilterPage({super.key});
  FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        radioTypeItem(RoomType.DORMITORY_HOMESTAY),
        const Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.ROOM),
        const Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.WHOLE_HOUSE),
        const Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.APARTMENT),
        const Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Widget radioTypeItem(RoomType type) {
    return Obx(() => RadioListTile<RoomType>(
          activeColor: primary40,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            type.getNameRoomType(),
            style: const TextStyle(color: secondary20, fontSize: 16),
          ),
          value: type,
          // ignore: prefer_null_aware_operators
          groupValue: controller.filter.value.roomTypeFilter == null
              ? null
              : controller.filter.value.roomTypeFilter?.roomType,
          onChanged: (RoomType? value) {
            controller.setRoomType(value!);
          },
        ));
  }
}
