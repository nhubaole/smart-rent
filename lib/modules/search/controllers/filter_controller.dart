import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/filter_room_model.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/modules/search/views/capacity_filter_page.dart';
import 'package:smart_rent/modules/search/views/price_filter_page.dart';
import 'package:smart_rent/modules/search/views/room_type_filter_page.dart';
import 'package:smart_rent/modules/search/views/sort_filter_page.dart';
import 'package:smart_rent/modules/search/views/util_filter_page.dart';
import 'package:smart_rent/modules/search/widgets/filter_sheet.dart';
import '/core/enums/filter_type.dart';
import '/core/enums/gender.dart';
import '/core/enums/room_type.dart';
import '/core/enums/sort.dart';
import '/core/enums/utilities.dart';
import '/core/model/filter/capacity_filter.dart';
import '/core/model/filter/filter.dart';
import '/core/model/filter/price_filter.dart';
import '/core/model/filter/room_type_filter.dart';
import '/core/model/filter/sort_filter.dart';
import '/core/model/filter/util_filter.dart';
import '/core/model/room/util_item.dart';

class FilterController extends GetxController {
  String? location;
  String? locationNormal;

  final results = Rx<List<RoomModel>>([]);
  final sourceResults = Rx<List<RoomModel>>([]);

  final filter = const Filter().obs;
  final filterStringList = RxList<Map<String, dynamic>>([]);
  final itemFilterCount = 0.obs;
  final selectedFilter = Rx<FilterType?>(FilterType.PRICE);
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  final filterModel = Rxn<FilterRoomModel>();
  final capacityController = TextEditingController(text: '1');
  late TextEditingController searchController;


  RxList<UtilItem> utilList = const [
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
  ].obs;

  List<FilterType> filterType = [
    FilterType.PRICE,
    FilterType.UTIL,
    FilterType.ROOM_TYPE,
    FilterType.CAPACITY,
    FilterType.SORT,
  ];

  final currentRangeValues = const RangeValues(0, 50000000).obs;
  final fromPriceTextController = TextEditingController();
  final toPriceTextController = TextEditingController();
  final quantity = 1.obs;
  final genderIdx = 0.obs;
  final isLoadingType = LoadingType.INIT.obs;

