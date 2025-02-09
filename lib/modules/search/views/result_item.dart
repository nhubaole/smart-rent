import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '/core/enums/gender.dart';


class ResultItem extends StatelessWidget {
  final RoomModel room;
  final Function(RoomModel) onTap;
  const ResultItem({
    super.key,
    required this.room,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(room),
      child: Stack(
        children: [
          _buildMainContent(),
          if (room.status == 0)
          _buildLabel(),
        ],
      ),
    );
  }

  Positioned _buildLabel() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
        decoration: BoxDecoration(
          color: AppColors.primary40,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            bottomRight: Radius.circular(20.px),
          ),
        ),
        child: const Text(
          'Có thể dọn vào NGAY',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container _buildMainContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 32.px,
        right: 8.px,
        left: 8.px,
        bottom: 8.px,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.px),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              SizedBox(width: 16.px),
              _buildInfo(),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.primary40,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '4.2',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.star,
                color: AppColors.rating,
                size: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondary60,
            ),
            children: [
              TextSpan(text: 'Good'),
              TextSpan(text: ' • '),
              TextSpan(text: '24 đánh giá'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildCapacity(),
          _buildTitle(),
          _buildAddress(),
          _buildPrice(),
        ],
      ),
    );
  }

  Text _buildPrice() {
    return Text(
      'từ ${room.totalPrice?.toStringTotalthis()}',
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.primary60,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _buildAddress() {
    return Text(
      room.addresses?.join(", ") ?? room.address ?? "Chưa cập nhật",
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 10, color: AppColors.secondary20),
      maxLines: 2,
    );
  }

  Text _buildTitle() {
    return Text(
      room.title!.isEmpty ? "Chưa cập nhật" : room.title!,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.secondary20,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
    );
  }

  Text _buildCapacity() {
    return Text(
      'Số người ở: ${room.capacity}',
      style: const TextStyle(fontSize: 10, color: AppColors.secondary60),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.secondary80.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(12.0.px),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0.px),
        child: CachedNetworkImage(
          height: 120.px,
          width: 120.px,
          fit: BoxFit.cover,
          imageUrl: room.images![0],
        ),
      ),
    );
  }

  String getCapacity(RoomModel room) {
    return room.gender == Gender.ALL
        ? "${room.capacity} NAM/NỮ"
        : "${room.capacity} ${InfoGender.fromInt(room.gender!).getNameGender}";
  }

  String priceFormatterFull(RoomModel room) {
    String formattedNumber = room.totalPrice.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return "$formattedNumber ₫/phòng";
  }
}
