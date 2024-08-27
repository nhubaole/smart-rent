import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_status.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/demo_microservices/controller/demo_microservices_controller.dart';
import 'package:smart_rent/modules/demo_microservices/models/room_response_model.dart';

class DemoMicroservices extends StatefulWidget {
  const DemoMicroservices({super.key});

  @override
  State<DemoMicroservices> createState() => _DemoMicroservicesState();
}

class _DemoMicroservicesState extends State<DemoMicroservices> {
  late final ScrollController scrollController;
  late DemoMicroservicesController controller;
  @override
  void initState() {
    scrollController = ScrollController();
    controller = Get.put(DemoMicroservicesController());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        controller.getListRooms();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text('Length: ${controller.listRoom.value.length}')),
          actions: [
            IconButton(
              onPressed: () async {
                await controller.getListRooms();
              },
              icon: const Icon(Icons.file_download_outlined),
            ),
          ],
        ),
        body: Obx(
          () => GridView.builder(
              controller: scrollController,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.66,
                crossAxisSpacing: 5,
                // mainAxisSpacing: 20,
              ),
              itemCount: controller.listRoom.value.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.listRoom.value.length) {
                  final RoomResponseModel item =
                      controller.listRoom.value[index];

                  Room room = Room(
                    id: item.id.toString(),
                    title: item.title,
                    description: item.description,
                    roomType: RoomType.APARTMENT,
                    capacity: item.capacity,
                    gender: Gender.ALL,
                    price: item.price,
                    deposit: item.deposit,
                    electricityCost: item.electricityCost,
                    waterCost: item.waterCost,
                    internetCost: item.internetCost,
                    sumRating: 4.5,
                    hasParking: true,
                    parkingFee: item.parkingFee,
                    location: item.location,
                    utilities: [],
                    createdByUid: 'abc',
                    dateTime: 1000,
                    isRented: false,
                    status: RoomStatus.APPROVED,
                    images: [item.createdBy],
                    listComments: [],
                    listLikes: [],
                    rentBy: '',
                    regulations: 'acb',
                    locationArray: [],
                  );
                  return RoomItem(
                    isRenting: false,
                    isHandleRentRoom: false,
                    isHandleRequestReturnRoom: false,
                    isRequestReturnRent: false,
                    isRequestRented: false,
                    room: room,
                    isLiked: true,
                  );
                } else {
                  return !controller.isLoading.value
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
