import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/widget/skeleton_widget.dart';

class RoomItemSkeleton extends StatelessWidget {
  const RoomItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Skeleton(
            height: 12.h,
            cornerRadius: 8,
          ),
          SizedBox(height: 0.5.h),
          Skeleton(
            height: 2.h,
            cornerRadius: 4,
          ),
          SizedBox(height: 0.5.h),
          Skeleton(
            height: 4.h,
            cornerRadius: 4,
          ),
        ],
      ),
    );
  }
}
