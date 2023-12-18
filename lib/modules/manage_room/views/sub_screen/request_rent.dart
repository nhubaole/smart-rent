import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/request_rent_controller.dart';

class RequestRentScreen extends StatefulWidget {
  const RequestRentScreen({super.key});

  @override
  State<RequestRentScreen> createState() => _RequestRentScreenState();
}

class _RequestRentScreenState extends State<RequestRentScreen> {
  @override
  Widget build(BuildContext context) {
    final RequestRentController requestRentController =
        Get.put(RequestRentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng yêu cầu thuê',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return requestRentController.getListRoom(false);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Obx(
              () => requestRentController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primary60,
                      ),
                    )
                  : requestRentController.listRoom.value.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/lottie/empty_search.json',
                                repeat: true,
                                reverse: true,
                                height: 300,
                                width: double.infinity,
                              ),
                              Text(
                                '${requestRentController.profileOwner.value!.username}\nvẫn chưa có người yêu cầu thuê phòng!!!',
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
                                      requestRentController.getListRoom(false);
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
                              itemCount:
                                  requestRentController.listRoom.value.length +
                                      1,
                              itemBuilder: (context, index) {
                                if (index <
                                    requestRentController
                                        .listRoom.value.length) {
                                  return RoomItem(
                                    isHandleRequestReturnRoom: false,
                                    isReturnRent: false,
                                    isRented: false,
                                    room: requestRentController
                                        .listRoom.value[index],
                                    isLiked: requestRentController
                                        .listRoom.value[index].listLikes
                                        .contains(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    ),
                                  );
                                } else {
                                  return Obx(
                                    () => requestRentController.isLoadMore.value
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
                                                  requestRentController
                                                      .getListRoom(true);
                                                },
                                                style: ButtonStyle(
                                                  side:
                                                      MaterialStateProperty.all(
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
      ),
    );
  }
}
