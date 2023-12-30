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

    return Scaffold();
  }
}
