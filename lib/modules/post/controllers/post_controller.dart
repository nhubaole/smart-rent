import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';

import '../../../core/model/room/room.dart';

class PostController extends GetxController {
  var room =
      Room(roomType: RoomType.DORMITORY_HOMESTAY, gender: Gender.ALL).obs;

  var isElectricityFree = false.obs;
  var isWaterFree = false.obs;
  var isInternetFree = false.obs;
  var hasParking = false.obs;
  var isParkingFree = false.obs;

  final GlobalKey<FormState> formInfoKey = GlobalKey<FormState>();

  var capacityTextController = TextEditingController();
  var areaTextController = TextEditingController();
  var priceTextController = TextEditingController();
  var depositTextController = TextEditingController();
  var electricityCostTextController = TextEditingController();
  var waterCostTextController = TextEditingController();
  var internetCostTextController = TextEditingController();
  var parkingFeeTextController = TextEditingController();

  String? fieldValidator(String value) {
    return value.isEmpty ? 'Vui lòng nhập đầy đủ thông tin' : null;
  }

  void onSelectRoomType(RoomType value) {
    room.value = room.value.copyWith(roomType: value);
  }

  void onSelectGender(Gender value) {
    room.value = room.value.copyWith(gender: value);
  }

  void updateInfoRoom() {
    room.value = room.value.copyWith(
        capacity: int.parse(capacityTextController.text),
        area: double.parse(areaTextController.text),
        price: int.parse(priceTextController.text),
        deposit: int.parse(depositTextController.text),
        electricityCost: int.parse(electricityCostTextController.text),
        waterCost: int.parse(waterCostTextController.text),
        internetCost: int.parse(internetCostTextController.text),
        parkingFee: int.parse(parkingFeeTextController.text));
  }
}
