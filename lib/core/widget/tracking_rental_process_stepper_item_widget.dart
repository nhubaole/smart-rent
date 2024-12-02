import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/tracking_rental_type.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';

class TrackingRentalProcessStepperItemWidget extends StatelessWidget {
  final DateTime date;
  final bool isStayedHere;
  final bool? isLast;
  final String? infoParner;
  final TrackingRentalType type;
  const TrackingRentalProcessStepperItemWidget({
    super.key,
    required this.date,
    required this.isStayedHere,
    this.isLast = false,
    this.infoParner,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.px, top: 8.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLeftDateTime(),
          ),
          SizedBox(width: 4.px),
          Expanded(
            child: _buildCenterChecked(),
          ),
          SizedBox(width: 4.px),
          Expanded(
            flex: 4,
            child: _buildRightStringStatus(),
          ),
        ],
      ),
    );
  }

  Column _buildRightStringStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (infoParner != null)
          Text.rich(
            TextSpan(
              text: infoParner,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondary40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Text.rich(
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.grey20,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            text: type.name,
          ),
        ),
      ],
    );
  }

  Column _buildCenterChecked() {
    Widget stayedHereWidget;

    if (isStayedHere) {
      stayedHereWidget = Container(
        width: 30.px,
        height: 30.px,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 8.px),
        decoration: BoxDecoration(
          color: AppColors.primary40,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.px),
        ),
        child: const Center(
          child: Icon(
            Icons.check_outlined,
            color: AppColors.white,
          ),
        ),
      );
    } else {
      stayedHereWidget = Container(
        width: 12.px,
        height: 12.px,
        margin: EdgeInsets.only(bottom: 4.px),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary40,
          shape: BoxShape.circle,
        ),
      );
    }
    if (isLast == true) {
      stayedHereWidget = Container(
        width: 30.px,
        height: 30.px,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.secondary80,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.px),
        ),
        child: const Center(
          child: Icon(
            Icons.check_outlined,
            color: AppColors.secondary60,
          ),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        stayedHereWidget,
        if (!isLast!)
          Column(
            children: [
              SizedBox(height: 4.px),
              Container(
                height: 32.px,
                width: 4.px,
                decoration: BoxDecoration(
                  color: AppColors.primary40,
                  borderRadius: BorderRadius.circular(100.px),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Column _buildLeftDateTime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          date.ddMMyyyy,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          date.hhmm,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
