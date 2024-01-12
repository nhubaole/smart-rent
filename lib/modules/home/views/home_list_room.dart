import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/home/controllers/home_list_room_controller.dart';

class HomeListRoomWidget extends StatefulWidget {
  const HomeListRoomWidget({super.key});

  @override
  State<HomeListRoomWidget> createState() => _HomeListRoomWidgetState();
}

class _HomeListRoomWidgetState extends State<HomeListRoomWidget> {
  HomeListRoomController listRoomController = Get.put(HomeListRoomController());
  double deviceHeight = MediaQuery.of(Get.context!).size.height;
  double deviceWidth = MediaQuery.of(Get.context!).size.width;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
