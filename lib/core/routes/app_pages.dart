import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/auth/login/bindings/login_binding.dart';
import 'package:smart_rent/modules/auth/login/views/login_screen.dart';
import 'package:smart_rent/modules/auth/signup/bindings/signup_binding.dart';
import 'package:smart_rent/modules/auth/signup/views/sign_up_screen.dart';
import 'package:smart_rent/modules/detail/bindings/detail_binding.dart';
import 'package:smart_rent/modules/detail/views/detail_screen.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';
import 'package:smart_rent/modules/splash/bindings/splash_binding.dart';
import 'package:smart_rent/modules/splash/views/splash_screen.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => const RootScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailScreen(),
      binding: DetailBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.detail,
    //   page: () => const DetailScreen(),
    //   binding: SignUpBinding(),
    // ),
    GetPage(
      name: AppRoutes.map,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
  ];
}
