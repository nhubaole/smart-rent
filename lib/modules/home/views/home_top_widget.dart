import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_top_controller.dart';
import 'package:smart_rent/modules/home/views/home_feature_nav_widget.dart';
import 'package:smart_rent/modules/notification/views/notification_screen.dart';

import '../../search/views/search_screen.dart';

// ignore: must_be_immutable
class HomeTopWidget extends StatelessWidget {
  HomeTopWidget({super.key});
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(HomeTopWidgetController());
    controller.getSharedPreferences();
    controller.getCurrentLocation();

    return Stack(
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
                                  text: controller.currentName.value,
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
                                  controller.currenLocation.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
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
                        borderRadius: BorderRadius.circular(deviceWidth * 0.13),
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
              const HomeFeatureNavWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
