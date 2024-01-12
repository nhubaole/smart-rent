import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/home/controllers/home_screen_controller.dart';
import 'package:smart_rent/modules/map/views/map_screen.dart';
import 'package:smart_rent/modules/notification/views/notification_screen.dart';
import 'package:smart_rent/modules/post/views/post_screen.dart';
import 'package:smart_rent/modules/recently/views/recently_view.dart';
import 'package:smart_rent/modules/search/views/search_screen.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeScreenController>();
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
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
            if (notification.dragDetails != null) {
              final delta = notification.dragDetails!.delta.dy;
              if (delta < 0) {
                homeController.isScrollingUp.value = true;
              } else if (delta > 0) {
                homeController.isScrollingUp.value = true;
              }
            }
          } else if (notification is ScrollStartNotification) {
          } else if (notification is ScrollEndNotification) {
            homeController.isScrollingUp.value = false;
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // top widget
              Stack(
                children: [
                  Container(
                    height: deviceHeight * 0.4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          primary40,
                          primary80,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(deviceWidth * 0.1),
                        bottomRight: Radius.circular(deviceWidth * 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.05,
                            vertical: deviceWidth * 0.01,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => RichText(
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Xin chào ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextSpan(
                                            text: homeController
                                                .currentName.value,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.009,
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          width: deviceWidth * 0.7,
                                          child: Text(
                                            homeController.currenLocation.value,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: deviceWidth * 0.13,
                                height: deviceWidth * 0.13,
                                decoration: BoxDecoration(
                                  color: primary95,
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.13),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const NotificationScreen(),
                                    );
                                  },
                                  child: Lottie.asset('assets/lottie/bell.json',
                                      repeat: true,
                                      reverse: true,
                                      height: 50,
                                      width: double.infinity),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // search bar
                        InkWell(
                          onTap: () {
                            Get.to(() => const SearchScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: secondary40,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Tìm theo quận, tên đường, địa điểm',
                                  style: TextStyle(
                                    color: secondary40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(
                                    255, 205, 203, 203), // Màu của bóng mờ
                                blurRadius: 9.0, // Độ mờ của bóng
                                spreadRadius: 3.0, // Độ lan rộng của bóng
                                offset: Offset(0, 2), // Vị trí độ lệch của bóng
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (homeController.isLoadingMap.value ==
                                      false) {
                                    Get.to(
                                      () => MapScreen(
                                        fromDetailRoom: false,
                                        roomInArea:
                                            homeController.listRoomInArea.value,
                                      ),
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Thông báo',
                                      'Hệ thống đang tải dữ liệu',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primary98,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 25,
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.map,
                                        color: primary40,
                                      ),
                                      Text('Bản đồ'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const PostScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primary98,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 25,
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.add_box,
                                        color: primary40,
                                      ),
                                      Text('Đăng bài'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const RecentlyViewScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primary98,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.history,
                                        color: primary40,
                                      ),
                                      Text('Đã xem\ngần đây'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // pho bien
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Phổ biến',
                        style: TextStyle(
                          fontSize: 20,
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  // list Pho Bien
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeController.dataList.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              Get.closeAllSnackbars();
                              Get.snackbar('Notify', 'message');
                            },
                            child: Stack(
                              children: [
                                Hero(
                                  tag: index,
                                  child: FadeInImage(
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: CachedNetworkImageProvider(
                                      homeController.dataList[index]['photoUrl']
                                          as String,
                                    ),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 112,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      bottom: 6,
                                      right: 20,
                                      left: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            homeController.dataList[index]
                                                ['address'] as String,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            //softWrap: true,
                                            // overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(2, 2),
                                                  blurRadius: 3.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //list room
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.05,
                  vertical: deviceHeight * 0.02,
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Phòng nổi bật',
                          style: TextStyle(
                            fontSize: 20,
                            color: secondary20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => homeController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primary95,
                                backgroundColor: Colors.white,
                              ),
                            )
                          : homeController.listRoom.value.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                        'assets/lottie/empty.json',
                                        repeat: true,
                                        reverse: true,
                                        height: 300,
                                        width: double.infinity,
                                      ),
                                      const Text(
                                        'Hệ thống đang cập nhật phòng',
                                        style: TextStyle(
                                          color: secondary20,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w200,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.all(deviceWidth * 0.01),
                                        child: Center(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              homeController.getListRoom(false);
                                            },
                                            style: ButtonStyle(
                                              side: MaterialStateProperty.all(
                                                const BorderSide(
                                                  color: primary40,
                                                ),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Tải lại',
                                              style: TextStyle(
                                                color: primary40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: () {
                                    return homeController.getListRoom(false);
                                  },
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.66,
                                      crossAxisSpacing: 5,
                                      // mainAxisSpacing: 20,
                                    ),
                                    itemCount:
                                        homeController.listRoom.value.length +
                                            1,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          homeController
                                              .listRoom.value.length) {
                                        return RoomItem(
                                          isRenting: false,
                                          isHandleRentRoom: false,
                                          isHandleRequestReturnRoom: false,
                                          isRequestReturnRent: false,
                                          isRequestRented: false,
                                          room: homeController
                                              .listRoom.value[index],
                                          isLiked: homeController
                                              .listRoom.value[index].listLikes
                                              .contains(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                          ),
                                        );
                                      } else {
                                        return Obx(
                                          () => homeController.isLoadMore.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: primary95,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.all(
                                                      deviceWidth * 0.01),
                                                  child: Center(
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        homeController
                                                            .getListRoom(true);
                                                      },
                                                      style: ButtonStyle(
                                                        side:
                                                            MaterialStateProperty
                                                                .all(
                                                          const BorderSide(
                                                            color: primary40,
                                                          ),
                                                        ),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Xem thêm',
                                                        style: TextStyle(
                                                          color: primary40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
