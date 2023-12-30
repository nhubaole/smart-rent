import 'package:flutter/material.dart';

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
