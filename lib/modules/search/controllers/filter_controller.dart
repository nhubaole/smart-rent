import 'package:get/get.dart';
import 'package:smart_rent/core/enums/filter_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/filter/filter.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/model/room/util_item.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:tiengviet/tiengviet.dart';

class FilterController extends GetxController {
  late String location;
  var filter = Filter().obs;
  var selectedFilter = Rx<FilterType?>(FilterType.PRICE);

  List<UtilItem> utilList = const [
    UtilItem(utility: Utilities.WC, isChecked: false),
    UtilItem(utility: Utilities.WINDOW, isChecked: false),
    UtilItem(utility: Utilities.WIFI, isChecked: false),
    UtilItem(utility: Utilities.KITCHEN, isChecked: false),
    UtilItem(utility: Utilities.LAUNDRY, isChecked: false),
    UtilItem(utility: Utilities.FRIDGE, isChecked: false),
    UtilItem(utility: Utilities.PARKING, isChecked: false),
    UtilItem(utility: Utilities.SECURITY, isChecked: false),
    UtilItem(utility: Utilities.FLEXIBLE_HOURS, isChecked: false),
    UtilItem(utility: Utilities.PRIVATE, isChecked: false),
    UtilItem(utility: Utilities.LOFT, isChecked: false),
    UtilItem(utility: Utilities.PET, isChecked: false),
    UtilItem(utility: Utilities.BED, isChecked: false),
    UtilItem(utility: Utilities.WARDROBE, isChecked: false),
    UtilItem(utility: Utilities.AIR_CONDITIONER, isChecked: false)
  ];

  List<FilterType> filterType = [
    FilterType.PRICE,
    FilterType.UTIL,
    FilterType.ROOM_TYPE,
    FilterType.CAPACITY,
    FilterType.SORT,
  ];

  void setLocation(String location) {
    this.location = location;
  }
}
