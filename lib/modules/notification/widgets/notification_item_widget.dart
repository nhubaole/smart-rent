import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/notification_type.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/notification_model.dart';
import 'package:smart_rent/core/values/image_assets.dart';

// enum contentType {
//   RENT_ROOM,
//   NEW_ROOM,
//   PAYMENT,
//   REQUEST_RETURN_ROOM,
// }

// ignore: must_be_immutable
class NotificationItemWidget extends StatelessWidget {
  final Function(NotificationModel) onTap;
  final NotificationModel data;

  const NotificationItemWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  String get description {
    String description = '';
    switch (data.type!) {
      case NotificationType.CONTRACT:
        description = 'Mã Hợp đồng';
      case NotificationType.RENTAL_REQUEST:
        description = 'Mã yêu cầu thuê phòng';
      case NotificationType.RETURN_REQUEST:
        description = 'Mã yêu cầu trả phòng';
      case NotificationType.PAYMENT:
      case NotificationType.BILL:
        description = 'Mã thanh toán';
      case NotificationType.NULL:
        description = 'Mã';
      // TODO: Handle this case.
    }
    return '$description ${data.referenceId}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(data),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.02,
        ),
        child: Container(
          // shape: RoundedRectangleBorder(
          //   side: const BorderSide(
          //     color: Colors.transparent,
          //   ),
          //   borderRadius: BorderRadius.circular(15),
          // ),
          padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 4.px),
          decoration: BoxDecoration(
            color: data.isRead ?? false
              ? Colors.black.withOpacity(0.1)
                : AppColors.primary98,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70.px,
                  width: 70.px,
                  child: Lottie.asset(
                    data.type?.icon ?? ImageAssets.lottieEmpty,
                    repeat: true,
                    reverse: true,
                    height: Get.height * 0.2,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title ?? '--',
                        style: TextStyle(
                          color: AppColors.secondary20,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: AppColors.secondary60,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        data.createdAt!.ddMMyyyy,
                        style: const TextStyle(
                          color: AppColors.secondary40,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
