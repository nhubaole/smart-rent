import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
                : waitApproveRoomController.listRoom.value.isEmpty
                    ? Center(
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
                              '${waitApproveRoomController.profileOwner.value!.username}\nchưa đăng phòng!!!',
                              style: const TextStyle(
                                color: secondary20,
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: OutlinedButton(
                                  onPressed: () {
                                    waitApproveRoomController
                                        .getListRoom(false);
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color: primary40,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Tải lại',
                                    style: TextStyle(
                                      color: primary40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                            itemCount: waitApproveRoomController
                                    .listRoom.value.length +
                                1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index <
                                  waitApproveRoomController
                                      .listRoom.value.length) {
                                return RoomItem(
                                  isHandleRentRoom: false,
                                  isHandleRequestReturnRoom: false,
                                  isRequestReturnRent: false,
                                  isRequestRented: false,
                                  room: waitApproveRoomController
                                      .listRoom.value[index],
                                  isLiked: waitApproveRoomController
                                      .listRoom.value[index].listLikes
                                      .contains(
                                    FirebaseAuth.instance.currentUser!.uid,
                                  ),
                                );
                              } else {
                                return Obx(
                                  () => waitApproveRoomController
                                          .isLoadMore.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primary95,
                                            backgroundColor: Colors.white,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                waitApproveRoomController
                                                    .getListRoom(true);
                                              },
                                              style: ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                    color: primary40,
                                                  ),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                'Xem thêm',
                                                style: TextStyle(
                                                  color: primary40,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                );
                              }
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
