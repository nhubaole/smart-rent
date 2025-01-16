import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/config/app_images.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/extension/boolean_extension.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/view_image_dialog.dart';
import 'package:smart_rent/modules/detail/widgets/button_action_navbar.dart';
import '/modules/detail/controllers/detail_controller.dart';

class DetailPage extends GetView<DetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: ScaffoldWidget(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: Obx(
          () => _buildWidgetState(),
        ),
        bottomNavigationBar: Obx(
          () => Visibility(
            visible: controller.isLoadingData.value == LoadingType.LOADED,
            child: _buildBottomNavigationBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    if (controller.room != null) {
      return _buildActionContact();
    }
    return const SizedBox();
  }

  Widget _buildWidgetState() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildBody();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async {
            await controller.reselectRoom(controller.room!.id);
          },
          child: const ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageCollection(),
          _buildContentRoom(),
        ],
      ),
    );
  }

  Widget _buildActionContact() {
    return Container(
      padding:
          EdgeInsets.only(left: 16.px, right: 16.px, bottom: 12.px, top: 12.px),
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.primary40,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.px),
          topLeft: Radius.circular(20.px),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text.rich(
              style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                children: [
                  TextSpan(
                    text: controller.room!.totalPrice
                        ?.toStringTotalthis(symbol: 'đ'),
                  ),
                  TextSpan(
                    text: '/phòng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.isOwner
              ? Row(
                  children: [
                    ButtonActionNavbar(
                      title: 'Xóa',
                      onTap: controller.onDeleteRoom,
                      backgroundColor: AppColors.red90,
                      textColor: AppColors.red50,
                      padding: EdgeInsets.symmetric(horizontal: 8.px),
                      leading: Icon(
                        Icons.delete_sharp,
                        color: AppColors.red50,
                        size: 16.px,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    ButtonActionNavbar(
                      title: 'Sửa',
                      onTap: controller.onEditRoom,
                      backgroundColor: AppColors.secondary90,
                      textColor: AppColors.secondary40,
                      padding: EdgeInsets.symmetric(horizontal: 8.px),
                      leading: Icon(
                        Icons.edit,
                        color: AppColors.secondary40,
                        size: 16.px,
                      ),
                    ),
                  ],
                )
              : controller.canRent
                  ? ButtonActionNavbar(
                      title: 'Thuê phòng trọ ngay',
                      onTap: controller.onRentNow,
                      backgroundColor: AppColors.primary98,
                      textColor: AppColors.primary40,
                    )
                  : SizedBox()
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStateProperty.all(AppColors.primary98),
          //     foregroundColor: WidgetStateProperty.all(AppColors.primary40),
          //     padding: WidgetStateProperty.all(
          //       EdgeInsets.symmetric(
          //         horizontal: 16.px,
          //         vertical: 12.px,
          //       ),
          //     ),
          //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(
          //           10.0,
          //         ),
          //       ),
          //     ),
          //   ),
          //   onPressed: () async {},
          //   child: const Text('Thuê phòng trọ ngay'),
          // ),
        ],
      ),
    );
  }

  Widget _buildContentRoom() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRoomTypeAndCapacity(),
          SizedBox(height: 0.8.h),
          _buildAvailableAndArea(),
          SizedBox(height: 1.8.h),
          _buildTitle(),
          SizedBox(height: 1.8.h),
          _buildListRoomNumer(),
          SizedBox(height: 1.8.h),
          _buildAvailableToRent(),
          SizedBox(height: 1.8.h),
          _buildAddress(),
          SizedBox(height: 1.8.h),
          _buildPhone(),
          SizedBox(height: 1.8.h),
          _buildPriceUtilities(),
          SizedBox(height: 1.8.h),
          _buildDescription(),
          SizedBox(height: 1.8.h),
          _buildCreatedDate(),
          SizedBox(height: 1.8.h),
          _buildUtilities(),
          SizedBox(height: 1.8.h),
          _buildRating(),
          SizedBox(height: 1.8.h),
          _buildOwner(),
          SizedBox(height: 1.8.h),
          _buildSuggestRoom(),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget _buildAvailableToRent() {
    if (controller.room!.availableFrom == null) {
      return const SizedBox();
    }
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.thumbsUp,
          color: AppColors.secondary40,
          size: 24.px,
        ),
        SizedBox(width: 2.w),
        const Text.rich(
          TextSpan(
            style: TextStyle(
              color: AppColors.secondary40,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            children: [
              TextSpan(text: 'Có thể dọn vào '),
              TextSpan(
                text: 'NGAY',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListRoomNumer() {
    return SizedBox(
      width: double.infinity,
      height: 35.px,
      child: ListView.separated(
        itemCount: controller.room!.roomNumbers!.keys.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.px),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final key = controller.room!.roomNumbers!.keys.elementAt(index);
          final roomID = controller.room!.roomNumbers![key];
          return InkWell(
            onTap: () async {
              await controller.reselectRoom(roomID);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.px),
                color: controller.room!.id == roomID
                    ? AppColors.primary98
                    : AppColors.secondary90,
              ),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: controller.room!.id == roomID
                        ? AppColors.primary40
                        : AppColors.secondary40,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(text: '${'room'.tr} '),
                    TextSpan(text: key.toString()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestRoom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Đề xuất',
          style: TextStyle(
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 1.8.h),
        _buildSuggestRoomStatus(),
      ],
    );
  }

  Widget _buildSuggestRoomStatus() {
    switch (controller.isLoadingSuggestRoom.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        if (controller.suggestRooms == null ||
            controller.suggestRooms!.isEmpty) {
          return const SizedBox();
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.spaceEvenly,
            runSpacing: 1.h,
            spacing: 4.px,
            children: controller.suggestRooms!.map<Widget>(
              (room) {
                return RoomItem(
                  minHeight: 20.h,
                  width: double.infinity,
                  room: room,
                  onTap: () async {
                    await controller.reselectRoom(room.id);
                  },
                );
              },
            ).toList(),
          ),
        );
      // return SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   scrollDirection: Axis.horizontal,
      //   child: SizedBox(
      //     height: double,
      //     child: ListView.separated(
      //       shrinkWrap: true,
      //       physics: const NeverScrollableScrollPhysics(),
      //       scrollDirection: Axis.horizontal,
      //       itemCount: controller.suggestRooms!.length,
      //       separatorBuilder: (context, index) => SizedBox(
      //         width: 2.w,
      //       ),
      //       itemBuilder: (context, index) {
      //         final room = controller.suggestRooms![index];
      //         return RoomItem(room: room, isLiked: false);
      //       },
      //     ),
      //   ),
      // );
      case LoadingType.ERROR:
        return const ErrorCustomWidget();
      default:
        return const SizedBox();
    }
  }

  InkWell _buildOwner() {
    return InkWell(
      onTap: () {
        // Get.to(
        //   () => ProfileOwnerScreen(
        //     uidOwner: controller.owner.value!.uid,
        //   ),
        // );
        Get.toNamed(AppRoutes.ratingUser, arguments: {
          'user_id': controller.room!.owner!.id,
        });
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary98),
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 2.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              CachedNetworkImageProvider(
                            controller.owner.avatarUrl ?? AppImages.demo,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: List.generate(
                            controller.owner.totalRating ?? 0,
                            (index) => Icon(
                              Icons.star,
                              color: AppColors.rating,
                              size: 16.px,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userModel.fullName!,
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.secondary20,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${controller.room!.roomNumbers?.length ?? '--'} phòng trọ',
                            style: const TextStyle(
                              color: AppColors.primary60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: controller.onChatOwner,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary40,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Chat',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Icon(
                                Icons.message_outlined,
                                color: Colors.white,
                                size: 14.px,
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 2.w),
                    InkWell(
                      onTap: controller.onCallOwner,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary90,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.secondary80,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Gọi',
                                style: TextStyle(
                                  color: AppColors.secondary60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Icon(
                                Icons.phone_outlined,
                                color: AppColors.secondary60,
                                size: 14.px,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildRating() {
    // if (controller.rating == null) {
    //   return const SizedBox();
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Đánh giá',
          style: TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        SizedBox(height: 4.px),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: 10.w),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.primary40,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Text(
                    '${controller.rating?.totalRating?.toInt() ?? 0}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(width: 2.w),
                  const Icon(
                    Icons.star,
                    color: Color(0xFFFFD21D),
                  )
                ],
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    controller.ratingOveview,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary40,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 0.5.h),
                  const Text(
                    'đánh giá',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.secondary40,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (controller.rating != null)
            InkWell(
              onTap: () {

                Get.toNamed(AppRoutes.rating, arguments: {
                  'rating': controller.rating,
                });
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
      ],
    );
  }

  Column _buildPolicy() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            controller.room!.description!,
            expandText: 'Xem thêm',
            collapseText: 'Rút gọn',
            maxLines: 3,
            linkColor: AppColors.primary40,
            linkStyle: const TextStyle(fontWeight: FontWeight.bold),
            style: const TextStyle(color: AppColors.secondary40),
          ),
        ),
      ],
    );
  }

  Widget _buildUtilities() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tiện ích',
          style: TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        SizedBox(height: 4.px),
        GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: controller.room!.utilities!.length,
          itemBuilder: (context, index) {
            final item = controller.room!.utilities![index];
            return FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: AppColors.secondary90,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                print(item);
                print(controller.room);
              },
              icon: Icon(
                item.getIconUtil,
                size: 20,
                color: AppColors.secondary40,
              ),
              label: Text(
                item.getNameUtil,
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary40,
                    fontWeight: FontWeight.w500),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildCreatedDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ngày đăng',
          style: TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.secondary40,
            ),
            const SizedBox(width: 4),
            Text(
              controller.room!.createAt?.ddMMyyyy ?? '--',
              style: const TextStyle(color: AppColors.secondary40),
            )
          ],
        ),
      ],
    );
  }

  Column _buildDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller.room!.description!,
          expandText: 'Xem thêm',
          collapseText: 'Rút gọn',
          maxLines: 2,
          linkColor: AppColors.primary40,
          linkStyle: const TextStyle(fontWeight: FontWeight.bold),
          style: const TextStyle(color: AppColors.secondary40),
        ),
      ],
    );
  }

  Container _buildPriceUtilities() {
    return Container(
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
                  controller.room!.electricityCost!.toInt(),
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
                  controller.room!.waterCost!.toFormattedPrice,
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
                controller.priceFormatter(controller.room!.parkingFee!.toInt()),
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
                controller
                    .priceFormatter(controller.room!.internetCost!.toInt()),
                style: const TextStyle(
                  color: AppColors.primary60,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Row _buildPhone() {
    return Row(
      children: [
        const Icon(
          Icons.phone_outlined,
          color: AppColors.secondary40,
        ),
        const SizedBox(width: 4),
        Text(
          "Số điện thoại: ${controller.room!.owner?.phoneNumber ?? '--'}",
          style: const TextStyle(color: AppColors.secondary40),
        )
      ],
    );
  }

  Text _buildTitle() {
    return Text(
      controller.room!.title!,
      style: const TextStyle(
          color: AppColors.secondary20,
          fontSize: 20,
          fontWeight: FontWeight.w600),
    );
  }

  GestureDetector _buildAddress() {
    return GestureDetector(
      onTap: controller.onOpenMap,
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
                text: controller.room!.addresses?.join(', '),
                style: const TextStyle(color: AppColors.secondary40),
              ),
              TextSpan(
                  text: " Chỉ đường",
                  style: const TextStyle(
                      color: AppColors.primary40, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()),
            ]),
          ))
        ],
      ),
    );
  }

  Container _buildAvailableAndArea() {
    return Container(
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
                controller.room!.isRent!.getStatusRoom.tr,
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
                '${controller.room!.area?.getAcreage ?? 0} m2',
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
                controller.room!.deposit!.toFormattedPrice,
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
    );
  }

  Row _buildRoomTypeAndCapacity() {
    return Row(
      children: [
        Expanded(
            child: Text(
          controller.room!.roomType ?? '--',
          style: const TextStyle(
            color: AppColors.secondary40,
            fontSize: 12,
          ),
        )),
        Text(
          '${controller.room!.capacity!} ${InfoGender.fromInt(controller.room!.gender!).getNameGender}',
          style: const TextStyle(
            color: AppColors.secondary40,
            fontSize: 12,
          ),
        )
      ],
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
        Obx(
          () => IconButton(
            onPressed: controller.onLikeAction,
            icon: Icon(
              controller.isLiked.value
                  ? Icons.favorite_sharp
                  : Icons.favorite_outline,
              color:
                  controller.isLiked.value ? AppColors.red60 : AppColors.white,
            ),
          ),
        )
      ],
      title: const Text(
        "Chi tiết phòng",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildImageCollection() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40.px),
        bottomRight: Radius.circular(40.px),
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
          border: Border.all(
            width: 1,
            color: AppColors.transparent,
          ),
        ),
        child: Row(
          children: [
            ...controller.room!.images!.mapIndexed<Widget>(
              (index, imgUrl) {
                return index == controller.room!.images!.length - 1
                    ? Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CacheImageWidget(
                                imageUrl: controller.room!.images!.last,
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
                                    '${controller.room!.images!.length - controller.maximumPreivewList}+',
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
                                    Container(
                                      color: AppColors.secondary20,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Center(
                                          child: CacheImageWidget(
                                            imageUrl: imgUrl,
                                            fit: BoxFit.cover,
                                            height: 90,
                                          ),
                                        ),
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
            ),
          ],
        ),
      ),
    );
  }

  InkWell _buildPrimaryImage() {
    return InkWell(
      onTap: () {
        ViewImageDialog.show(
          urls: controller.room!.images!,
        );
      },
      child: Obx(
        () => CachedNetworkImage(
          imageUrl: controller.room!.images![controller.activeImageIdx.value],
          height: Get.width + 50,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned _buildOnNextImage() {
    return Positioned(
      right: 1.w,
      top: Get.width / 2,
      child: IconButton.filled(
        onPressed: () {
          if (controller.activeImageIdx < controller.room!.images!.length - 1) {
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
