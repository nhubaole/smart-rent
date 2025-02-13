import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/tracking_rental_process_stepper_widget.dart';
import 'package:smart_rent/modules/track_rental_process/track_rental_process_controller.dart';

class TrackRentalProcessPage extends GetView<TrackRentalProcessController> {
  const TrackRentalProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'track_rental_process'.tr),
      body: Obx(() => _buildWidgetStatus()),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 32.px),
                  _buildInfoRoom(),
                  SizedBox(height: 32.px),
                  const Divider(
                    color: AppColors.secondary80,
                    thickness: 0.5,
                    height: 0,
                  ),
                  SizedBox(height: 8.px),
                ],
              ),
            ),
          ];
        },
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailStatus(),
            SizedBox(height: 4.px),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(bottom: 32.px),
                child: TrackingRentalProcessStepperWidget(
                  processTrackings: controller.processTrackings,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetStatus() {
    switch (controller.isFetchingDetailProcessTracking.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildBody();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async => controller.fetchDetailProcess(),
          child: ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
    }
  }

  Align _buildDetailStatus() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18.sp,
          color: AppColors.grey20,
          fontWeight: FontWeight.w600,
        ),
        TextSpan(text: 'status_details'.tr),
      ),
    );
  }

  Row _buildInfoRoom() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 2.w),
        Flexible(
          child: CacheImageWidget(
            imageUrl: controller.processTrackingModel?.room?.images?.first ??
                ImageAssets.demo,
            borderRadius: BorderRadius.circular(20.px),
            height: 120.px,
            width: 120.px,
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${'number_of_people'.tr}: ${controller.processTrackingModel?.room?.capacity ?? 0}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                controller.processTrackingModel?.room?.title ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.processTrackingModel?.room?.addresses?.join(', ') ??
                    '',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.processTrackingModel!.room!.totalPrice!
                    .toStringTotalthis(symbol: 'VND/ tháng'),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
