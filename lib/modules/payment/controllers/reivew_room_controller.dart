import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '/core/model/invoice/invoice.dart';
import '/core/model/review_ticket/review_ticket.dart';

class ReviewRoomController extends GetxController {
  ReviewRoomController({
    required this.invoice,
  });
  final Invoice invoice;
  var room = Rx<RoomModel?>(null);
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
