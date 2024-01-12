import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/chat/views/chat_screen.dart';
import 'package:smart_rent/modules/detail/controllers/detail_controller.dart';
import 'package:smart_rent/modules/handle_rent_room_landlord/views/list_request_rent_room_screen.dart';
import 'package:smart_rent/modules/handle_rent_room_tenant/views/send_request_rent_room.dart';
import 'package:smart_rent/modules/handle_return_room_landlord/views/detail_request_return_room_screen.dart';
import 'package:smart_rent/modules/handle_return_room_tenant/views/send_request_return_room.dart';
import 'package:smart_rent/modules/map/views/map_screen.dart';
import 'package:smart_rent/modules/post_review/views/post_review_screen.dart';
import 'package:smart_rent/modules/profile_owner/views/profile_ower.dart';
import '../../../core/model/room/room.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen({
    super.key,
    required this.room,
    required this.isRequestRented,
    required this.isRequestReturnRent,
    required this.isHandleRequestReturnRoom,
    required this.isHandleRentRoom,
    this.notificationId,
    required this.isRenting,
  });
  final Room room;
  final bool isRequestRented;
  final bool isRequestReturnRent;
  final bool isHandleRequestReturnRoom;
  final bool isHandleRentRoom;
  final bool isRenting;
  String? notificationId;
  final DetailController controller = Get.put(DetailController());
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.sizeOf(context).height;
    deviceWidth = MediaQuery.sizeOf(context).width;
    controller.room = room;
    controller.getOwner();
    controller.setRoomRecently();

    var date = DateTime.fromMillisecondsSinceEpoch(room.dateTime * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: deviceHeight * 0.1,
            right: deviceWidth * 0.001,
            child: isRenting
                ? FloatingActionButton.extended(
                    backgroundColor: Colors.white,
                    heroTag: UniqueKey(),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: primary60,
                      ),
                      borderRadius: BorderRadius.circular(deviceHeight * 0.1),
                    ),
                    label: const Row(
                      children: [
                        Text(
                          'Yêu cầu trả phòng',
                          style: TextStyle(color: primary60),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Icon(
                          Icons.wifi_protected_setup_rounded,
                          color: primary60,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.to(
                        () => SendRequestReturnRoom(
                          room: room,
                        ),
                      );
                    },
                  )
                : isRequestReturnRent || isRequestRented
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: Colors.white,
                            heroTag: UniqueKey(),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 2,
                                color: primary60,
                              ),
                              borderRadius:
                                  BorderRadius.circular(deviceHeight * 0.1),
                            ),
                            label: const Row(
                              children: [
                                Text(
                                  'Sửa yêu cầu',
                                  style: TextStyle(color: primary60),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Icon(
                                  Icons.wifi_protected_setup_rounded,
                                  color: primary60,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (isRequestReturnRent) {
                                Map<String, dynamic> result =
                                    await FireStoreMethods()
                                        .getTicketRequestReturnRent(
                                  room.createdByUid,
                                  room.id,
                                  'PENDING',
                                );
                                if (result.isNotEmpty) {
                                  Get.to(
                                    () => SendRequestReturnRoom(
                                      result: result,
                                      room: room,
                                    ),
                                  );
                                } else {
                                  Get.snackbar(
                                    'Thông báo',
                                    'Bạn chưa có yêu cầu trả phòng nào',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              } else if (isRequestRented) {
                                Map<String, dynamic> result =
                                    await FireStoreMethods()
                                        .getTicketRequestRent(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  room.id,
                                  'PENDING',
                                );
                                if (result.isNotEmpty) {
                                  Get.to(
                                    () => SendRequestRentRoom(
                                      room: room,
                                      result: result,
                                    ),
                                  );
                                } else {
                                  Get.snackbar(
                                    'Thông báo',
                                    'Bạn chưa có yêu cầu trả phòng nào',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.white,
                            heroTag: UniqueKey(),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.red,
                              ),
                              borderRadius:
                                  BorderRadius.circular(deviceHeight * 0.1),
                            ),
                            label: const Row(
                              children: [
                                Text(
                                  'Xóa yêu cầu',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (isRequestReturnRent) {
                                Map<String, dynamic> result =
                                    await FireStoreMethods()
                                        .getTicketRequestReturnRent(
                                  room.createdByUid,
                                  room.id,
                                  'PENDING',
                                );

                                Get.defaultDialog(
                                  title: 'Thông báo',
                                  middleText:
                                      'Bạn có chắc chắn muốn xóa yêu cầu trả phòng này?',
                                  textConfirm: 'Xóa',
                                  textCancel: 'Hủy',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () async {
                                    await FireStoreMethods()
                                        .updateStatusTicketRequestReturnRent(
                                      result['id'],
                                      'NOTWORKING',
                                    );
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                    // Get.off(() => RootScreen());
                                  },
                                );
                              } else if (isRequestRented) {
                                Map<String, dynamic> result =
                                    await FireStoreMethods()
                                        .getTicketRequestRent(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  room.id,
                                  'PENDING',
                                );

                                Get.defaultDialog(
                                  title: 'Thông báo',
                                  middleText:
                                      'Bạn có chắc chắn muốn xóa yêu cầu trả phòng này?',
                                  textConfirm: 'Xóa',
                                  textCancel: 'Hủy',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () async {
                                    await FireStoreMethods()
                                        .updateStausTicketRequestRent(
                                      result['id'],
                                      'NOTWORKING',
                                    );
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                    // Get.off(() => RootScreen());
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      )
                    : FirebaseAuth.instance.currentUser!.uid !=
                            room.createdByUid
                        ? FloatingActionButton.extended(
                            backgroundColor: Colors.white,
                            heroTag: UniqueKey(),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: primary40,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            label: const Row(
                              children: [
                                Text(
                                  'Yêu cầu thuê phòng ',
                                  style: TextStyle(color: primary40),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  CupertinoIcons.location_fill,
                                  color: primary40,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              bool isAPPROVED = await FireStoreMethods()
                                  .checkStatusRoom(room.id, 'APPROVED');
                              if (isAPPROVED) {
                                Get.to(
                                  () => SendRequestRentRoom(
                                    room: room,
                                  ),
                                );
                              } else {
                                Get.snackbar(
                                  'Thông báo',
                                  'Phòng này đã được người khác thuê trước bạn đã chậm chân rồi',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                          )
                        : const SizedBox(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              onPressed: () {
                FireStoreMethods().likePost(
                  room.id,
                  FirebaseAuth.instance.currentUser!.uid,
                  room.listLikes,
                );
              },
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
                  //padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                  padding: EdgeInsets.fromLTRB(
                    deviceHeight * 0.02,
                    deviceHeight * 0.02,
                    deviceHeight * 0.02,
                    deviceHeight * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FirebaseAuth.instance.currentUser!.uid ==
                                  room.createdByUid &&
                              (isRequestRented ||
                                  isRequestReturnRent ||
                                  isHandleRequestReturnRoom ||
                                  isHandleRentRoom ||
                                  isRenting)
                          ? TextButton(
                              onPressed: () {
                                if (isHandleRentRoom) {
                                  Get.to(
                                    () => ListRequestRentRoomScreen(
                                      room: room,
                                    ),
                                  );
                                } else if (isHandleRequestReturnRoom) {
                                  Get.to(
                                    () => DetailRequestReturnRoomScreen(
                                      roomId: room.id,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Yêu cầu ${isHandleRentRoom ? 'thuê' : isHandleRequestReturnRoom ? 'trả' : ''} phòng',
                                style: const TextStyle(
                                  color: primary40,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          : const SizedBox(),
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
                      SizedBox(
                        height: deviceHeight * 0.008,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primary98),
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.01,
                          vertical: deviceHeight * 0.01,
                        ),
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
                                SizedBox(
                                  height: deviceHeight * 0.008,
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
                                SizedBox(
                                  height: deviceHeight * 0.008,
                                ),
                                Text(
                                  controller
                                      .priceFormatter(controller.room!.deposit),
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
                      SizedBox(
                        height: deviceHeight * 0.018,
                      ),
                      Text(
                        controller.room!.title,
                        style: const TextStyle(
                            color: secondary20,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.018,
                      ),
                      GestureDetector(
                        onTap: () async {
                          LatLng rs = await controller.getLatLng();
                          Get.to(
                            () => MapScreen(
                              fromDetailRoom: true,
                              lat: rs.latitude,
                              lon: rs.longitude,
                            ),
                          );
                        },
                        child: Row(
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
                          Obx(
                            () => Text(
                              "Số điện thoại: ${controller.owner.value!.phoneNumber}",
                              style: const TextStyle(color: secondary40),
                            ),
                          ),
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
                        linkStyle: const TextStyle(fontWeight: FontWeight.bold),
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
                            formattedDate,
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
                              controller.room!.utilities[index].getIconUtil(),
                              size: 20,
                              color: secondary40,
                            ),
                            label: Text(
                              controller.room!.utilities[index].getNameUtil(),
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
                            child: Row(
                              children: [
                                Text(
                                  room.listComments.isNotEmpty
                                      ? '${room.sumRating / room.listComments.length}'
                                      : '0',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFD21D),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  room.sumRating / room.listComments.length <
                                          2.5
                                      ? 'Tệ'
                                      : room.sumRating /
                                                  room.listComments.length <
                                              4
                                          ? 'Có tiềm năng'
                                          : 'Tốt',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: primary40,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${room.listComments.length} đánh giá',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: secondary40,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => PostReviewScreen(
                                  roomId: room.id,
                                  room: room,
                                ),
                              );
                            },
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
                              () => ProfileOwnerScreen(
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
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.owner.value!.photoUrl),
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
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // them listview o day
                      const Text(
                        'Nội quy phòng',
                        style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: deviceHeight * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => controller.isShowMore.value
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        // bottom: deviceHeight * 0.1,
                                        bottom: deviceHeight * 0.008,
                                      ),
                                      child: SizedBox(
                                        width: deviceWidth * 0.9,
                                        child: Text(
                                          room.regulations,
                                          style: const TextStyle(
                                            color: secondary20,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        bottom: deviceHeight * 0.008,
                                      ),
                                      child: SizedBox(
                                        width: deviceWidth * 0.9,
                                        child: Text(
                                          room.regulations,
                                          style: const TextStyle(
                                            color: secondary20,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  controller.isShowMore.value =
                                      !controller.isShowMore.value;
                                },
                                child: Obx(
                                  () => !controller.isShowMore.value
                                      ? const Text(
                                          'Show less',
                                          style: TextStyle(
                                            color: Colors
                                                .blue, // Màu của nút "Show more"
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const Text(
                                          'Show more',
                                          style: TextStyle(
                                            color: Colors
                                                .blue, // Màu của nút "Show more"
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const Text(
                    '/phòng',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FirebaseAuth.instance.currentUser!.uid != room.createdByUid
                      ? Expanded(
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
                            onPressed: () async {
                              var prefs = await SharedPreferences.getInstance();
                              String userId = prefs.getString(
                                      KeyValue.KEY_ACCOUNT_PHONENUMBER) ??
                                  '';
                              Get.to(ChatScreen(
                                conversationID:
                                    controller.owner.value!.phoneNumber,
                                conversationName:
                                    controller.owner.value!.username,
                                userId: userId,
                              ));
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
                        )
                      : Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(red90),
                                foregroundColor:
                                    MaterialStateProperty.all(red50),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                            onPressed: () async {
                              Get.defaultDialog(
                                title: 'Thông báo',
                                middleText:
                                    'Bạn có chắc chắn muốn xóa phòng trọ này?',
                                textConfirm: 'Xóa',
                                textCancel: 'Hủy',
                                confirmTextColor: Colors.white,
                                buttonColor: primary40,
                                backgroundColor: primary98,
                                cancelTextColor: primary40,
                                onConfirm: () async {
                                  FireStoreMethods()
                                      .updateStatusRoom(room.id, 'DELETED');
                                  Get.back();
                                  Get.back();
                                },
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Xóa'),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 8,
                  ),
                  FirebaseAuth.instance.currentUser!.uid != room.createdByUid
                      ? Expanded(
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
                        )
                      : Expanded(
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
                                Icon(
                                  Icons.edit,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Sửa'),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
                          color: controller.activeImageIdx.value == 0
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
                          color: controller.activeImageIdx.value == 1
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
                          color: controller.activeImageIdx.value == 2
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
