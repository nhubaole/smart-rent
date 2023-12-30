import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/search/views/result_screen.dart';

import '../../../core/model/location/ward.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    _address = await loadAddress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      width: MediaQuery.sizeOf(context).width - 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: primary60, width: 1),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/ic_location.svg'),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              style: const TextStyle(fontSize: 12),
                              controller: controller,
                              decoration: const InputDecoration(
                                  hintText: 'Tìm theo phường/xã, địa điểm,...',
                                  border: InputBorder.none),
                              onChanged: onSearchTextChanged,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.cancel,
                              size: 16,
                              color: secondary40,
                            ),
                            onTap: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      'Hủy',
                      style: TextStyle(
                          fontSize: 14,
                          color: primary60,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: _searchResult.isNotEmpty || controller.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: secondary80, width: 1))),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ResultScreen(
                                      location: _searchResult[index]));
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: secondary40,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        _searchResult[index],
                                        style: const TextStyle(
                                            color: secondary20, fontSize: 14),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const SizedBox()),
            ],
          ),
        )));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var address in _address) {
      if (TiengViet.parse(address)
          .toLowerCase()
          .contains(TiengViet.parse(text.toLowerCase()))) {
        _searchResult.add(address);
      }
    }

    setState(() {});
  }

  final List<String> _searchResult = [];

  List<String> _address = [];

  Future<List<String>> loadAddress() async {
    var jsonString = await rootBundle.loadString('assets/data/wards.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Ward.fromJson(json).path_with_type).toList();
  }
}
