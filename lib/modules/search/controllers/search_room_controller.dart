import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_rent/core/model/location/ward.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRoomController extends GetxController {
  final RxList<String> searchResult = <String>[].obs;

  final RxList<String> address = <String>[].obs;
  final RxList<String> searchRecently = <String>[].obs;

  TextEditingController textController = TextEditingController();
  RxString textfieldString = ''.obs;
  late SharedPreferences _prefs;

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
    textController.addListener(() {
      textfieldString.value = textController.text;
    });
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    getRecent();
    if (text.isEmpty) {
      return;
    }

    List<String> res = [];
    address.forEach((address) {
      if (TiengViet.parse(address)
          .toLowerCase()
          .contains(TiengViet.parse(text.toLowerCase()))) res.add(address);
    });
    searchResult.addAll(res);
    print("======= ${searchResult.length}");
  }

  Future<void> saveRecent(String recent) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recentList = prefs.getStringList('recentSearch') ?? [];
    recentList.add(recent);
    await prefs.setStringList('recentSearch', recentList);
  }

  Future<void> getRecent() async {
    final prefs = await SharedPreferences.getInstance();
    searchRecently.value = prefs.getStringList('recentSearch') ?? [];
  }

  Future<void> removeRecent(String recent) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recentList = prefs.getStringList('recentSearch') ?? [];
    recentList.remove(recent);
    await prefs.setStringList('recentSearch', recentList);
    searchRecently.value = recentList;
  }
}
