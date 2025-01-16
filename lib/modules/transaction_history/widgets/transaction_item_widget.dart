import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/model/payment/payment_all_model.dart';
import 'package:smart_rent/core/values/image_assets.dart';

class TransactionItemWidget extends StatelessWidget {
  final Function() onTap;
  final PaymentAllModel transaction;
  const TransactionItemWidget({
    super.key,
    required this.onTap,
    required this.transaction,
  });

  String get getType {
    if (transaction.contractId != null) {
      return 'Hợp đồng';
    }
    if (transaction.billId != null) {
      return 'Hoá đơn';
    }
    if (transaction.returnRequestId != null) {
      return 'Yêu cầu trả phòng';
    }
    return '';
  }

  String get getIcon {
    if (transaction.contractId != null) {
      return ImageAssets.icKyHopDong;
    }
    if (transaction.billId != null) {
      return ImageAssets.icDatLichXemPhong;
    }
    if (transaction.returnRequestId != null) {
      return ImageAssets.icTerm;
    }
    return ImageAssets.icThoaThuanChuNha;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.px),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        constraints: BoxConstraints(minHeight: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.px),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              getIcon,
              width: 30.px,
              height: 30.px,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.transferContent ?? '',
                    style: TextStyle(
                      color: AppColors.primary40,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Loại giao dịch: $getType',
                    style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    transaction.paidTime?.hhmmDDMMyyyy ?? '',
                    style: TextStyle(
                      color: AppColors.secondary60,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              transaction.amount?.toStringTotalthis(symbol: 'đ') ?? '',
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
