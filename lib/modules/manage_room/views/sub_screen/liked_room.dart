import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/liked_room_controller.dart';

class LikedRoomScreen extends StatefulWidget {
  const LikedRoomScreen({super.key});

  @override
  State<LikedRoomScreen> createState() => _LikedRoomScreenState();
}

class _LikedRoomScreenState extends State<LikedRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final LikedRoomController likedRoomController =
        Get.put(LikedRoomController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng yêu thích',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(child: Obx(() {
          if (likedRoomController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: primary60,
              ),
            );
          } else if (likedRoomController.listRoom.value.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/empty.json',
                    repeat: true,
                    reverse: true,
                    height: 300,
                    width: double.infinity,
                  ),
                  Text(
                    '${likedRoomController.profileOwner.value!.username}\nchưa thích phòng nào hết!!!',
                    style: const TextStyle(
                      color: secondary20,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.71,
                  crossAxisSpacing: 5,
                  // mainAxisSpacing: 20,
                ),
                itemCount: likedRoomController.listRoom.length,
                itemBuilder: (BuildContext context, int index) {
                  return RoomItem(
                    room: likedRoomController.listRoom[index],
                    isLiked:
                        likedRoomController.listRoom[index].listLikes.contains(
                      FirebaseAuth.instance.currentUser!.uid,
                    ),
                  );
                },
              ),
            ],
          );
        })

            // Obx(
            //   () => likedRoomController.isLoading.value
            //       ? const Center(
            //           child: CircularProgressIndicator(
            //             color: primary60,
            //           ),
            //         )
            //       : Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           mainAxisSize: MainAxisSize.max,
            //           children: [
            //             GridView.builder(
            //               scrollDirection: Axis.vertical,
            //               shrinkWrap: true,
            //               physics: const NeverScrollableScrollPhysics(),
            //               gridDelegate:
            //                   const SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 2,
            //                 childAspectRatio: 0.71,
            //                 crossAxisSpacing: 5,
            //                 // mainAxisSpacing: 20,
            //               ),
            //               itemCount: likedRoomController.listRoom.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return RoomItem(
            //                   room: likedRoomController.listRoom[index],
            //                   isLiked: false,
            //                 );
            //               },
            //             ),
            //           ],
            //         ),
            // ),
            ),
      ),
    );
  }
}
