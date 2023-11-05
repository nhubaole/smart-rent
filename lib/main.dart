import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/firebase_options.dart';
import 'package:smart_rent/modules/detail/controllers/detail_controller.dart';
import 'package:smart_rent/modules/detail/views/detail_screen.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/post/views/post_screen.dart';
import 'package:smart_rent/modules/splash/views/splash_screen.dart';

import 'core/enums/utilities.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then(
  //   (value) => Get.put(AuthMethods()),
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  DetailController controller = Get.put(DetailController(
      room: Room(
          roomType: RoomType.APARTMENT,
          capacity: 2,
          gender: Gender.FEMALE,
          isRented: false,
          area: 20.5,
          deposit: 1000000,
          title: "CHDV Cao cấp Nguyễn Văn Linh, Quận 7",
          location:
              "41 đường số 11, phường Trường Thọ, thành phố Thủ Đức, thành phố Hồ Chí Minh",
          electricityCost: 2800,
          waterCost: 18000,
          parkingFee: 120000,
          internetCost: 0,
          description:
              "Sạch sẽ, an ninh, cung cấp nhiều dịch vụ tiện ích. Bạn tin được không? Chỉ với 20tr/ tháng đã có thể sở hữu CHDV cao cấp giữa trung tâm quận 7.",
          dateTime: "15/08/2023",
          utilities: [
        Utilities.AIR_CONDITIONER,
        Utilities.BED
      ],
          images: [
        "https://firebasestorage.googleapis.com/v0/b/flutter-rent-house-3f415.appspot.com/o/room_images%2F1698142312986.jpg?alt=media&token=41cfc883-8288-48d1-84ed-12a26ecc3115",
        "https://firebasestorage.googleapis.com/v0/b/flutter-rent-house-3f415.appspot.com/o/room_images%2F1698142318631.jpg?alt=media&token=01ff3bfe-a380-480b-be79-0a193f717d1e",
        "https://firebasestorage.googleapis.com/v0/b/flutter-rent-house-3f415.appspot.com/o/room_images%2F1698142320742.jpg?alt=media&token=4dff5464-a4f7-40ef-9947-b1187a63f705",
        "https://firebasestorage.googleapis.com/v0/b/flutter-rent-house-3f415.appspot.com/o/room_images%2F1698142324566.jpg?alt=media&token=889dfb03-7386-4a90-bec5-8be1f5fe6b2f",
        "https://firebasestorage.googleapis.com/v0/b/flutter-rent-house-3f415.appspot.com/o/room_images%2F1698142324566.jpg?alt=media&token=889dfb03-7386-4a90-bec5-8be1f5fe6b2f"
      ])));

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
      home: DetailScreen(),
    );
  }
}
