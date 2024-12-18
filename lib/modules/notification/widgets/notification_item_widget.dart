import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => onTap(data),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.02,
        ),
        child: Card(
          elevation: 0,
          color: data.isRead ?? false
              ? Colors.black.withOpacity(0.1)
              : AppColors.primary98,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.transparent,
            ),
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
                  height: Get.height * 0.1,
                  width: Get.width * 0.2,
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
                        style: const TextStyle(
                          color: AppColors.secondary20,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        data.title ?? '--',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
