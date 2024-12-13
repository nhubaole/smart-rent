import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/detail/controllers/detail_controller.dart';
import '/core/enums/gender.dart';
import '/core/model/room/room.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.detail,
          arguments: DetailAgrument(
            isRequestReturnRent: false,
            isRequestRented: false,
            isHandleRequestReturnRoom: false,
            isHandleRentRoom: false,
            isRenting: false,
            room: room,
          ),
        );
      },
      child: Stack(
        children: [
          _buildMainContent(),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: AppColors.primary40,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              const SizedBox(
                width: 16,
              ),
              _buildInfo()
            ],
          ),
          _buildRating()
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
      'từ ${priceFormatterFull(room)}',
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.primary60,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _buildAddress() {
    return Text(
      room.address!.isEmpty
          ? "Chưa cập nhật"
          : room.address!.map((e) => e).join(", "),
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
      'Số người ở: ${getCapacity(room)}',
      style: const TextStyle(fontSize: 10, color: AppColors.secondary60),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.secondary80.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: CachedNetworkImage(
          height: 120,
          width: 120,
          fit: BoxFit.cover,
          imageUrl: room.roomImages![0],
        ),
      ),
    );
  }

  String getCapacity(Room room) {
    return room.gender == Gender.ALL
        ? "${room.capacity} NAM/NỮ"
        : "${room.capacity} ${InfoGender.fromInt(room.gender!).getNameGender()}";
  }

  String priceFormatterFull(Room room) {
    String formattedNumber = room.totalPrice.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return "$formattedNumber ₫/phòng";
  }
}
