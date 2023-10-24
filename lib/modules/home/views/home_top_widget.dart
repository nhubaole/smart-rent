import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_top_controller.dart';
import 'package:smart_rent/modules/home/views/home_feature_nav_widget.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeTopWidgetController controller =
        Get.put(HomeTopWidgetController());
    controller.getSharedPreferences();
    controller.getCurrentLocation();

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primary40,
                primary80,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
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
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Obx(
                              () => Text(
                                controller.currenLocation.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    // chuong thong bao
                    Container(
                      decoration: BoxDecoration(
                        color: primary95,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notification_add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // search bar
              Container(
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
