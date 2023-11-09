import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/firebase_options.dart';
import 'package:smart_rent/modules/detail/controllers/detail_controller.dart';
import 'package:smart_rent/modules/splash/views/splash_screen.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'core/enums/utilities.dart';
import 'package:zego_zim/zego_zim.dart';

import 'modules/rootView/views/root_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // firebaseInitialization.then((value) {
  //   Get.put(AuthController());
  //   Get.put(AuthMethods());
  // });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => DetailController());

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then(
  //   (value) => Get.put(AuthMethods()),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Rent House',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary98),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
