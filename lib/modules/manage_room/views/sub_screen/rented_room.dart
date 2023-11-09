import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/rented_room_controller.dart';

class RentedRoomScreen extends StatefulWidget {
  const RentedRoomScreen({super.key});

  @override
  State<RentedRoomScreen> createState() => _RentedRoomScreenState();
}

class _RentedRoomScreenState extends State<RentedRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final RentedRoomController rentedRoomController =
        Get.put(RentedRoomController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đã thuê',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Obx(
            () => rentedRoomController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: primary60,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.71,
                          crossAxisSpacing: 5,
                          // mainAxisSpacing: 20,
                        ),
                        itemCount: rentedRoomController.listRoom.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RoomItem(
                            room: rentedRoomController.listRoom[index],
                            isLiked: false,
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
