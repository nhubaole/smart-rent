import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class CardReviewWidget extends StatelessWidget {
  final String photoUrl;
  final String name;
  final String note;
  final double value;
  final String reviewText;
  final String timeText;
  const CardReviewWidget(
      {super.key,
      required this.photoUrl,
      required this.name,
      required this.note,
      required this.value,
      required this.reviewText,
      required this.timeText});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: primary98,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    photoUrl,
                  ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: secondary20,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      note,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 59, 241, 65),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                RatingBar.builder(
                  initialRating: value,
                  minRating: 1,
                  itemSize: 25,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 10,
                  ),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
            const Gap(10),
            Text(
              reviewText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(10),
            Text(
              timeText,
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
