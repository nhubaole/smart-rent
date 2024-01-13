import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/rented_room_controller.dart';

class RentingRoomScreen extends StatefulWidget {
  const RentingRoomScreen({super.key});

  @override
  State<RentingRoomScreen> createState() => _RentingRoomScreenState();
}

class _RentingRoomScreenState extends State<RentingRoomScreen>
    with SingleTickerProviderStateMixin {
  final rentedRoomController = Get.put(RentedRoomController());
  late double deviceHeight;
  late double deviceWidth;

  @override
  void initState() {
    rentedRoomController.getListRentingRoom(false);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đang thuê',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: listRentingRoom()),
    );
  }

  Widget listRentingRoom() {
    return RefreshIndicator(
      onRefresh: () {
        return rentedRoomController.getListRentingRoom(false);
      },
      child: Center(
        child: Obx(
          () => rentedRoomController.isLoading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primary60,
                      backgroundColor: primary40,
                    ),
                  ),
                )
              : rentedRoomController.listRentingRoom.value.isEmpty
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
                            '${rentedRoomController.profileOwner.value!.username}\nchưa thuê phòng nào cạ!!!',
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
                                  rentedRoomController
                                      .getListRentingRoom(false);
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
                          itemCount: rentedRoomController
                                  .listRentingRoom.value.length +
                              1,
                          itemBuilder: (context, index) {
                            if (index <
                                rentedRoomController
                                    .listRentingRoom.value.length) {
                              return RoomItem(
                                isRenting: true,
                                isHandleRentRoom: false,
                                isHandleRequestReturnRoom: false,
                                isRequestReturnRent: false,
                                isRequestRented: false,
                                room: rentedRoomController
                                    .listRentingRoom.value[index],
                                isLiked: rentedRoomController
                                    .listRentingRoom.value[index].listLikes
                                    .contains(
                                  FirebaseAuth.instance.currentUser!.uid,
                                ),
                              );
                            } else {
                              return Obx(
                                () => rentedRoomController.isLoadMore.value
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
                                              rentedRoomController
                                                  .getListRentingRoom(true);
                                            },
                                            style: ButtonStyle(
                                              side: MaterialStateProperty.all(
                                                const BorderSide(
                                                  color: primary40,
                                                ),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
    );
  }
}
