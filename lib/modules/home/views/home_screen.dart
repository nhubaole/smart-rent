import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  // final HomeListRoomController listRoomController =
  //     Get.put(HomeListRoomController());

  @override
  void initState() {
    super.initState();
    //listRoomController.getListRoom();
  }

  @override
  Widget build(BuildContext context) {
    bool _showFab = true;

    return Scaffold(
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _showFab ? Offset.zero : Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (scrollNotification) {
          scrollNotification.direction == ScrollDirection.reverse
              ? _showFab = false
              : _showFab = true;
          setState(() {});
          print(
              scrollNotification); // prints all scroll Notification states for each frame
          return false; // result is the same regardless of whether this is true, false or null
        },
        child: const SingleChildScrollView(
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
      ),
    );
  }

  _onStartScroll(ScrollMetrics metrics) {
    print("Scroll Start");
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    print("Scroll Update");
  }

  _onEndScroll(ScrollMetrics metrics) {
    print("Scroll End");
  }
}
