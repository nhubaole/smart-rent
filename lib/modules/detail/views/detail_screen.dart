import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/chat/views/chat_screen.dart';
import 'package:smart_rent/modules/detail/controllers/detail_controller.dart';
import 'package:smart_rent/modules/profile_owner/views/profile_ower.dart';
import '../../../core/model/room/room.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.room});
  final Room room;

  final DetailController controller = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    controller.room = room;
    controller.getOwner();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: primary40,
          foregroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ))
          ],
          title: const Text(
            "Chi tiết phòng",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  imageCollection(context),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                controller.room!.roomType.getNameRoomType(),
                                style: const TextStyle(color: secondary40),
                              )),
                              Text(controller.getCapacity(),
                                  style: const TextStyle(color: secondary40))
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary98),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Text(
                                      'CÒN PHÒNG',
                                      style: TextStyle(color: secondary20),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      controller.getStatus(),
                                      style: const TextStyle(
                                          color: primary40,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Text(
                                      'DIỆN TÍCH',
                                      style: TextStyle(color: secondary20),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${controller.room!.area} m2',
                                      style: const TextStyle(
                                          color: primary40,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Text(
                                      'ĐẶT CỌC',
                                      style: TextStyle(color: secondary20),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      controller.priceFormatter(
                                          controller.room!.deposit),
                                      style: const TextStyle(
                                          color: primary40,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            controller.room!.title,
                            style: const TextStyle(
                                color: secondary20,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: secondary40,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                  child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: controller.room!.location,
                                    style: const TextStyle(color: secondary40),
                                  ),
                                  TextSpan(
                                      text: " Chỉ đường",
                                      style: const TextStyle(
                                          color: primary40,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()),
                                ]),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone_outlined,
                                color: secondary40,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Obx(() => Text(
                                    "Số điện thoại: ${controller.owner.value!.phoneNumber}",
                                    style: const TextStyle(color: secondary40),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary60, width: 1)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Icon(
                                      Icons.emoji_objects_outlined,
                                      size: 24,
                                      color: primary60,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      controller.priceFormatter(
                                          controller.room!.electricityCost),
                                      style: const TextStyle(
                                        color: primary60,
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Icon(
                                      Icons.water_drop_outlined,
                                      size: 24,
                                      color: primary60,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      controller.priceFormatter(
                                          controller.room!.waterCost),
                                      style: const TextStyle(
                                        color: primary60,
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Icon(
                                      Icons.two_wheeler_outlined,
                                      size: 24,
                                      color: primary60,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      controller.priceFormatter(
                                          controller.room!.parkingFee),
                                      style: const TextStyle(
                                        color: primary60,
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    const Icon(
                                      Icons.wifi,
                                      size: 24,
                                      color: primary60,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      controller.priceFormatter(
                                          controller.room!.internetCost),
                                      style: const TextStyle(
                                        color: primary60,
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Mô tả',
                            style: TextStyle(
                                color: secondary20,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          ExpandableText(
                            controller.room!.description,
                            expandText: 'Xem thêm',
                            collapseText: 'Rút gọn',
                            maxLines: 2,
                            linkColor: primary40,
                            linkStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            style: const TextStyle(color: secondary40),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Ngày đăng',
                            style: TextStyle(
                                color: secondary20,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: secondary40,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                controller.room!.dateTime.substring(0, 10),
                                style: const TextStyle(color: secondary40),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Tiện ích',
                            style: TextStyle(
                                color: secondary20,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 3,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                            ),
                            itemCount: controller.room!.utilities.length,
                            itemBuilder: (context, index) {
                              return FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: secondary90,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  controller.room!.utilities[index]
                                      .getIconUtil(),
                                  size: 20,
                                  color: secondary40,
                                ),
                                label: Text(
                                  controller.room!.utilities[index]
                                      .getNameUtil(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: secondary40,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Đánh giá',
                            style: TextStyle(
                                color: secondary20,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: primary40,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Row(
                                  children: [
                                    Text(
                                      '4.2',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFFFD21D),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tốt',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: primary40,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '14 đánh giá',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: secondary40,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Ink(
                                child: const Text(
                                  'Xem mọi bài đánh giá',
                                  style: TextStyle(
                                      color: primary40,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Obx(
                            () => InkWell(
                              onTap: () {
                                Get.to(
                                  ProfileOwnerScreen(
                                    uidOwner: controller.owner.value!.uid,
                                  ),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primary98),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                controller
                                                    .owner.value!.photoUrl),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.owner.value!.username,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: secondary20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              '${controller.owner.value!.listRoomForRent.length} phòng',
                                              style: const TextStyle(
                                                color: primary60,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: secondary20,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Đề xuất',
                            style: TextStyle(
                                color: secondary20,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 72,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    color: primary40,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.priceFormatterFull(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const Text(
                        '/phòng',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primary98),
                              foregroundColor:
                                  MaterialStateProperty.all(primary40),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))),
                          onPressed: () {
                            Get.to(ChatScreen(
                                conversationID:
                                    controller.owner.value!.phoneNumber,
                                conversationName:
                                    controller.owner.value!.username));
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Chat'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.sms_outlined,
                                size: 24.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(secondary90),
                              foregroundColor:
                                  MaterialStateProperty.all(secondary40),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))),
                          onPressed: () {},
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Gọi'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.phone_outlined,
                                size: 24.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }

  Widget imageCollection(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Stack(
        children: [
          Obx(
            () => CachedNetworkImage(
              imageUrl:
                  controller.room!.images[controller.activeImageIdx.value],
              height: MediaQuery.sizeOf(context).width + 50,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: -10,
            top: MediaQuery.sizeOf(context).width / 2,
            child: MaterialButton(
              onPressed: () {
                if (controller.activeImageIdx > 0) {
                  controller.activeImageIdx.value -= 1;
                }
              },
              color: Colors.white,
              textColor: secondary20,
              padding: const EdgeInsets.all(8),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
          ),
          Positioned(
            right: -10,
            top: MediaQuery.sizeOf(context).width / 2,
            child: MaterialButton(
              onPressed: () {
                if (controller.activeImageIdx <
                    controller.room!.images.length - 1) {
                  controller.activeImageIdx.value += 1;
                }
              },
              color: Colors.white,
              textColor: secondary20,
              padding: const EdgeInsets.all(8),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 2),
              color: Colors.white,
              height: 90,
              width: MediaQuery.sizeOf(context).width,
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                          imageUrl: controller.room!.images[0],
                          fit: BoxFit.cover,
                          height: 90,
                          color: controller.activeImageIdx == 0
                              ? null
                              : const Color.fromRGBO(0, 0, 0, 0.7),
                          colorBlendMode: BlendMode.multiply),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                          imageUrl: controller.room!.images[1],
                          fit: BoxFit.cover,
                          height: 90,
                          color: controller.activeImageIdx == 1
                              ? null
                              : const Color.fromRGBO(0, 0, 0, 0.7),
                          colorBlendMode: BlendMode.multiply),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                          imageUrl: controller.room!.images[2],
                          fit: BoxFit.cover,
                          height: 90,
                          color: controller.activeImageIdx == 2
                              ? null
                              : const Color.fromRGBO(0, 0, 0, 0.7),
                          colorBlendMode: BlendMode.multiply),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                              imageUrl: controller.room!.images[3],
                              fit: BoxFit.cover,
                              height: 90,
                              color: controller.activeImageIdx >= 3
                                  ? null
                                  : const Color.fromRGBO(0, 0, 0, 0.7),
                              colorBlendMode: BlendMode.multiply),
                          controller.room!.images.length > 4
                              ? Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      "+${controller.room!.images.length - 4}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
