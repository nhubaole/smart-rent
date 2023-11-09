import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/post_review/controllers/post_review_screen_controller.dart';
import 'package:smart_rent/modules/post_review/views/widgets/card_review_widget.dart';

class PostReviewScreen extends StatelessWidget {
  const PostReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostReviewController postReviewController =
        Get.put(PostReviewController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary98,
        title: const Text(
          'Bài đánh giá',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Gap(20),
                RatingSummary(
                  counter: postReviewController.counter.value,
                  average: 3.846,
                  showAverage: true,
                  counterFiveStars: 5,
                  counterFourStars: 4,
                  counterThreeStars: 2,
                  counterTwoStars: 1,
                  counterOneStars: 1,
                ),
                const Gap(20),
                // ListView.separated(
                //   shrinkWrap: true,
                //   itemBuilder: (BuildContext context, index) {
                //     return CardReviewWidget(
                //       name: 'QuocDanh',
                //       note: 'Good room',
                //       photoUrl:
                //           'https://images.unsplash.com/photo-1699482360781-47a3c8fe5736?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                //       value: 3.5,
                //       reviewText: 'Phòng sạch sẽ, 💯 điểm không có nhưng',
                //       timeText: DateTime.now().toString(),
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, index) =>
                //       const Divider(
                //     color: secondary60,
                //   ),
                //   itemCount: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
