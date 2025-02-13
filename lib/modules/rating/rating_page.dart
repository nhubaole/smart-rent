import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/rating/rating_controller.dart';
import 'package:smart_rent/modules/rating/widgets/rating_item_widget.dart';

class RatingPage extends GetView<RatingController> {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWidget(
        appBar: CustomAppBar(title: 'Bài đánh giá'),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16.px),
          child: Column(
            children: [
              _buildRatingOverview(),
              SizedBox(height: 16.px),
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 16.px),
                padding: EdgeInsets.symmetric(horizontal: 16.px),
                shrinkWrap: true,
                itemCount: controller.rating.ratingInfo?.length ?? 0,
                itemBuilder: (context, index) {
                  final ratingInfo = controller.rating.ratingInfo![index];
                  return RatingItemWidget(
                    ratingInfo: ratingInfo,
                    onTapNavUser: controller.onNavRatingUser,
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Container _buildRatingOverview() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.px),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary60.withOpacity(0.5),
            blurRadius: 2.px,
            offset: Offset(0, 1.px),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    controller.rating.avgRating.toString(),
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: AppColors.secondary20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.px),
                  Icon(
                    Icons.star,
                    color: AppColors.rating,
                    size: 40.px,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.px,
                  vertical: 4.px,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary40,
                  borderRadius: BorderRadius.circular(100.px),
                ),
                child: Text(
                  '${controller.rating.ratingInfo?.length} đánh giá',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.px),
          Column(
            children: controller.rating.detailCount?.entries
                    .toList()
                    .reversed
                    .map((entry) {
                  return _buildValueRatingLevel(
                    {entry.key: entry.value},
                    controller.rating.detailCount!.length,
                  );
                }).toList() ??
                [],
          ),
        ],
      ),
    );
  }

  Row _buildValueRatingLevel(Map<String, int> value, int length) {
    return Row(
      children: [
        Text(
          value.keys.first,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 4.px),
        Icon(
          Icons.star,
          color: AppColors.rating,
          size: 20.px,
        ),
        SizedBox(width: 4.px),
        SizedBox(
          width: (Get.width - 120.px) * value.values.first / length,
          child: Container(
            width: double.infinity,
            height: 6.px,
            decoration: BoxDecoration(
              color: AppColors.rating,
              borderRadius: BorderRadius.circular(100.px),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary98,
                  AppColors.primary95,
                  AppColors.primary80,
                  AppColors.primary60,
                  AppColors.primary40,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
