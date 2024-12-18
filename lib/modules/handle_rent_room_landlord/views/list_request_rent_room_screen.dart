import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '/modules/handle_rent_room_landlord/controllers/list_request_rent_room_controller.dart';
import '/modules/handle_rent_room_landlord/views/detail_request_rent_room_screen.dart';
import '/modules/handle_rent_room_landlord/views/widgets/item_request_rent_room.dart';

class ListRequestRentRoomScreen extends StatelessWidget {
  const ListRequestRentRoomScreen({super.key, required this.room});
  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    final listRequestController =
        Get.put(ListRequestRentRoomController(room: room));
    listRequestController.getListTicket(false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary40,
        foregroundColor: Colors.white,
        title: const Text(
          'Yêu cầu thuê phòng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return listRequestController.getListTicket(true);
        },
        child: Center(
          child: Obx(
            () => listRequestController.isLoading.value
                ? const CircularProgressIndicator(
                    color: AppColors.primary95,
                    backgroundColor: Colors.white,
                  )
                : listRequestController.listTicket.value.isEmpty
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
                            const Text(
                              'Bạn chưa có ticket yêu cầu thuê',
                              style: TextStyle(
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
                                    listRequestController.getListTicket(false);
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
                    : ListView.builder(
                        itemCount:
                            listRequestController.listTicket.value.length + 1,
                        itemBuilder: (context, index) {
                          if (index <
                              listRequestController.listTicket.value.length) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => DetailRequestRentRoomScreen(
                                    data: listRequestController
                                        .listTicket.value[index],
                                  ),
                                );
                              },
                              child: ItemRequestRentRoom(
                                  data: listRequestController
                                      .listTicket.value[index]),
                            );
                          } else {
                            return Obx(
                              () => listRequestController.isLoadMore.value
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
                                            listRequestController
                                                .getListTicket(true);
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
          ),
        ),
      ),
    );
  }
}
