import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_popular_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePopularWidget extends StatelessWidget {
  const HomePopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePopularController controller = Get.put(HomePopularController());

    return Scaffold();
  }
}
