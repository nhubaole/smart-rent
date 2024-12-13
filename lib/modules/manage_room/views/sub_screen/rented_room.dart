import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/rented_room_controller.dart';

class RentedRoomScreen extends GetView<RentedRoomController> {
  const RentedRoomScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đã thuê',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: listHistoryRoom()),
    );
  }

  Widget listHistoryRoom() {
    return RefreshIndicator(
      onRefresh: () {
        return controller.getListHistoryRoom(false);
      },
      child: Center(
        child: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary60,
                      backgroundColor: AppColors.primary40,
                    ),
                  ),
                )
              : controller.listHistoryRoom.value.isEmpty
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
                            '${controller.profileOwner.value!.username}\nchưa thuê phòng nào cạ!!!',
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
                                  controller.getListHistoryRoom(false);
                                },
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                      color: AppColors.primary40,
                                    ),
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                            // mainAxisSpacing: 20,
                          ),
                          itemCount:
                              controller.listHistoryRoom.value.length + 1,
                          itemBuilder: (context, index) {
                            if (index <
                                controller.listHistoryRoom.value.length) {
                              return RoomItem(
                                isRenting: false,
                                isHandleRentRoom: false,
                                isHandleRequestReturnRoom: false,
                                isRequestReturnRent: false,
                                isRequestRented: false,
                                room: controller.listHistoryRoom.value[index],
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              controller
                                                  .getListHistoryRoom(true);
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
                                              'Xem thêm',
                                              style: TextStyle(
                                                color: AppColors.primary40,
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
