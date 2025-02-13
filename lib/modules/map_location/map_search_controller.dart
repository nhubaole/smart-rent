
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/map_location/services/goong_services.dart';

class MapSearchController extends GetxController {
  final RxList<String> searchResult = <String>[].obs;

  final RxList<String> address = <String>[].obs;
  final ValueNotifier<List<String>> searchMapRecently = ValueNotifier([]);
  final label = ''.obs;

  TextEditingController textController = TextEditingController();

  // Future<List<String>> loadAddress() async {
  //   var jsonString = await rootBundle.loadString('assets/data/wards.json');
  //   List<dynamic> jsonList = json.decode(jsonString);
  //   return jsonList.map((json) => Ward.fromJson(json).path_with_type).toList();
  // }

  @override
  void onInit() async {
    // address.value = await loadAddress();
    // await getRecent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  onSearchTextChanged(String text) async {
    label.value = text;
    searchResult.clear();
    // getRecent();
    if (text.isEmpty) {
      return;
    }

    // List<String> res = [];
    // for (var address in address) {
    //   if (TiengViet.parse(address)
    //       .toLowerCase()
    //       .contains(TiengViet.parse(text.toLowerCase()))) res.add(address);
    // }
    // searchResult.addAll(res);
    final res = await GoongServices().getAutoComplete(text);
    if (res.isSuccess()) {
      searchResult.addAll(res.data!);
    }
    print("======= ${searchResult.length}");
  }

  // Future<void> saveRecent(String recent) async {
  //   List<String> recentList =
  //       HiveManager.get(AppConstant.hiveRecentSearchMapKey) ?? [];
  //   recentList.insert(0, recent);
  //   await HiveManager.put(AppConstant.hiveRecentSearchMapKey, recentList);
  // }

  // Future<void> getRecent() async {
  //   searchMapRecently.value =
  //       HiveManager.get(AppConstant.hiveRecentSearchMapKey) ?? [];
  // }

  // Future<void> removeRecent(String recent) async {
  //   final updatedList = List<String>.from(searchMapRecently.value);
  //   updatedList.remove(recent);
  //   searchMapRecently.value = updatedList;

  //   await HiveManager.put(AppConstant.hiveRecentSearchMapKey, updatedList);
  // }
}
