import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_popular_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePopularWidget extends StatefulWidget {
  const HomePopularWidget({super.key});

  @override
  State<HomePopularWidget> createState() => _HomePopularWidgetState();
}

class _HomePopularWidgetState extends State<HomePopularWidget> {
  final HomePopularController controller = Get.put(HomePopularController());
  @override
  Widget build(BuildContext context) {
    controller.fetchDataAndConvertToList();
    return Column(
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
              itemCount: controller.dataList.length,
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
                          image: NetworkImage(
                              controller.dataList[index]['photoUrl'] as String),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.dataList[index]['address']
                                      as String,
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
    );
  }
}
