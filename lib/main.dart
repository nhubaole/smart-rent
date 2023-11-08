import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_rent/auth_controller.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/firebase_contants.dart';
import 'package:smart_rent/firebase_options.dart';
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

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then(
  //   (value) => Get.put(AuthMethods()),
  // );

  ZIMAppConfig appConfig = ZIMAppConfig();
  appConfig.appID = 2063303228;
  appConfig.appSign =
      "31062f3e9c522cd6fe3a210405fe72306e0ee2e1f865e5289db26dfea5a608c3";

  ZIMKit().init(
    appID: 2063303228, // your appid
    appSign:
        "31062f3e9c522cd6fe3a210405fe72306e0ee2e1f865e5289db26dfea5a608c3", // your appSign
  );

  ZIM.create(appConfig);

  ZIMUserInfo userInfo = ZIMUserInfo();
  userInfo.userID = "0823306992"; //Fill in a String type value.
  userInfo.userName = "Lê Bảo Như"; //Fill in a String type value.

  ZIM.getInstance()?.login(userInfo).then((value) {
    print("Login successful");
  }).catchError((onError) {
    switch (onError.runtimeType) {
      //This will be triggered when login failed.
      case PlatformException:
        print(onError.code); //Return the error code when login failed.
        print(onError.message!); // Return the error indo when login failed.
        break;
      default:
    }
  });
  ZIMKit()
      .connectUser(id: userInfo.userID, name: userInfo.userName)
      .then((value) => null);

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
