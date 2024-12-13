import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class BillCollectionItem extends StatelessWidget {
  final Function() onTap;
  const BillCollectionItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.px),
      splashColor: AppColors.splash,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.px),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.secondary80),
          borderRadius: BorderRadius.circular(12.px),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildOverviewBill(),
            Divider(
              color: AppColors.secondary80.withOpacity(0.5),
              thickness: 1,
              height: 16.px,
            ),
            Column(
              children: [
                _buildRowInfo(
                  icon: Icons.location_on_outlined,
                  title: 'Số 9 Nguyễn Văn Huyên, Dịch Vọng, Cầu Giấy, Hà Nội',
                ),
                Divider(
                  color: AppColors.secondary80.withOpacity(0.5),
                  thickness: 1,
                  height: 16.px,
                ),
                _buildRowInfo(
                  icon: Icons.add_home_outlined,
                  title: 'Phòng số 3.11',
                ),
                Divider(
                  color: AppColors.secondary80.withOpacity(0.5),
                  thickness: 1,
                  height: 16.px,
                ),
                _buildRowInfo(
                  icon: Icons.attach_money_outlined,
                  title: '3,560,000đ',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary60, size: 24.px),
        SizedBox(width: 8.px),
        Expanded(
          child: Text.rich(
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
            ),
            TextSpan(text: title),
          ),
        ),
      ],
    );
  }

  Row _buildOverviewBill() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: 'bill_collection_for_month'.tr),
                  const TextSpan(text: ' '),
                  const TextSpan(text: '7/2024')
                ],
              ),
            ),
            Text.rich(
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                style: TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 15.sp,
                ),
                children: [
                  TextSpan(
                    text: 'creation_time'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  const TextSpan(
                    text: '13:49 17/09/2023',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Text.rich(
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 15.sp,
                ),
                children: [
                  TextSpan(
                    text: 'payment_deadline'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  const TextSpan(
                    text: '13:49 17/09/2023',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Expanded(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xff1E2731),
          ),
        ),
      ],
    );
  }
}
