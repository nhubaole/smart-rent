import 'package:get/get.dart';
import 'package:smart_rent/core/enums/gender.dart';

import '../../../core/model/room/room.dart';

class DetailController extends GetxController {
  final Room room;

  DetailController({required this.room});

  Rx<int> activeImageIdx = 0.obs;

  String getCapacity() {
    return room.gender == Gender.ALL
        ? "${room.capacity} Nam/Nữ"
        : "${room.capacity} ${room.gender.getNameGender()}";
  }

  String getStatus() {
    return room.isRented ? "Hết" : "Còn";
  }

  String priceFormatter(int price) {
    if (price <= 0) {
      return "Miễn phí";
    } else if (price < 1000) {
      return "${price}₫";
    } else if (price >= 1000 && price < 1000000) {
      return "${price / 1000}k";
    } else {
      return "${price / 1000000}tr";
    }
  }

  String priceFormatterFull() {
    String formattedNumber = room.price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return formattedNumber + " ₫";
  }

  // String getNumberPhone(){

  // }
}
