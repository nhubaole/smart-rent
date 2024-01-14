import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/handle_rent_room_landlord/controllers/list_request_rent_room_controller.dart';
import 'package:smart_rent/modules/handle_rent_room_landlord/views/detail_request_rent_room_screen.dart';
import 'package:smart_rent/modules/handle_rent_room_landlord/views/widgets/item_request_rent_room.dart';

class ListRequestRentRoomScreen extends StatelessWidget {
  const ListRequestRentRoomScreen({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    final listRequestController =
        Get.put(ListRequestRentRoomController(room: room));
    listRequestController.getListTicket(false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary40,
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
                    color: primary95,
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
                                    listRequestController.getListTicket(false);
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
                                        color: primary95,
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
          ),
        ),
      ),
    );
  }
}
