import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_rent/auth_controller.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/firebase_contants.dart';
import 'package:smart_rent/firebase_options.dart';
import 'package:smart_rent/modules/rootView/views/root_screen.dart';
import 'package:smart_rent/modules/splash/views/splash_screen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInitialization.then((value) {
    Get.put(AuthController());
    Get.put(AuthMethods());
  });
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then(
  //   (value) => Get.put(AuthMethods()),
  // );

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
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
