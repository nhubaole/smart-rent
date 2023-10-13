import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/home/controllers/home_list_room_controller.dart';

class HomeListRoomWidget extends StatefulWidget {
  const HomeListRoomWidget({super.key});

  @override
  State<HomeListRoomWidget> createState() => _HomeListRoomWidgetState();
}

class _HomeListRoomWidgetState extends State<HomeListRoomWidget> {
  HomeListRoomController listRoomController = Get.put(HomeListRoomController());

  @override
  void initState() {
    super.initState();
    listRoomController.getListRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Phổ biến',
                style: TextStyle(
                  fontSize: 20,
                  color: secondary20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Obx(
            () => GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.71,
                crossAxisSpacing: 5,
                // mainAxisSpacing: 20,
              ),
              itemCount: listRoomController.listRoom.length,
              itemBuilder: (BuildContext context, int index) {
                return RoomItem(
                  room: listRoomController.listRoom[index],
                  isLiked: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
