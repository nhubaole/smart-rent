import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:smart_rent/core/model/room/room_model.dart';

import '../../../core/config/app_colors.dart';
import '/modules/post_review/controllers/post_review_screen_controller.dart';
import '/modules/post_review/views/widgets/card_review_widget.dart';

// ignore: must_be_immutable
class PostReviewScreen extends StatelessWidget {
  PostReviewScreen({
    super.key,
    required this.roomId,
    required this.room,
  });
  final String roomId;
  final RoomModel room;
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    final postReviewController = Get.put(PostReviewController(roomId: roomId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary98,
        title: Obx(
          () => Text(
            'Bài đánh giá (${postReviewController.counter})',
            style: const TextStyle(
              color: AppColors.primary40,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.04,
            vertical: deviceHeight * 0.01,
          ),
          child: Center(
            child: Obx(
              () => postReviewController.isLoading.value
                  ? const CircularProgressIndicator(
                      color: AppColors.primary60,
                    )
                  : postReviewController.listReview.value.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RatingSummary(
                              counter: postReviewController.counter.value,
                              average: 0,
                              showAverage: true,
                              counterFiveStars:
                                  postReviewController.counterFiveStars.value,
                              counterFourStars:
                                  postReviewController.counterFourStars.value,
                              counterThreeStars:
                                  postReviewController.counterThreeStars.value,
                              counterTwoStars:
                                  postReviewController.counterTwoStars.value,
                              counterOneStars:
                                  postReviewController.counterOneStars.value,
                            ),
                            SizedBox(
                              height: deviceHeight * 0.05,
                            ),
                            Obx(
                              () => postReviewController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary60,
                                      ),
                                    )
                                  : postReviewController
                                          .listReview.value.isEmpty
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Lottie.asset(
                                                'assets/lottie/empty.json',
                                                repeat: true,
                                                reverse: true,
                                                height: 300,
                                                width: double.infinity,
                                              ),
                                              const Text(
                                                '\nchưa có bài đánh giá nào hết!!!',
                                                style: TextStyle(
                                                  color: AppColors.secondary20,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: postReviewController
                                                  .listReview.value.length +
                                              1,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            if (index <
                                                postReviewController
                                                    .listReview.value.length) {
                                              return CardReviewWidget(
                                                review: postReviewController
                                                    .listReview.value[index],
                                              );
                                            } else {
                                              return Obx(
                                                () => postReviewController
                                                        .isLoadMore.value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: AppColors
                                                              .primary95,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: OutlinedButton(
                                                            onPressed: () {},
                                                            style: ButtonStyle(
                                                              side:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                const BorderSide(
                                                                  color: AppColors
                                                                      .primary40,
                                                                ),
                                                              ),
                                                              shape:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Xem thêm',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primary40,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              );
                                            }
                                          },
                                        ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/empty.json',
                              repeat: true,
                              reverse: true,
                              height: 300,
                              width: double.infinity,
                            ),
                            const Text(
                              '\nchưa có bài đánh giá nào hết!!!',
                              style: TextStyle(
                                color: AppColors.secondary20,
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
