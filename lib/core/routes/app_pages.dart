import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/auth/login/bindings/login_binding.dart';
import 'package:smart_rent/modules/auth/login/views/login_screen.dart';
import 'package:smart_rent/modules/auth/signup/bindings/signup_binding.dart';
import 'package:smart_rent/modules/auth/signup/views/sign_up_screen.dart';
import 'package:smart_rent/modules/contract/contract_binding.dart';
import 'package:smart_rent/modules/contract/contract_page.dart';
import 'package:smart_rent/modules/contract_info/contract_info_binding.dart';
import 'package:smart_rent/modules/contract_info/contract_info_page.dart';
import 'package:smart_rent/modules/detail/bindings/detail_binding.dart';
import 'package:smart_rent/modules/detail/views/detail_screen.dart';
import 'package:smart_rent/modules/contract_detail/contract_detail_binding.dart';
import 'package:smart_rent/modules/contract_detail/contract_detail_page.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/manage_electricity_water_index_binding.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/manage_electricity_water_index_page.dart';
import 'package:smart_rent/modules/manage_room/binding/detail_request_binding.dart';
import 'package:smart_rent/modules/manage_room/views/manage_room_screen.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/liked_room_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/posted_room_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/renting_room_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/request_rent_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/request_rent_v2_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/return_rent_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/bindings/wait_approve_binding.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/liked_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/posted_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/renting_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/request_rent.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/return_rent.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/v2/detail_request_rent_room_v2.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/v2/request_rent_v2.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/wait_approve_room.dart';
import 'package:smart_rent/modules/root_view/bindings/root_binding.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';
import 'package:smart_rent/modules/contract_sign/contract_sign_binding.dart';
import 'package:smart_rent/modules/contract_sign/contract_sign_page.dart';
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
      binding: RootBinding(),
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
    GetPage(
      name: AppRoutes.manageRoom,
      page: () => const ManageRoomScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.waitApprove,
      page: () => const WaitApproveRoomScreen(),
      binding: WaitApproveBinding(),
    ),
    GetPage(
      name: AppRoutes.likedRoom,
      page: () => const LikedRoomScreen(),
      binding: LikedRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.postedRoom,
      page: () => const PostedRoomScreen(),
      binding: PostedRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.rentingRoom,
      page: () => const RentingRoomScreen(),
      binding: RentingRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.requestRent,
      page: () => const RequestRentScreen(),
      binding: RequestRentBinding(),
    ),
    GetPage(
      name: AppRoutes.returnRent,
      page: () => const ReturnRentScreen(),
      binding: ReturnRentBinding(),
    ),
    GetPage(
      name: AppRoutes.requestRentV2,
      page: () => const RequestRentV2Screen(),
      binding: RequestRentV2Binding(),
    ),
    GetPage(
      name: AppRoutes.map,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.requestRequestRoomV2,
      page: () => const DetailRequestRentRoomV2(),
      binding: DetailRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.contract,
      page: () => const ContractPage(),
      binding: ContractBinding(),
    ),
    GetPage(
      name: AppRoutes.contractInfo,
      page: () => const ContractInfoPage(),
      binding: ContractInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.contractDetail,
      page: () => const DetailContractPage(),
      binding: ContractDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.contractSign,
      page: () => const ContractSignPage(),
      binding: ContractSignBinding(),
    ),
    GetPage(
      name: AppRoutes.manageElectricityWaterIndex,
      page: () => const ManageElectricityWaterIndexPage(),
      binding: ManageElectricityWaterIndexBinding(),
    ),
  ];
}
