import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Phòng nổi bật',
                style: TextStyle(
                  fontSize: 20,
                  color: secondary20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 8,),
          Obx(
            () => GridView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.66,
                crossAxisSpacing: 5,
                // mainAxisSpacing: 20,
              ),
              itemCount: listRoomController.listRoom.length,
              itemBuilder: (BuildContext context, int index) {
                return RoomItem(
                  room: listRoomController.listRoom[index],
                  isLiked:
                      listRoomController.listRoom[index].listLikes.contains(
                    FirebaseAuth.instance.currentUser!.uid,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
