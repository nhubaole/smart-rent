import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/home/controllers/home_screen_controller.dart';
import 'package:smart_rent/modules/home/views/home_list_room.dart';
import 'package:smart_rent/modules/home/views/home_popular_widget.dart';
import 'package:smart_rent/modules/home/views/home_top_widget.dart';
import 'package:smart_rent/modules/search/views/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController controller = Get.find<HomeScreenController>();
  // final HomeListRoomController listRoomController =
  //     Get.put(HomeListRoomController());

  @override
  void initState() {
    super.initState();
    //listRoomController.getListRoom();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeScreenController>();

    return Scaffold(
      floatingActionButton: Obx(
        () => !homeController.isScrollingUp.value
            ? FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () {
                  Get.to(
                    const SearchScreen(),
                    preventDuplicates: true,
                    curve: Curves.easeInBack,
                  );
                })
            : FloatingActionButton.extended(
                label: const Row(
                  children: [Icon(Icons.search), Text('Tìm phòng trọ ngay')],
                ),
                onPressed: () {
                  Get.to(
                    const SearchScreen(),
                  );
                }),
      ),
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            // Check if the user is scrolling up or down based on delta
            if (notification.dragDetails != null) {
              final delta = notification.dragDetails!.delta.dy;
              if (delta < 0) {
                // Scrolling up
                homeController.isScrollingUp.value = true;
                print('Scrolling Up');
              } else if (delta > 0) {
                // Scrolling down
                homeController.isScrollingUp.value = true;
                print('Scrolling Down');
              }
            }
          } else if (notification is ScrollStartNotification) {
            // When scrolling starts
            //homeController.isScrollingUp.value = true;
          } else if (notification is ScrollEndNotification) {
            // When scrolling ends
            homeController.isScrollingUp.value = false;
          }
          return true; // Return true to continue handling the notification
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
}
