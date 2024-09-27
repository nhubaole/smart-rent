import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/core/widget/room_item.dart';
import '/modules/manage_room/controllers/sub_screen_controller/posted_room_controller.dart';

class PostedRoomScreen extends StatelessWidget {
  const PostedRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostedRoomController postedRoomController =
        Get.put(PostedRoomController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đã đăng',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return postedRoomController.getListRoom(false);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Obx(
                () => postedRoomController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary60,
                        ),
                      )
                    : postedRoomController.listRoom.value.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/lottie/empty_box.json',
                                  repeat: true,
                                  reverse: true,
                                  height: 300,
                                  width: double.infinity,
                                ),
                                Text(
                                  '${postedRoomController.profileOwner.value!.username}\nchưa đăng phòng!!!',
                                  style: const TextStyle(
                                    color: AppColors.secondary20,
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
                                        postedRoomController.getListRoom(false);
                                      },
                                      style: ButtonStyle(
                                        side: WidgetStateProperty.all(
                                          const BorderSide(
                                            color: AppColors.primary40,
                                          ),
                                        ),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Tải lại',
                                        style: TextStyle(
                                          color: AppColors.primary40,
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
                              RefreshIndicator(
                                onRefresh: () {
                                  return postedRoomController
                                      .getListRoom(false);
                                },
                                child: GridView.builder(
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
                                  itemCount: postedRoomController
                                          .listRoom.value.length +
                                      1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        postedRoomController
                                            .listRoom.value.length) {
                                      return RoomItem(
                                        isRenting: false,
                                        isHandleRentRoom: false,
                                        isHandleRequestReturnRoom: false,
                                        isRequestReturnRent: false,
                                        isRequestRented: false,
                                        room: postedRoomController
                                            .listRoom.value[index],
                                        isLiked: false,
                                      );
                                    } else {
                                      return Obx(
                                        () => postedRoomController
                                                .isLoadMore.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.primary95,
                                                  backgroundColor: Colors.white,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      postedRoomController
                                                          .getListRoom(true);
                                                    },
                                                    style: ButtonStyle(
                                                      side: WidgetStateProperty
                                                          .all(
                                                        const BorderSide(
                                                          color: AppColors
                                                              .primary40,
                                                        ),
                                                      ),
                                                      shape: WidgetStateProperty
                                                          .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Xem thêm',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.primary40,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
