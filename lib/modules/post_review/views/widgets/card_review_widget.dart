import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/post_review/controllers/widgets_controller/card_review_widget_controller.dart';

class CardReviewWidget extends StatelessWidget {
  final Map<String, dynamic> review;
  CardReviewWidget({super.key, required this.review});
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    final cardReviewWidgetController =
        Get.put(CardReviewWidgetController(review: review));
    var date = DateTime.fromMillisecondsSinceEpoch(review['createdAt'] * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return Card(
      elevation: 0,
      color: primary98,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(deviceWidth * 0.01),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.02,
          vertical: deviceHeight * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: deviceWidth * 0.075,
                    backgroundImage: CachedNetworkImageProvider(
                      cardReviewWidgetController.profileOwner.value!.photoUrl,
                    ),
                  ),
                ),
                Gap(deviceWidth * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        cardReviewWidgetController.profileOwner.value!.username,
                        style: const TextStyle(
                          color: secondary20,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text(
                      'Xác nhận đã thuê',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 241, 65),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                RatingBar.builder(
                  initialRating: review['rating'] * 1.0,
                  minRating: 1,
                  itemSize: 25,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: deviceWidth * 0.01,
                  ),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
            Gap(deviceWidth * 0.02),
            Text(
              review['content'] ?? 'No content available',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(deviceWidth * 0.02),
            Text(
              formattedDate,
              style: const TextStyle(
                color: secondary60,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
