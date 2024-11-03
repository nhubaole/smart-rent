import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/liked_room_controller.dart';

class LikedRoomScreen extends GetView<LikedRoomController> {
  const LikedRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng yêu thích',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getListRoom(false);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary60,
                        ),
                      )
                    : controller.listRoom.value.isEmpty
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
                                  '${controller.useName}\nchưa thích phòng nào hết!!!',
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
                                        controller.getListRoom(false);
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
                              GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.71,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: controller.listRoom.value.length + 1,
                                itemBuilder: (context, index) {
                                  if (index <
                                      controller.listRoom.value.length) {
                                    return RoomItem(
                                      isRenting: false,
                                      isHandleRentRoom: false,
                                      isHandleRequestReturnRoom: false,
                                      isRequestReturnRent: false,
                                      isRequestRented: false,
                                      room: controller.listRoom.value[index],
                                      isLiked: false,
                                    );
                                  } else {
                                    return Obx(
                                      () => controller.isLoadMore.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
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
                                                    controller
                                                        .getListRoom(true);
                                                  },
                                                  style: ButtonStyle(
                                                    side:
                                                        WidgetStateProperty.all(
                                                      const BorderSide(
                                                        color:
                                                            AppColors.primary40,
                                                      ),
                                                    ),
                                                    shape:
                                                        WidgetStateProperty.all(
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
