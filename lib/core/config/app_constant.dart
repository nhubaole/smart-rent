import 'package:flutter/material.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/room/util_item.dart';

abstract class AppConstant {
  static const app_name = 'Smart rent';
  //country_code_language
  static const viVN = 'vi_VN';
  static const enUS = 'en_US';

  //locate
  static const appSupportLocale = [Locale('vi', "VN"), Locale('en', "US")];

  // Hive
  static const hiveBoxName = 'smart_rent';
  static const hiveSessionKey = 'session';
  static const hiveRecentSearchRoomKey = 'recent_search_room';
  static const hiveFirstTimeInstall = 'first_time_install';


  // Debound timer
  static const debounceTime = 500;

  // Material Room Management
  static final gradientColor = [
    AppColors.primary40,
    AppColors.primary40,
    AppColors.primary40,
    AppColors.primary40,
    AppColors.primary40,
    AppColors.primary40,
    AppColors.primary40,
    AppColors.primary60,
    AppColors.primary95,
  ];


  // API
  // Authen
  static const authen = '/authen';
  static const authenLogin = '$authen/login';
  static const authenRegister = '$authen/register';
  static const authenVerifyOtp = '$authen/verify-otp';
  static const authenForgotPassword = '$authen/forgot-password';

  // User
  static const users = '/users';
  static const usersCurrentUser = '$users/current';

  // POST ROOM
  static const stepperPostRoom = [
    {
      'counter': 1,
      'isCompleted': false,
      'iconData': Icons.info_sharp,
      'title': 'Thông tin',
    },
    {
      'counter': 2,
      'isCompleted': false,
      'iconData': Icons.location_on_sharp,
      'title': 'Địa chỉ',
    },
    {
      'counter': 3,
      'isCompleted': false,
      'iconData': Icons.home_repair_service,
      'title': 'Tiện ích',
    },
    {
      'counter': 4,
      'isCompleted': false,
      'iconData': Icons.verified_outlined,
      'title': 'Xác nhận',
    },
  ];

  static const headerTextPostRoom = [
    'Địa chỉ',
    'Tiện ích',
    'Xác nhận',
    'Thông tin',
  ];

  static const untilitiesPostRoom = [
    UtilItem(utility: Utilities.WC, isChecked: false),
    UtilItem(utility: Utilities.WINDOW, isChecked: false),
    UtilItem(utility: Utilities.WIFI, isChecked: false),
    UtilItem(utility: Utilities.KITCHEN, isChecked: false),
    UtilItem(utility: Utilities.LAUNDRY, isChecked: false),
    UtilItem(utility: Utilities.FRIDGE, isChecked: false),
    UtilItem(utility: Utilities.PARKING, isChecked: false),
    UtilItem(utility: Utilities.SECURITY, isChecked: false),
    UtilItem(utility: Utilities.FLEXIBLE_HOURS, isChecked: false),
    UtilItem(utility: Utilities.PRIVATE, isChecked: false),
    UtilItem(utility: Utilities.LOFT, isChecked: false),
    UtilItem(utility: Utilities.PET, isChecked: false),
    UtilItem(utility: Utilities.BED, isChecked: false),
    UtilItem(utility: Utilities.WARDROBE, isChecked: false),
    UtilItem(utility: Utilities.AIR_CONDITIONER, isChecked: false)
  ];

  static const iconsPostRoom = [
    Icon(Icons.info_outline, color: Colors.white),
    Icon(Icons.location_on_outlined, color: Colors.white),
    Icon(Icons.extension_outlined, color: Colors.white),
    Icon(Icons.verified_outlined, color: Colors.white),
  ];

  static const minCountImages = 4;
  static const maxCountImages = 20;

  // Cache CacheImageWidget
  static const int maxHeightDiskCache = 200;
  static const int maxWidthDiskCache = 200;
  static const int memCacheHeight = 200;
  static const int memCacheWidth = 200;  


}
