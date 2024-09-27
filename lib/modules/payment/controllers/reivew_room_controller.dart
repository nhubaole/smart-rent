import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/model/invoice/invoice.dart';
import '/core/model/review_ticket/review_ticket.dart';
import '/core/model/room/room.dart';

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

  Future<void> getRoom() async {}
}
