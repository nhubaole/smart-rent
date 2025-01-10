import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';

class RoomItem extends StatefulWidget {
  final RoomModel room;
  final Function()? onTap;
  final double? width;
  final double? minHeight;
 
  const RoomItem({
    super.key,
    required this.room,
      this.onTap,
      this.width,
      this.minHeight
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
    isLiked = widget.room.isLike ?? false;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final response = await RoomRepoImpl().getLikedRoom(widget.room.id);
    //   if (response.isSuccess()) {
    //     setState(() {
    //       isLiked = !response.data!;
    //     });
    //   }
    // });
  }

  @override
  void didUpdateWidget(covariant RoomItem oldWidget) {
    
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary60.withOpacity(0.6),
            blurRadius: 5.px,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.px),
          splashColor: AppColors.splashColor,
          onTap: () async {
            if (widget.onTap != null) {
              widget.onTap!();
            } else {
              Get.toNamed(
                AppRoutes.detail,
                arguments: {
                  'id': widget.room.id,
                },
              );
            }
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      padding:
          EdgeInsets.only(top: 6.px, left: 6.px, right: 6.px, bottom: 6.px),
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
          SizedBox(height: 8.px),
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
        SizedBox(height: 8.px),
        _buildTitle(),
        _buildTotalPrice(),
        _buildAddress(),
      ],
    );
  }

  Text _buildAddress() {
    return Text(
      widget.room.address ?? widget.room.addresses?.join(', ') ?? '--',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary40,
      ),
    );
  }

  Widget _buildTotalPrice() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Giá chỉ từ: ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary40,
            ),
          ),
          TextSpan(
            text: widget.room.totalPrice?.toStringTotalthis() ?? '',
            style: TextStyle(
              fontSize: 16.sp,
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
      style: TextStyle(
        fontSize: 16.sp,
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
          padding: EdgeInsets.symmetric(vertical: .5.w, horizontal: 1.w),
          child: Row(
            children: [
              Text(
                widget.room.avgRating?.toStringAsFixed(1) ?? '0.0',
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
        if (widget.room.totalRating != null && widget.room.totalRating! > 0)
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
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: widget.room.totalRating?.toString() ?? '0',
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
        color: isLiked ? AppColors.red60 : Colors.white,
        onPressed: () async {
          final response = await RoomRepoImpl().getLikedRoom(widget.room.id);
          if (response.isSuccess()) {
            setState(() {
              isLiked = response.data!;
            });
          }
        },
        icon: icon,
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 120.px,
      ),
      // height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.transparent),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.px),
        child: CacheImageWidget(
          imageUrl: widget.room.images![0],
          shouldExtendCache: true,
        ),
      ),
    );
  }
}
