import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/home/controllers/home_list_room_controller.dart';
import 'package:smart_rent/modules/home/controllers/home_screen_controller.dart';
import 'package:smart_rent/modules/home/views/home_list_room.dart';
import 'package:smart_rent/modules/home/views/home_popular_widget.dart';
import 'package:smart_rent/modules/home/views/home_top_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());
  // final HomeListRoomController listRoomController =
  //     Get.put(HomeListRoomController());

  @override
  void initState() {
    super.initState();
    //listRoomController.getListRoom();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // top widget
            HomeTopWidget(),
            // pho bien
            HomePopularWidget(),
            //list room
            HomeListRoomWidget(),
          ],
        ),
      ),
    );
  }
}
