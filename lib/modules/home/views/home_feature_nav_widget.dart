import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_feature_nav_controller.dart';
import 'package:smart_rent/modules/map/views/map_screen.dart';
import 'package:smart_rent/modules/post/views/post_screen.dart';
import 'package:smart_rent/modules/recently/views/recently_view.dart';

class HomeFeatureNavWidget extends StatelessWidget {
  const HomeFeatureNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put(HomeFeatureNavController());
    return Scaffold();
  }
}
