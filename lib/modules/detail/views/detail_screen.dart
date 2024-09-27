import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_images.dart';
import 'package:smart_rent/core/extension/boolean_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/extension/string_extension.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import '../../../core/config/app_colors.dart';
import '/core/values/KEY_VALUE.dart';
import '/core/values/app_colors.dart';
import '/modules/detail/controllers/detail_controller.dart';
import '/modules/handle_rent_room_landlord/views/list_request_rent_room_screen.dart';
import '/modules/handle_return_room_landlord/views/detail_request_return_room_screen.dart';
import '/modules/handle_return_room_tenant/views/send_request_return_room.dart';
import '/modules/post_review/views/post_review_screen.dart';

// ignore: must_be_immutable
class DetailScreen extends GetView<DetailController> {
  const DetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var date = DateTime.fromMillisecondsSinceEpoch(1 * 1000);
    // String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Stack(
          children: [
            _buildFloatingButton(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: Obx(
          () => _buildBody(),
        ),
      ),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildImageCollection(),
              _buildContentRoom(),
            ],
          ),
        ),
        _buildActionContact()
      ],
    );
  }

  Positioned _buildActionContact() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 72,
        width: Get.width,
        decoration: const BoxDecoration(
          color: AppColors.primary40,
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
            1 != controller.room.owner
                ? Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.primary98),
                          foregroundColor:
                              WidgetStateProperty.all(AppColors.primary40),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))),
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        String userId =
                            prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ??
                                '';
                        // Get.to(ChatScreen(
                        //   conversationID:
                        //       controller.owner.value!.phoneNumber,
                        //   conversationName:
                        //       controller.owner.value!.username,
                        //   userId: userId,
                        // ));
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
                          backgroundColor: WidgetStateProperty.all(red90),
                          foregroundColor: WidgetStateProperty.all(red50),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
                          buttonColor: AppColors.primary40,
                          backgroundColor: AppColors.primary98,
                          cancelTextColor: AppColors.primary40,
                          onConfirm: () async {
                            Get.close(2);
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
            1 != controller.room.id
                ? Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.secondary90),
                          foregroundColor:
                              WidgetStateProperty.all(AppColors.secondary40),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
                              WidgetStateProperty.all(AppColors.secondary90),
                          foregroundColor:
                              WidgetStateProperty.all(AppColors.secondary40),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
    );
  }

  Widget _buildContentRoom() {
    return Padding(
      padding: EdgeInsets.fromLTRB(2.h, 2.h, 2.h, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          1 == controller.room.id &&
                  (controller.isRequestRented ||
                      controller.isRequestReturnRent ||
                      controller.isHandleRequestReturnRoom ||
                      controller.isHandleRentRoom ||
                      controller.isRenting)
              ? TextButton(
                  onPressed: () {
                    if (controller.isHandleRentRoom) {
                      Get.to(
                        () => ListRequestRentRoomScreen(
                          room: controller.room,
                        ),
                      );
                    } else if (controller.isHandleRequestReturnRoom) {
                      Get.to(
                        () => DetailRequestReturnRoomScreen(
                          roomId: controller.room.id.toString(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Yêu cầu ${controller.isHandleRentRoom ? 'thuê' : controller.isHandleRequestReturnRoom ? 'trả' : ''} phòng',
                    style: const TextStyle(
                      color: AppColors.primary40,
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
                controller.room.roomType!.toStringRoomType.tr,
                style: const TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 12,
                ),
              )),
              Text(
                '${controller.room.capacity!} ${'male_female'.tr}',
                style: const TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 12,
                ),
              )
            ],
          ),
          SizedBox(height: 0.8.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 1.h,
              vertical: 1.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary98,
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      'available_room'.tr.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.secondary20,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 0.8.h,
                    ),
                    Text(
                      controller.room.isRent!.getStatusRoom.tr,
                      style: const TextStyle(
                          color: AppColors.primary40,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      'acreage'.tr.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.secondary20,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                    Text(
                      '${controller.room.area!.getAcreage} m2',
                      style: const TextStyle(
                        color: AppColors.primary40,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      'deposit'.tr.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.secondary20,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                    Text(
                      controller.room.deposit!.toFormattedPrice(),
                      style: const TextStyle(
                        color: AppColors.primary40,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(height: 1.8.h),
          Text(
            controller.room.title!,
            style: const TextStyle(
                color: AppColors.secondary20,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 1.8.h),
          GestureDetector(
            onTap: () async {
              // LatLng rs = await controller.getLatLng();
              // Get.to(
              //   () => MapScreen(
              //     fromDetailRoom: true,
              //     lat: rs.latitude,
              //     lon: rs.longitude,
              //   ),
              // );
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondary40,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: controller.room.address![0],
                      style: const TextStyle(color: AppColors.secondary40),
                    ),
                    TextSpan(
                        text: " Chỉ đường",
                        style: const TextStyle(
                            color: AppColors.primary40,
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
          const Row(
            children: [
              Icon(
                Icons.phone_outlined,
                color: AppColors.secondary40,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Số điện thoại: 0000",
                style: TextStyle(color: AppColors.secondary40),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary60, width: 1)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_objects_outlined,
                      size: 24,
                      color: AppColors.primary60,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      controller.priceFormatter(
                        controller.room.electricityCost!.toInt(),
                      ),
                      style: const TextStyle(
                        color: AppColors.primary60,
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
                        color: AppColors.primary60,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        controller.room.waterCost!.toFormattedPrice,
                        style: const TextStyle(
                          color: AppColors.primary60,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Icon(
                      Icons.two_wheeler_outlined,
                      size: 24,
                      color: AppColors.primary60,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      controller
                          .priceFormatter(controller.room.parkingFee!.toInt()),
                      style: const TextStyle(
                        color: AppColors.primary60,
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
                      color: AppColors.primary60,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      controller.priceFormatter(
                          controller.room.internetCost!.toInt()),
                      style: const TextStyle(
                        color: AppColors.primary60,
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
                color: AppColors.secondary20,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
          ExpandableText(
            controller.room.description!,
            expandText: 'Xem thêm',
            collapseText: 'Rút gọn',
            maxLines: 2,
            linkColor: AppColors.primary40,
            linkStyle: const TextStyle(fontWeight: FontWeight.bold),
            style: const TextStyle(color: AppColors.secondary40),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Ngày đăng',
            style: TextStyle(
                color: AppColors.secondary20,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
          const Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.secondary40,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'formattedDate',
                style: TextStyle(color: AppColors.secondary40),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Tiện ích',
            style: TextStyle(
                color: AppColors.secondary20,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: controller.room.utilities!.length,
            itemBuilder: (context, index) {
              return FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: AppColors.secondary90,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  // controller.room!.utilities[index].getIconUtil(),
                  Icons.add_ic_call,
                  size: 20,
                  color: AppColors.secondary40,
                ),
                label: const Text(
                  // controller.room!.utilities[index].getNameUtil(),
                  'text',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondary40,
                      fontWeight: FontWeight.w500),
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Nội quy',
            style: TextStyle(
                color: AppColors.secondary20,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary60, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: ExpandableText(
              controller.room.description!,
              expandText: 'Xem thêm',
              collapseText: 'Rút gọn',
              maxLines: 3,
              linkColor: AppColors.primary40,
              linkStyle: const TextStyle(fontWeight: FontWeight.bold),
              style: const TextStyle(color: AppColors.secondary40),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Đánh giá',
            style: TextStyle(
                color: AppColors.secondary20,
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
                    color: AppColors.primary40,
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    Text(
                      'commetn',
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
                    // ignore: prefer_const_constructors
                    Text(
                      'rating',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary40,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'đánh giá',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary40,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => PostReviewScreen(
                      roomId: controller.room.id.toString(),
                      room: controller.room,
                    ),
                  );
                },
                child: const Text(
                  'Xem mọi bài đánh giá',
                  style: TextStyle(
                      color: AppColors.primary40,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              // Get.to(
              //   () => ProfileOwnerScreen(
              //     uidOwner: controller.owner.value!.uid,
              //   ),
              // );
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary98),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: CachedNetworkImageProvider(
                        AppImages.demo,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'controller.owner.value!.username',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.secondary20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '0 phòng',
                            style: TextStyle(
                              color: AppColors.primary60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: AppColors.secondary20,
                    )
                  ],
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Đề xuất',
            style: TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary40,
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
    );
  }

  Positioned _buildFloatingButton() {
    return Positioned(
      bottom: 10.h,
      right: 1.h,
      child: controller.isRenting
          ? FloatingActionButton.extended(
              backgroundColor: Colors.white,
              heroTag: UniqueKey(),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 2,
                  color: AppColors.primary60,
                ),
                borderRadius: BorderRadius.circular(10.h),
              ),
              label: const Row(
                children: [
                  Text(
                    'Yêu cầu trả phòng',
                    style: TextStyle(color: AppColors.primary60),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Icon(
                    Icons.wifi_protected_setup_rounded,
                    color: AppColors.primary60,
                  ),
                ],
              ),
              onPressed: () {
                Get.to(
                  () => SendRequestReturnRoom(
                    room: controller.room,
                  ),
                );
              },
            )
          : controller.isRequestReturnRent || controller.isRequestRented
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
                          width: 1,
                          color: AppColors.primary40,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: const Row(
                        children: [
                          Text(
                            'Sửa yêu cầu ',
                            style: TextStyle(color: AppColors.primary40),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            CupertinoIcons.location_fill,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                    SizedBox(height: 1.h),
                    FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      heroTag: UniqueKey(),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(16),
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
                        // if (isRequestReturnRent) {
                        //   Map<String, dynamic> result =
                        //       await FireStoreMethods()
                        //           .getTicketRequestReturnRent(
                        //     room.createdByUid,
                        //     room.id,
                        //     'PENDING',
                        //   );

                        //   Get.defaultDialog(
                        //     title: 'Thông báo',
                        //     middleText:
                        //         'Bạn có chắc chắn muốn xóa yêu cầu trả phòng này?',
                        //     textConfirm: 'Xóa',
                        //     textCancel: 'Hủy',
                        //     confirmTextColor: Colors.white,
                        //     onConfirm: () async {
                        //       await FireStoreMethods()
                        //           .updateStatusTicketRequestReturnRent(
                        //         result['id'],
                        //         'NOTWORKING',
                        //       );
                        //       Get.back();
                        //       Get.back();
                        //       Get.back();
                        //       // Get.off(() => RootScreen());
                        //     },
                        //   );
                        // } else if (isRequestRented) {
                        //   Map<String, dynamic> result =
                        //       await FireStoreMethods()
                        //           .getTicketRequestRent(
                        //     FirebaseAuth.instance.currentUser!.uid,
                        //     room.id,
                        //     'PENDING',
                        //   );

                        //   Get.defaultDialog(
                        //     title: 'Thông báo',
                        //     middleText:
                        //         'Bạn có chắc chắn muốn xóa yêu cầu trả phòng này?',
                        //     textConfirm: 'Xóa',
                        //     textCancel: 'Hủy',
                        //     confirmTextColor: Colors.white,
                        //     onConfirm: () async {
                        //       await FireStoreMethods()
                        //           .updateStausTicketRequestRent(
                        //         result['id'],
                        //         'NOTWORKING',
                        //       );
                        //       Get.back();
                        //       Get.back();
                        //       Get.back();
                        //       // Get.off(() => RootScreen());
                        //     },
                        //   );
                        // }
                      },
                    ),
                  ],
                )
              : 1 != controller.room.id
                  ? FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      heroTag: UniqueKey(),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: AppColors.primary40,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: const Row(
                        children: [
                          Text(
                            'Yêu cầu thuê phòng ',
                            style: TextStyle(color: AppColors.primary40),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            CupertinoIcons.location_fill,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        // bool isAPPROVED = await FireStoreMethods()
                        //     .checkStatusRoom(room.id, 'APPROVED');
                        // if (isAPPROVED) {
                        //   Get.to(
                        //     () => SendRequestRentRoom(
                        //       room: room,
                        //     ),
                        //   );
                        // } else {
                        //   Get.snackbar(
                        //     'Thông báo',
                        //     'Phòng này đã được người khác thuê trước bạn đã chậm chân rồi',
                        //     backgroundColor: Colors.red,
                        //     colorText: Colors.white,
                        //   );
                        // }
                      },
                    )
                  : const SizedBox(),
    );
  }

  Widget _buildImageCollection() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          _buildPrimaryImage(),
          _buildOnPreviousImage(),
          _buildOnNextImage(),
          _buildPreviewImageInList(),
        ],
      ),
    );
  }

  Positioned _buildPreviewImageInList() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 90,
        width: Get.width,
        padding: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.red),
        ),
        child: Row(
          children: [
            ...controller.room.roomImages!.mapIndexed<Widget>(
              (index, imgUrl) {
                return index == controller.room.roomImages!.length - 1
                    ? Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CacheImageWidget(
                                imageUrl: controller.room.roomImages!.last,
                                fit: BoxFit.cover,
                                height: 90,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                child: Center(
                                  child: Text(
                                    '${controller.room.roomImages!.length - controller.maximumPreivewList}+',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : index < controller.maximumPreivewList
                        ? Expanded(
                            child: InkWell(
                              onTap: () => controller.setActiveImageIdx(index),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: CacheImageWidget(
                                        imageUrl: imgUrl,
                                        fit: BoxFit.cover,
                                        height: 90,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: controller
                                                      .activeImageIdx.value ==
                                                  index
                                              ? Colors.black.withOpacity(0.2)
                                              : Colors.transparent,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
              },
            ).toList(),
          ],
        ),
      ),
    );
  }

  InkWell _buildPrimaryImage() {
    return InkWell(
      onTap: () {
        MultiImageProvider multiImageProvider = MultiImageProvider(
            controller.room.roomImages!
                .map((url) => NetworkImage(url))
                .toList(),
            initialIndex: controller.activeImageIdx.value);
        showImageViewerPager(
          Get.context!,
          multiImageProvider,
          onPageChanged: (page) {},
          onViewerDismissed: (page) {},
        );
      },
      child: CachedNetworkImage(
        imageUrl: controller.room.roomImages![controller.activeImageIdx.value],
        height: Get.width + 50,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned _buildOnNextImage() {
    return Positioned(
      right: 1.w,
      top: Get.width / 2,
      child: IconButton.filled(
        onPressed: () {
          if (controller.activeImageIdx <
              controller.room.roomImages!.length - 1) {
            controller.activeImageIdx.value += 1;
          }
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.black,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 5,
          overlayColor: AppColors.grey40,
          side: const BorderSide(
            color: AppColors.grey40,
            width: 0.1,
          ),
          shadowColor: AppColors.grey20,
        ),
      ),
    );
  }

  Positioned _buildOnPreviousImage() {
    return Positioned(
      left: 1.w,
      top: Get.width / 2,
      child: IconButton.filled(
        onPressed: () {
          if (controller.activeImageIdx > 0) {
            controller.activeImageIdx.value -= 1;
          }
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 5,
          overlayColor: AppColors.grey40,
          side: const BorderSide(
            color: AppColors.grey40,
            width: 0.1,
          ),
          shadowColor: AppColors.grey20,
        ),
      ),
    );
  }
}
