import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import '/core/model/location/ward.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchRoomController extends GetxController {
  final RxList<String> searchResult = <String>[].obs;

  final RxList<String> address = <String>[].obs;
  final ValueNotifier<List<String>> searchRecently = ValueNotifier([]);
  final label = ''.obs;

  TextEditingController textController = TextEditingController();

  Future<List<String>> loadAddress() async {
    var jsonString = await rootBundle.loadString('assets/data/wards.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Ward.fromJson(json).path_with_type).toList();
  }

  @override
  void onInit() async {
    address.value = await loadAddress();
    await getRecent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  onSearchTextChanged(String text) {
    label.value = text;
    searchResult.clear();
    getRecent();
    if (text.isEmpty) {
      return;
    }

    List<String> res = [];
    for (var address in address) {
      if (TiengViet.parse(address)
          .toLowerCase()
          .contains(TiengViet.parse(text.toLowerCase()))) res.add(address);
    }
    searchResult.addAll(res);
    print("======= ${searchResult.length}");
  }

  Future<void> saveRecent(String recent) async {
    List<String> recentList =
        HiveManager().get(AppConstant.hiveRecentSearchRoomKey) ?? [];
    recentList.insert(0, recent);
    await HiveManager().put(AppConstant.hiveRecentSearchRoomKey, recentList);
  }

  Future<void> getRecent() async {
    searchRecently.value =
        HiveManager().get(AppConstant.hiveRecentSearchRoomKey) ?? [];
  }

  Future<void> removeRecent(String recent) async {
    final updatedList = List<String>.from(searchRecently.value);
    updatedList.remove(recent);
    searchRecently.value = updatedList;

    await HiveManager().put(AppConstant.hiveRecentSearchRoomKey, updatedList);
  }
}
