import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/model/review_ticket/review_ticket.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class ReviewRoomController extends GetxController {
  ReviewRoomController({
    required this.invoice,
  });
  final Invoice invoice;
  var room = Rx<Room?>(null);
  late ReviewTicket reviewTicket;
  late TextEditingController titleController;

  @override
  void onInit() async {
    titleController = TextEditingController();
    getRoom();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }

  Future<void> getRoom() async {
    room.value = await FireStoreMethods().getRoomById(invoice.roomId);
    reviewTicket = ReviewTicket(
      id: 'id',
      roomId: invoice.roomId,
      title: '',
      invoiceId: invoice.orderCode.toString(),
      userId: invoice.buyerId,
      content: '',
      rating: 0,
      createdAt: 0,
      image: room.value!.images,
    );
  }

  void submitReview() async {
    DateTime now = DateTime.now().toUtc();
    final timeStamp = now.millisecondsSinceEpoch ~/ 1000;
    reviewTicket = reviewTicket.copyWith(
      title: room.value!.title,
      content: titleController.text,
      createdAt: timeStamp,
    );
    await FireStoreMethods().addReviewTicket(reviewTicket);
    await FireStoreMethods().updateRatingRoom(
      room.value!.id,
      room.value!.sumRating + reviewTicket.rating,
    );
    Get.offAll(() => const RootScreen());
  }
}
