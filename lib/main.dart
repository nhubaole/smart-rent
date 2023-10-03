import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/firebase_options.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/rootView/views/root_screen.dart';
import 'package:smart_rent/modules/splash/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) => Get.put(AuthMethods()),
  );
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              print('RootScreen');
              return const RootScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: primary98,
                ),
              ),
            );
          }

          print('SplashScreen');
          return const SplashScreen();
        },
      ),
      //home: const OnBoardingScreen(),
    );
  }
}
