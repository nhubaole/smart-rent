import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class MapLocationRoomDetailSheet extends StatelessWidget {
  final RoomModel room;
  const MapLocationRoomDetailSheet({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.px,
          right: 16.px,
          left: 16.px,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildImages(),
            SizedBox(height: 2.h),
            _buildTitle(),
            SizedBox(height: 1.h),
            _buildAddress(),
            SizedBox(height: 1.h),
            _buildPrice(),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  Align _buildPrice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Giá: ${room.totalPrice?.toStringTotalPrice} VNĐ',
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 18.sp,
        ),
      ),
    );
  }

  Align _buildAddress() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text('Địa chỉ: ${room.address}',
          style: TextStyle(
            color: AppColors.secondary20,
            fontSize: 16.sp,
          )),
    );
  }

  Align _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        room.title!,
        style: const TextStyle(
            color: AppColors.secondary20,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  CarouselSlider _buildImages() {
    return CarouselSlider(
      options: CarouselOptions(height: 20.h),
      items: room.images!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.px),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.px),
                child: CachedNetworkImage(
                  imageUrl: i,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.isBottomSheetOpen! ? Get.back() : null;
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(
              AppRoutes.detail,
              arguments: {
                'id': room.id,
              },
            );
          },
          child: Text(
            'Xem chi tiết',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primary40,
            ),
          ),
        ),
      ],
    );
  }
}
