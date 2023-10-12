import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // top widget
            HomeTopWidget(),
            // pho bien
            HomePopularWidget(),

            HomeListRoomWidget(),
          ],
        ),

        // text Phong noi bat
      ),
    );
  }
}
