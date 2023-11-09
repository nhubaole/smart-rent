import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/posted_room_controller.dart';

class PostedRoomScreen extends StatefulWidget {
  const PostedRoomScreen({super.key});

  @override
  State<PostedRoomScreen> createState() => _PostedRoomScreenState();
}

class _PostedRoomScreenState extends State<PostedRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final PostedRoomController postedRoomController =
        Get.put(PostedRoomController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đã đăng',
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
            () => postedRoomController.isLoading.value
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
                        itemCount: postedRoomController.listRoom.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RoomItem(
                            room: postedRoomController.listRoom[index],
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
