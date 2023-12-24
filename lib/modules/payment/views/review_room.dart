import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/payment/controllers/reivew_room_controller.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class ReviewRoom extends StatelessWidget {
  const ReviewRoom({
    super.key,
    required this.invoice,
  });
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.put(ReviewRoomController(invoice: invoice));
    reviewController.getRoom();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đánh giá phòng đã thuê',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: Obx(
        () => reviewController.room.value != null
            ? SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: CachedNetworkImageProvider(
                          reviewController.room.value!.images[0],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: [
                          Obx(
                            () => Text(
                              reviewController.room.value!.title,
                              style: const TextStyle(
                                color: secondary20,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Text(
                              '${reviewController.room.value!.price}đ/ tháng',
                              style: const TextStyle(
                                color: primary40,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: Obx(
                              () => Text(
                                reviewController.room.value!.location,
                                style: const TextStyle(
                                  color: secondary20,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          reviewController.reviewTicket =
                              reviewController.reviewTicket.copyWith(
                            rating: rating,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: reviewController.titleController,
                          onChanged: (value) {
                            reviewController.reviewTicket =
                                reviewController.reviewTicket.copyWith(
                              content: value,
                            );
                          },
                          decoration: InputDecoration(
                            hintText: 'Nhận xét về phòng trọ này',
                            filled: true,
                            fillColor: secondary90,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: primary95,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: primary95,
                                width: 2,
                              ),
                            ),
                          ),
                          minLines: 3,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Get.offAll(const RootScreen());
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: primary60, width: 1.5),
                            ),
                            child: const Text(
                              'Để sau',
                              style: TextStyle(
                                color: primary60,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          FilledButton(
                            onPressed: () {
                              reviewController.submitReview();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: primary60,
                            ),
                            child: const Text(
                              'Đánh giá',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
