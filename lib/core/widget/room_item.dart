import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/modules/detail/controllers/detail_controller.dart';
import '../config/app_colors.dart';
import '/core/model/room/room.dart';
import '/core/values/app_colors.dart';

class RoomItem extends StatefulWidget {
  final Room room;
  final bool isLiked;
  final bool isRequestRented;
  final bool isRequestReturnRent;
  final bool isHandleRequestReturnRoom;
  final bool isHandleRentRoom;
  final bool isRenting;

  const RoomItem({
    super.key,
    required this.room,
    required this.isLiked,
    required this.isRequestRented,
    required this.isRequestReturnRent,
    required this.isHandleRequestReturnRoom,
    required this.isHandleRentRoom,
    required this.isRenting,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  late bool isLiked;
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: AppColors.splashColor,
          onTap: () async {
            Get.toNamed(
              AppRoutes.detail,
              arguments: DetailAgrument(
                isRequestReturnRent: widget.isRequestReturnRent,
                isRequestRented: widget.isRequestRented,
                room: widget.room,
                isHandleRequestReturnRoom: widget.isHandleRequestReturnRoom,
                isHandleRentRoom: widget.isHandleRentRoom,
                isRenting: widget.isRenting,
              ),
            );
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 1.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              _buildImage(),
              _buildButtonLike(),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          _buildContent()
        ],
      ),
    );
  }

  Column _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRatingComponent(),
        SizedBox(height: 1.h),
        _buildTitle(),
        _buildTotalPrice(),
        _buildAddress(),
      ],
    );
  }

  Text _buildAddress() {
    return Text(
      widget.room.address!.join(' '),
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary40,
      ),
    );
  }

  Widget _buildTotalPrice() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Giá chỉ từ: ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary40,
            ),
          ),
          TextSpan(
            text: widget.room.totalPrice?.toFormattedPrice(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary40,
            ),
          ),
        ],
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      widget.room.title!,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.secondary20,
      ),
    );
  }

  Row _buildRatingComponent() {
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 1.w),
          decoration: BoxDecoration(
            color: AppColors.primary40,
            borderRadius: BorderRadius.circular(1.w),
          ),
          padding: EdgeInsets.all(0.5.w),
          child: Row(
            children: [
              const Text(
                'rating',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 0.1.w,
              ),
              const Icon(
                Icons.star,
                color: AppColors.rating,
                size: 16,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          0.toStringRatingType,
          style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondary20,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Container(
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            color: AppColors.secondary40,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        const Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '5',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary40,
                    fontWeight: FontWeight.w600)),
            TextSpan(text: ' '),
            TextSpan(
              text: 'đánh giá',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w600),
            )
          ]),
        ),
      ],
    );
  }

  Positioned _buildButtonLike() {
    Widget? icon;
    if (isLiked) {
      icon = const Icon(
        Icons.favorite,
        color: AppColors.like,
      );
    } else {
      icon = const Icon(
        Icons.favorite_outline,
        color: AppColors.like,
      );
    }
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        iconSize: 30,
        color: isLiked ? red60 : Colors.white,
        onPressed: () {
          setState(() {
            isLiked = !isLiked;
          });
        },
        icon: icon,
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColors.like),
        ),
        child: CacheImageWidget(
          imageUrl: widget.room.roomImages![0],
        ),
      ),
    );
  }
}