  @override
  void onInit() {
    final args = Get.arguments;
    location = args['location'];
    locationNormal = args['location'];
    selectedFilter.value = null;
    searchController = TextEditingController(text: location ?? '');
    queryRoomByLocation();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void setLocation(String location) {
    this.location = location;
  }

  void setPrice(RangeValues values) {
    currentRangeValues.value = values;
    int startValue = currentRangeValues.value.start.round();
    int endValue = currentRangeValues.value.end.round();
    fromPriceTextController.text = currencyFormat.format(startValue);
    toPriceTextController.text = currencyFormat.format(endValue);
    filter.value = filter.value.copyWith(
        priceFilter: PriceFilter(fromPrice: startValue, toPrice: endValue));
    convertFilterToListString();
  }

  void setUtil() {
    filter.value = filter.value.copyWith(
      utilFilter: UtilFilter(
          listUtils: utilList
              .where((util) => util.isChecked)
              .map((util) => util.utility)
              .toList()),
    );
    convertFilterToListString();
  }

  void setRoomType(RoomType value) {
    filter.value =
        filter.value.copyWith(roomTypeFilter: RoomTypeFilter(roomType: value));
    convertFilterToListString();
  }

  void setCapacity() {
    capacityController.text = quantity.value.toString();
    Gender selectedGender;
    switch (genderIdx.value) {
      case 0:
        selectedGender = Gender.FEMALE;
        break;
      case 1:
        selectedGender = Gender.MALE;
        break;
      case 2:
        selectedGender = Gender.ALL;
        break;
      default:
        selectedGender = Gender.FEMALE;
        break;
    }
    filter.value = filter.value.copyWith(
        capacityFilter:
            CapacityFilter(capacity: quantity.value, gender: selectedGender));
    convertFilterToListString();
  }

  void setSort(Sort value) {
    filter.value = filter.value.copyWith(sortFilter: SortFilter(sort: value));
    convertFilterToListString();
  }

  void convertFilterToListString() {
    filterStringList.clear();
    if (filter.value.priceFilter != null) {
      filterStringList.add({
        "${currencyFormat.format(filter.value.priceFilter!.fromPrice)} - ${currencyFormat.format(filter.value.priceFilter!.toPrice)}":
            filter.value.priceFilter
      });
    }
    if (filter.value.utilFilter != null) {
      for (final item in filter.value.utilFilter!.listUtils) {
        filterStringList.add({item.getNameUtil: item});
      }
    }
    if (filter.value.roomTypeFilter != null) {
      filterStringList.add({
        filter.value.roomTypeFilter!.roomType.value:
            filter.value.roomTypeFilter?.roomType.value
      });
    }
    if (filter.value.capacityFilter != null) {
      if (filter.value.capacityFilter!.gender == Gender.ALL) {
        filterStringList.add({
          "${filter.value.capacityFilter!.capacity} Nam/Nữ":
              filter.value.capacityFilter
        });
      } else {
        filterStringList.add({
          "${filter.value.capacityFilter!.capacity} ${filter.value.capacityFilter!.gender.getNameGender}":
              filter.value.capacityFilter
        });
      }
    }
    if (filter.value.sortFilter != null) {
      filterStringList.add({
        filter.value.sortFilter!.sort.getNameSort(): filter.value.sortFilter
      });
    }
    itemFilterCount.value = filterStringList.length;

    applyFilter();
  }

  void removeFilter(Map<String, dynamic> element) {
    final type = element.values.first.runtimeType;

    if (type == filter.value.priceFilter.runtimeType) {
      filter.value = filter.value.copyWith(priceFilter: null);

      currentRangeValues.value = const RangeValues(0, 50000000);
      int startValue = currentRangeValues.value.start.round();
      int endValue = currentRangeValues.value.end.round();
      fromPriceTextController.text = startValue.toString();
      toPriceTextController.text = endValue.toString();
    } else if (filter.value.utilFilter != null &&
        filter.value.utilFilter!.listUtils.isNotEmpty &&
        type == filter.value.utilFilter!.listUtils[0].runtimeType) {
      List<Utilities> list = [];
      for (final i in filter.value.utilFilter!.listUtils) {
        list.add(i);
      }
      list.remove(element.values.first);
      for (int i = 0; i < utilList.length; i++) {
        if (utilList[i].utility == element.values.first) {
          utilList[i] = utilList[i].copyWith(isChecked: false);
        }
      }
      filter.value =
          filter.value.copyWith(utilFilter: UtilFilter(listUtils: list));
    } else if (type == filter.value.roomTypeFilter.runtimeType) {
      filter.value = filter.value.copyWith(roomTypeFilter: null);
    } else if (type == filter.value.capacityFilter.runtimeType) {
      filter.value = filter.value.copyWith(capacityFilter: null);

      quantity.value = 0;
      genderIdx.value = 0;
    } else if (type == filter.value.sortFilter.runtimeType) {
      filter.value = filter.value.copyWith(sortFilter: null);
    }

    filterStringList.remove(element);
    itemFilterCount.value = filterStringList.length;
  }

  void removeAllFilter() {
    final copyList = filterStringList.toList();
    for (final e in copyList) {
      removeFilter(e);
    }
    selectedFilter.value = null;
  }

  onSearchTextChanged(String text) {
    location = text;
    queryRoomByLocation();
  }

  Future<void> queryRoomByLocation() async {
    try {
      isLoadingType.value = LoadingType.LOADING;
      location = location?.toLowerCase();
      if (location == null) {
        return;
      }
      final rq = await RoomRepoImpl()
          .getRoomsByAddressElasticSearch(address: location!);
      if (rq.isSuccess()) {
        sourceResults.value = rq.data ?? [];
        results.value = sourceResults.value;
        applyFilter();
        isLoadingType.value = LoadingType.LOADED;
      } else {
        if (kDebugMode) {
          Get.snackbar('Error', rq.message ?? 'Error');
        }
        isLoadingType.value = LoadingType.ERROR;
      }
    } catch (e) {
      if (kDebugMode) {
        Get.snackbar('Error', e.toString());
      }
      isLoadingType.value = LoadingType.ERROR;
    }
  }

  void applyFilter() {
    results.value = sourceResults.value;
    if (filter.value.priceFilter != null) {
      results.value = results.value
          .where((element) =>
              element.totalPrice! >= filter.value.priceFilter!.fromPrice &&
              element.totalPrice! <= filter.value.priceFilter!.toPrice)
          .toList();
    }
    if (filter.value.utilFilter != null) {
      results.value = results.value.where((element) {
        for (final i in filter.value.utilFilter!.listUtils) {
          if (element.utilities!.any((filter) => filter == i)) {
          } else {
            return false;
          }
        }
        return true;
      }).toList();
    }
    if (filter.value.roomTypeFilter != null) {
      results.value = results.value
          .where((element) =>
              element.roomType == filter.value.roomTypeFilter!.roomType.value)
          .toList();
    }
    if (filter.value.capacityFilter != null) {
      results.value = results.value
          .where((element) =>
              element.capacity == filter.value.capacityFilter!.capacity &&
              element.gender ==
                  filter.value.capacityFilter!.gender.getNameGenderInt)
          .toList();
    }
    if (filter.value.sortFilter != null) {
      switch (filter.value.sortFilter!.sort) {
        case Sort.MOST_RELATED:
          break;
        case Sort.LATEST:
          results.value.sort((a, b) {
            DateTime aDate = DateTime.parse(a.createAt.toString());
            DateTime bDate = DateTime.parse(b.createAt.toString());
            return aDate.compareTo(bDate);
          });
          break;
        case Sort.HIGHEST_TO_LOWEST:
          results.value.sort((a, b) => b.totalPrice!.compareTo(a.totalPrice!));
          break;
        case Sort.LOWEST_TO_HIGHEST:
          results.value.sort((a, b) => a.totalPrice!.compareTo(b.totalPrice!));
          break;
        default:
          break;
      }
    }
  }

  onSelectedFilterItem(FilterType type) {
    selectedFilter.value = type;
    Get.bottomSheet(
      FilterSheet(
        filterType: type,
        child: loadPageContent(type),
        onClose: () {
          selectedFilter.value = null;
        },
        onApply: () {},
        onReset: () {
          removeAllFilter();
          results.value = sourceResults.value;
        },
      ),
    );
  }

  Widget loadPageContent(FilterType? value) {
    switch (value) {
      case FilterType.PRICE:
        return PriceFilterPage();
      case FilterType.UTIL:
        return UtilFilterPage();
      case FilterType.ROOM_TYPE:
        return RoomTypeFilterPage();
      case FilterType.CAPACITY:
        return CapacityFilterPage();
      case FilterType.SORT:
        return SortFilterPage();
      default:
        return const SizedBox();
    }
  }
}
