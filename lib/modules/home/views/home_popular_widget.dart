import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_popular_controller.dart';

class HomePopularWidget extends StatefulWidget {
  const HomePopularWidget({super.key});

  @override
  State<HomePopularWidget> createState() => _HomePopularWidgetState();
}

class _HomePopularWidgetState extends State<HomePopularWidget> {
  final HomePopularController controller = Get.put(HomePopularController());
  @override
  Widget build(BuildContext context) {
    // controller.fetchDataAndConvertToList();
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
              itemCount: 10,
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
                    onTap: () {},
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'meal.id',
                          // child: FadeInImage(
                          //   placeholder: MemoryImage(kTransparentImage),
                          //   image: const NetworkImage(
                          //       'https://images.unsplash.com/photo-1695425173758-37e9c23b962a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80'),
                          //   fit: BoxFit.cover,
                          //   height: 145,
                          //   width: 112,
                          // ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://images.unsplash.com/photo-1695425173758-37e9c23b962a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 44,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  index.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: secondary20,
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
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
