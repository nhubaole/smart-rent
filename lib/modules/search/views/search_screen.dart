import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    _userDetails = await loadAddress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width - 80,
                decoration: BoxDecoration(
                    border: Border.all(color: primary60, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: 'Tìm theo phường/xã, địa điểm,...',
                        border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Hủy',
                  style: TextStyle(
                      fontSize: 16,
                      color: primary60,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: secondary80, width: 1))),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                  ResultScreen(location: _searchResult[index]));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: secondary40,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  _searchResult[index],
                                  style: TextStyle(
                                      color: secondary20, fontSize: 18),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox()),
        ],
      ),
    ));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (TiengViet.parse(userDetail)
          .toLowerCase()
          .contains(TiengViet.parse(text.toLowerCase())))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

  List<String> _searchResult = [];

  List<String> _userDetails = [];

  Future<List<String>> loadAddress() async {
    var jsonString = await rootBundle.loadString('assets/data/wards.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Ward.fromJson(json).path).toList();
  }
}
