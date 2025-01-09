import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/sort.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/room/util_item.dart';

class FilterRoomModel {
  double? minPrice;
  double? maxPrice;
  List<UtilItem>? utilItems;
  RoomType? roomType;
  Gender? gender;
  Sort? sort;

  FilterRoomModel({
    this.minPrice,
    this.maxPrice,
    this.roomType,
    this.gender,
    this.sort,
    List<UtilItem>? utilItems,
  }) : utilItems = utilItems ?? utilList;

  FilterRoomModel copyWith({
    double? minPrice,
    double? maxPrice,
    List<UtilItem>? utilItems,
    RoomType? roomType,
    Gender? gender,
    Sort? sort,
  }) {
    return FilterRoomModel(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      utilItems: utilItems ?? this.utilItems,
      roomType: roomType ?? this.roomType,
      gender: gender ?? this.gender,
      sort: sort ?? this.sort,
    );
  }

  static List<UtilItem> utilList = [
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

  void toggleUtilItemCheck(Utilities utility) {
    utilItems = utilItems?.map((utilItem) {
      if (utilItem.utility == utility) {
        return utilItem.copyWith(isChecked: !utilItem.isChecked);
      }
      return utilItem;
    }).toList();
  }
}
