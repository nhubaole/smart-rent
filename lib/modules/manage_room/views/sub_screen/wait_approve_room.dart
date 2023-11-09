import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/wait_approve_room_controller.dart';

class WaitApproveRoomScreen extends StatefulWidget {
  const WaitApproveRoomScreen({super.key});

  @override
  State<WaitApproveRoomScreen> createState() => _WaitApproveRoomScreenState();
}

class _WaitApproveRoomScreenState extends State<WaitApproveRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final WaitApproveRoomController waitApproveRoomController =
        Get.put(WaitApproveRoomController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đang chờ duyêt',
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
            () => waitApproveRoomController.isLoading.value
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
                        itemCount: waitApproveRoomController.listRoom.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RoomItem(
                            room: waitApproveRoomController.listRoom[index],
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
